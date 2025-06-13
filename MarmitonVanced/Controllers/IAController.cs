using MarmitonVanced.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Text.Json;
using MarmitonVanced.Abstract;

namespace MarmitonVanced.Controllers
{
    public class IAController(IConfiguration configuration, IIaService iaService) : Controller
    {
        public IActionResult Index()
        {
            int id = AccountController.GetIdUser(configuration["ConnectionStrings:db"]!, Request.Cookies["token"] ?? "");
            List<Recipe> recipes = [];
            List<Prompt> prompts = [];
            SqlConnection sqlConnection = new(configuration["ConnectionStrings:db"]);
            sqlConnection.Open();
            SqlCommand sqlCommand = new($"SELECT [id],[name] FROM [MarmitonVanced].[dbo].[Recipe]", sqlConnection);
            SqlDataReader dr = sqlCommand.ExecuteReader();
            while (dr.Read())
            {
                recipes.Add(new()
                {
                    Id = dr.GetInt32(0),
                    Name = dr.GetString(1),
                });
            }
            dr.Close();
            sqlCommand = new($"SELECT [id],[request],[response],[userId] FROM [MarmitonVanced].[dbo].[Prompt] where userId = {id}", sqlConnection);
            dr = sqlCommand.ExecuteReader();
            while (dr.Read())
            {
                prompts.Add(new()
                {
                    Id = dr.GetInt32(0),
                    Request = dr.GetString(1),
                    Recipes = [.. recipes.Where(recipe => dr.GetString(2).Split(",").Contains(recipe.Id.ToString()))]
                });
            }
            dr.Close();
            sqlConnection.Close();
            return View(prompts);
        }

        public async Task<string> RequestIa()
        {
            var rawRequestBody = await new StreamReader(Request.Body).ReadToEndAsync();
            JObject requestObject = (JObject)JsonConvert.DeserializeObject(rawRequestBody)!;
            int id = AccountController.GetIdUser(configuration["ConnectionStrings:db"]!, Request.Cookies["token"] ?? "");
            string request = requestObject["request"]!.ToString();
            SqlConnection sqlConnection = new(configuration["ConnectionStrings:db"]);
            sqlConnection.Open();
            List<Recipe> recipes = [];
            SqlCommand sqlCommand = new($"SELECT [id],[name] FROM [MarmitonVanced].[dbo].[Recipe]", sqlConnection);
            SqlDataReader dr = sqlCommand.ExecuteReader();
            while (dr.Read())
            {
                recipes.Add(new()
                {
                    Id = dr.GetInt32(0),
                    Name = dr.GetString(1),
                });
            }
            dr.Close();
            Prompt prompt = new()
            {
                Request = request,
                Recipes = [.. recipes.Where(recipe => iaService.GetRecipes(request).Contains(recipe.Id))],
            };
            sqlCommand = new($"INSERT INTO [dbo].[Prompt]([request],[response],[userId]) VALUES('{request}','{String.Join(",", prompt.Recipes.Select(recipe => recipe.Id))}',{id})", sqlConnection);
            sqlCommand.ExecuteNonQuery();
            sqlConnection.Close();
            return System.Text.Json.JsonSerializer.Serialize(prompt.Recipes);
        }
    }
}
