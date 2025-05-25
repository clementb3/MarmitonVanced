using MarmitonVanced.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;

namespace MarmitonVanced.Controllers
{
    public class ArticleController(IConfiguration configuration) : Controller
    {
        public IActionResult Index()
        {
            int id = AccountController.GetIdUser(configuration["ConnectionStrings:db"]!, Request.Cookies["token"] ?? "");
            List<Ingredient> ingredients = [];
            SqlConnection sqlConnection = new(configuration["ConnectionStrings:db"]);
            sqlConnection.Open();
            SqlCommand sqlCommand = new($"SELECT i.[id],[name],[typeQte],[quantity],[price] FROM [MarmitonVanced].[dbo].[Ingredient] as i left join [MarmitonVanced].[dbo].[Article] as a on a.idIngredient = i.id where a.idUser = {id} or a.idUser is NULL", sqlConnection);
            SqlDataReader dr = sqlCommand.ExecuteReader();
            while (dr.Read())
            {
                ingredients.Add(new()
                {
                    Id = dr.GetInt32(0),
                    Name = dr.GetString(1),
                    Type = (TypeQuantity)Enum.Parse(typeof(TypeQuantity), dr.GetString(2)),
                });
                if (!dr.IsDBNull(4))
                {
                    ingredients.Last().Quantity = dr.GetInt32(3);
                    ingredients.Last().Price = dr.GetSqlMoney(4).ToDecimal();
                }
            }
            dr.Close();
            sqlConnection.Close();
            return View(ingredients);
        }

        public async Task<string> Update()
        {
            var rawRequestBody = await new StreamReader(Request.Body).ReadToEndAsync();
            JObject ingredientObject = (JObject)JsonConvert.DeserializeObject(rawRequestBody)!;
            int id = AccountController.GetIdUser(configuration["ConnectionStrings:db"]!, Request.Cookies["token"] ?? "");
            SqlConnection sqlConnection = new(configuration["ConnectionStrings:db"]);
            sqlConnection.Open();
            SqlCommand sqlCommand = new($"SELECT COUNT(*) FROM [MarmitonVanced].[dbo].[Article] where [idUser]={id} and [idIngredient]={ingredientObject["id"]}", sqlConnection);

            if ((int) sqlCommand.ExecuteScalar() == 0)
            {
                sqlCommand = new($"INSERT INTO [dbo].[Article] ([idUser],[idIngredient],[quantity],[price]) VALUES ({id},{ingredientObject["id"]},{ingredientObject["quantity"]},{ingredientObject["price"]})", sqlConnection);
                sqlCommand.ExecuteNonQuery();
            }
            else
            {
                sqlCommand = new($"UPDATE [dbo].[Article] SET [quantity] = {ingredientObject["quantity"]},[price] = {ingredientObject["price"]} WHERE [idUser]={id} and [idIngredient] ={ingredientObject["id"]}", sqlConnection);
                sqlCommand.ExecuteNonQuery();

            }
            sqlConnection.Close();

            return "validate";
        }
    }
}
