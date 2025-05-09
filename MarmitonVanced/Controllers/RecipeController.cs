using MarmitonVanced.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;

namespace MarmitonVanced.Controllers
{
    public class RecipeController(IConfiguration configuration) : Controller
    {
        public IActionResult Index()
        {
            List<Recipe> recipes = [];
            SqlConnection sqlConnection = new(configuration["ConnectionStrings:db"]);
            sqlConnection.Open();
            SqlCommand sqlCommand = new($"SELECT r.[id],r.[name],[time],[image],[type],[description],u.name,u.surname FROM [MarmitonVanced].[dbo].[Recipe] as r join [MarmitonVanced].[dbo].[User] as u on r.idUser = u.id\r\n", sqlConnection);
            SqlDataReader dr = sqlCommand.ExecuteReader();
            while (dr.Read())
            {
                recipes.Add(new()
                {
                    Id = dr.GetInt32(0),
                    Name = dr.GetString(1),
                    Time = dr.GetTimeSpan(2),
                    Image = "/images/" + dr.GetString(3),
                    Type = dr.GetString(4),
                    Description = dr.GetString(5),
                    Creator = new()
                    {
                        Name = dr.GetString(6),
                        Surname = dr.GetString(7),
                    }
                });
            }
            dr.Close();
            sqlConnection.Close();
            return View(recipes);
        }

        public IActionResult Details(int id)
        {
            SqlConnection sqlConnection = new(configuration["ConnectionStrings:db"]);
            sqlConnection.Open();
            SqlCommand sqlCommand = new($"SELECT r.[id],r.[name],[time],[image],[type],[description],u.name,u.surname FROM [MarmitonVanced].[dbo].[Recipe] as r join [MarmitonVanced].[dbo].[User] as u on r.idUser = u.id where r.id = {id}\r\n", sqlConnection);
            SqlDataReader dr = sqlCommand.ExecuteReader();
            dr.Read();
            Recipe recipe = new()
            {
                Id = dr.GetInt32(0),
                Name = dr.GetString(1),
                Time = dr.GetTimeSpan(2),
                Image = "/images/" + dr.GetString(3),
                Type = dr.GetString(4),
                Description = dr.GetString(5),
                Creator = new()
                {
                    Name = dr.GetString(6),
                    Surname = dr.GetString(7),
                }
            };
            dr.Close();
            sqlCommand = new($"SELECT i.id, i.name,[qte], i.image FROM [MarmitonVanced].[dbo].[IngredientUsed] as iu join [MarmitonVanced].[dbo].[Ingredient] as i on i.id = idIgredient where idRecipe = {id}\r\n", sqlConnection);
            dr = sqlCommand.ExecuteReader();
            while (dr.Read())
            {
                recipe.Ingredients.Add(
                    new()
                    {
                        Id = dr.GetInt32(0),
                        Name = dr.GetString(1),
                        Quantity = dr.GetString(2),
                        Image = "/images/" + dr.GetString(3)
                    });
            }
            dr.Close();

            sqlCommand = new($"SELECT [id],[desc],[pos] FROM [MarmitonVanced].[dbo].[Step] where idRecipe = {id}\r\n", sqlConnection);
            dr = sqlCommand.ExecuteReader();
            while (dr.Read())
            {
                recipe.Steps.Add(
                    new()
                    {
                        Id = dr.GetInt32(0),
                        Desc = dr.GetString(1),
                        Pos = dr.GetInt32(2),
                    });
            }
            dr.Close();
            recipe.Steps = [.. recipe.Steps.OrderBy(step => step.Pos)];
            sqlConnection.Close();
            return View(recipe);
        }
    }
}
