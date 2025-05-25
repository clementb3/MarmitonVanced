using MarmitonVanced.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Linq;

namespace MarmitonVanced.Controllers
{
    public class PurchaseController(IConfiguration configuration) : Controller
    {
        public async Task<IActionResult> Index()
        {
            var rawRequestBody = await new StreamReader(Request.Body).ReadToEndAsync();
            JArray ingredientObject = (JArray)JsonConvert.DeserializeObject(rawRequestBody)!;
            int id = AccountController.GetIdUser(configuration["ConnectionStrings:db"]!, Request.Cookies["token"] ?? "");
            List<Purchase> purchases = [];
            List<Stock> stocks = [];
            SqlConnection sqlConnection = new(configuration["ConnectionStrings:db"]);
            sqlConnection.Open();

            SqlCommand sqlCommand = new($"SELECT [id],[idIngredient],[qte] FROM [MarmitonVanced].[dbo].[Stock] where [idUser]= {id}", sqlConnection);
            SqlDataReader dr = sqlCommand.ExecuteReader();
            while (dr.Read())
            {
                stocks.Add(new()
                {
                    Id = dr.GetInt32(0),
                    IngredientStock = new() { Id = dr.GetInt32(1) },
                    Quantity = dr.GetInt32(2)
                });
            }
            dr.Close();
            sqlCommand = new($"SELECT i.id, i.name, iu.qte, i.[typeQte],r.[name] FROM [MarmitonVanced].[dbo].[Schedule] as s join [MarmitonVanced].[dbo].[recipe] as r on s.idRecipe = r.id join [MarmitonVanced].[dbo].[IngredientUsed] as iu on r.id = iu.idRecipe join [MarmitonVanced].[dbo].[Ingredient] as i on iu.idIngredient = i.id  where s.idUser = {id} and s.[date]>= GETDATE() order by i.id", sqlConnection);
            dr = sqlCommand.ExecuteReader();
            while (dr.Read())
            {
                if (!purchases.Exists(purchase => purchase.Id == dr.GetInt32(0)))
                {
                    purchases.Add(new()
                    {
                        Id = dr.GetInt32(0),
                        Name = dr.GetString(1),
                        Quantity = dr.GetInt32(2) - (stocks.SingleOrDefault(stock => stock.IngredientStock.Id == dr.GetInt32(0))?.Quantity ?? 0),
                        Type = (TypeQuantity)Enum.Parse(typeof(TypeQuantity), dr.GetString(3))
                    });
                    Stock? stock = stocks.SingleOrDefault(stock => stock.IngredientStock.Id == dr.GetInt32(0));
                    if (stock != null)
                        purchases.Last().Recipes.Add($"Stock - {stock.Quantity}{dr.GetString(3)}");
                    purchases.Last().Recipes.Add($"{dr.GetString(4)} - {dr.GetInt32(2)}{dr.GetString(3)}");
                }
                else
                {
                    Purchase purchase = purchases.Single(purchase => purchase.Id == dr.GetInt32(0));
                    purchase.Quantity += dr.GetInt32(2);
                    purchase.Recipes.Add($"{dr.GetString(4)} - {dr.GetInt32(2)}{dr.GetString(3)}");
                }
            }
            dr.Close();
            purchases = [.. purchases.Where(purchase => purchase.Quantity > 0)];
            purchases = [.. purchases.OrderBy(purchase => purchase.Name)];
            sqlCommand = new($"SELECT i.[id],[name],[typeQte],[quantity],[price] FROM [MarmitonVanced].[dbo].[Ingredient] as i join [MarmitonVanced].[dbo].[Article] as a on a.idIngredient = i.id where a.idUser = 9 or a.idUser is NULL", sqlConnection);
            dr = sqlCommand.ExecuteReader();
            while (dr.Read())
            {
                Ingredient ingredients = new()
                {
                    Id = dr.GetInt32(0),
                    Name = dr.GetString(1),
                    Type = (TypeQuantity)Enum.Parse(typeof(TypeQuantity), dr.GetString(2)),
                    Quantity = dr.GetInt32(3),
                    Price = dr.GetSqlMoney(4).ToDecimal()
                };
                Purchase? purchase = purchases.SingleOrDefault(purchase => purchase.Id == dr.GetInt32(0));
                if (purchase != null)
                {
                    purchase.Price = Math.Ceiling((decimal)purchase.Quantity / ingredients.Quantity) * ingredients.Price;
                    purchase.Name = Math.Ceiling((decimal)purchase.Quantity / ingredients.Quantity) + " x " + purchase.Name;
                }
            }
            dr.Close();
            sqlConnection.Close();

            return View(purchases);
        }

        public async Task<string> Update()
        {
            var rawRequestBody = await new StreamReader(Request.Body).ReadToEndAsync();
            List<string> idRecipes = rawRequestBody.Split(",").ToList();
            int id = AccountController.GetIdUser(configuration["ConnectionStrings:db"]!, Request.Cookies["token"] ?? "");
            List<Purchase> purchases = [];
            SqlConnection sqlConnection = new(configuration["ConnectionStrings:db"]);
            sqlConnection.Open();
            SqlCommand sqlCommand = new($"SELECT i.id, sum(iu.qte) as qte FROM [MarmitonVanced].[dbo].[Schedule] as s join [MarmitonVanced].[dbo].[recipe] as r on s.idRecipe = r.id join [MarmitonVanced].[dbo].[IngredientUsed] as iu on r.id = iu.idRecipe join [MarmitonVanced].[dbo].[Ingredient] as i on iu.idIngredient = i.id  where s.idUser = {id} and s.[date]>= GETDATE() group by i.id", sqlConnection);
            SqlDataReader dr = sqlCommand.ExecuteReader();
            while (dr.Read())
            {
                if (idRecipes.Contains(dr.GetInt32(0).ToString()))
                {

                    purchases.Add(new()
                    {
                        Id = dr.GetInt32(0),
                        Quantity = dr.GetInt32(1)
                    });
                }
            }
            dr.Close();
            foreach (Purchase purchase in purchases)
            {
                sqlCommand = new($"SELECT [qte] FROM [MarmitonVanced].[dbo].[Stock] where [id]={purchase.Id} and [idUser]={id}", sqlConnection);
                int Quantity = (int?)sqlCommand.ExecuteScalar() ?? 0;
                sqlCommand = new($"INSERT INTO [dbo].[Stock]([idUser],[idIngredient],[qte]) VALUES ({id},{purchase.Id},{purchase.Quantity + Quantity})", sqlConnection);
                sqlCommand.ExecuteNonQuery();
            }
            sqlConnection.Close();

            return "validate";
        }
    }
}
