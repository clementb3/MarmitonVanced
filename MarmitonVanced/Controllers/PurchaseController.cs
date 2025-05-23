using MarmitonVanced.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;

namespace MarmitonVanced.Controllers
{
    public class PurchaseController(IConfiguration configuration) : Controller
    {
        public async Task<IActionResult> Index()
        {
            var rawRequestBody = await new StreamReader(Request.Body).ReadToEndAsync();
            JArray ingredientObject = (JArray)JsonConvert.DeserializeObject(rawRequestBody)!;
            int id = AccountController.GetIdUser(configuration["ConnectionStrings:db"]!, Request.Cookies["token"] ?? "");
            List<Stock> stocks = [];
            SqlConnection sqlConnection = new(configuration["ConnectionStrings:db"]);
            sqlConnection.Open();
            SqlCommand sqlCommand = new($"SELECT i.name, sum(iu.qte) as qte, i.[typeQte] FROM [MarmitonVanced].[dbo].[Schedule] as s join [MarmitonVanced].[dbo].[recipe] as r on s.idRecipe = r.id join [MarmitonVanced].[dbo].[IngredientUsed] as iu on r.id = iu.idRecipe join [MarmitonVanced].[dbo].[Ingredient] as i on iu.idIngredient = i.id  where s.idUser = 8 group by i.name, i.[typeQte]", sqlConnection);
            SqlDataReader dr = sqlCommand.ExecuteReader();
            while (dr.Read())
            {
                stocks.Add(new()
                {
                    IngredientStock = new()
                    {
                        Name = dr.GetString(0),
                        Type = (TypeQuantity)Enum.Parse(typeof(TypeQuantity), dr.GetString(2)),
                    },
                    Quantity = dr.GetInt32(1)
                });
            }
            dr.Close();
            sqlConnection.Close();
            return View(stocks);
        }
    }
}
