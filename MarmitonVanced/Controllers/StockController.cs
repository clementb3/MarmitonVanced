using MarmitonVanced.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using Microsoft.IdentityModel.Tokens;

namespace MarmitonVanced.Controllers
{
    public class StockController(IConfiguration configuration) : Controller
    {
        public IActionResult Index()
        {
            int id = AccountController.GetIdUser(configuration["ConnectionStrings:db"]!, Request.Cookies["token"] ?? "");
            List<object> res = [];
            List<Stock> stocks = [];
            List<Ingredient> ingredients = [];
            SqlConnection sqlConnection = new(configuration["ConnectionStrings:db"]);
            sqlConnection.Open();
            SqlCommand sqlCommand = new($"SELECT [id],[name],[typeQte] FROM [MarmitonVanced].[dbo].[Ingredient] order by [name]", sqlConnection);
            SqlDataReader dr = sqlCommand.ExecuteReader();
            while (dr.Read())
            {
                ingredients.Add(new()
                {
                    Id = dr.GetInt32(0),
                    Name = dr.GetString(1),
                    Type = (TypeQuantity)Enum.Parse(typeof(TypeQuantity), dr.GetString(2))
                });
            }
            res.Add(ingredients);
            dr.Close();
            sqlCommand = new($"SELECT [id],[idIngredient],[qte] FROM [MarmitonVanced].[dbo].[Stock] where [idUser] = {id}", sqlConnection);
            dr = sqlCommand.ExecuteReader();
            while (dr.Read())
            {
                stocks.Add(new()
                {
                    Id = dr.GetInt32(0),
                    IngredientStock = ingredients.Single(ingredient => ingredient.Id == dr.GetInt32(1)),
                    Quantity = dr.GetInt32(2)
                });
            }
            res.Add(stocks);
            dr.Close();
            sqlConnection.Close();
            return View(res);
        }

        public async Task<string> Update()
        {
            var rawRequestBody = await new StreamReader(Request.Body).ReadToEndAsync();
            JArray ingredientObject = (JArray)JsonConvert.DeserializeObject(rawRequestBody)!;
            int id = AccountController.GetIdUser(configuration["ConnectionStrings:db"]!, Request.Cookies["token"] ?? "");
            SqlConnection sqlConnection = new(configuration["ConnectionStrings:db"]);
            sqlConnection.Open();
            SqlCommand sqlCommand = new($"delete FROM [MarmitonVanced].[dbo].[Stock] where idUser={id}", sqlConnection);
            sqlCommand.ExecuteNonQuery();
            string commande = "";
            foreach (JObject ingredient in ingredientObject.Cast<JObject>())
            {
                if (int.Parse(ingredient["qte"]!.ToString()) != 0)
                    commande += $"({id},{ingredient["id"]},{ingredient["qte"]}),";
            }
            commande = commande[..^1];
            sqlCommand = new($"INSERT INTO [MarmitonVanced].[dbo].[Stock]([idUser],[idIngredient],[qte]) VALUES {commande}", sqlConnection);
            sqlCommand.ExecuteNonQuery();
            sqlConnection.Close();

            return "validate";
        }

        public async Task<string> addIngredient()
        {
            var rawRequestBody = await new StreamReader(Request.Body).ReadToEndAsync();
            JObject ingredientObject = (JObject)JsonConvert.DeserializeObject(rawRequestBody)!;
            SqlConnection sqlConnection = new(configuration["ConnectionStrings:db"]);
            sqlConnection.Open();
            SqlCommand sqlCommand = new($"INSERT INTO [dbo].[Ingredient] ([name],[typeQte])VALUES('{ingredientObject["name"]}','{ingredientObject["type"]}')", sqlConnection);
            sqlCommand.ExecuteNonQuery();
            sqlConnection.Close();

            return "validate";
        }
    }
}
