using MarmitonVanced.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Win32;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;

namespace MarmitonVanced.Controllers
{
    public class RecipeController(IConfiguration configuration) : Controller
    {
        public IActionResult Index()
        {
            List<Recipe> recipes = [];
            SqlConnection sqlConnection = new(configuration["ConnectionStrings:db"]);
            sqlConnection.Open();
            SqlCommand sqlCommand = new($"SELECT r.[id],r.[name],[time],[image],[type],[count],u.name,u.surname FROM [MarmitonVanced].[dbo].[Recipe] as r join [MarmitonVanced].[dbo].[User] as u on r.idUser = u.id", sqlConnection);
            SqlDataReader dr = sqlCommand.ExecuteReader();
            while (dr.Read())
            {
                recipes.Add(new()
                {
                    Id = dr.GetInt32(0),
                    Name = dr.GetString(1),
                    Time = dr.GetTimeSpan(2),
                    Image = "/images/" + dr.GetString(3),
                    Type = (RecipeType)Enum.Parse(typeof(RecipeType), dr.GetString(4)),
                    CountRecipe = dr.GetInt32(5),
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

        public IActionResult Create()
        {
            List<Object> res = [];
            List<Recipe> recipes = [];
            List<Ingredient> ingredients = [];
            recipes.Add(new()
            {
                Id = -1,
                Name = "Nouvelle recette",
                Time = new(0),
                Image = "",
                Type = RecipeType.Entrée,
                CountRecipe = 0,
            });
            int id = AccountController.GetIdUser(configuration["ConnectionStrings:db"]!, Request.Cookies["token"] ?? "");
            SqlConnection sqlConnection = new(configuration["ConnectionStrings:db"]);
            sqlConnection.Open();
            SqlCommand sqlCommand = new($"SELECT r.[id],r.[name],[time],[image],[type],[count],u.name,u.surname FROM [MarmitonVanced].[dbo].[Recipe] as r join [MarmitonVanced].[dbo].[User] as u on r.idUser = u.id where u.id = {id}", sqlConnection);
            SqlDataReader dr = sqlCommand.ExecuteReader();
            while (dr.Read())
            {
                recipes.Add(new()
                {
                    Id = dr.GetInt32(0),
                    Name = dr.GetString(1),
                    Time = dr.GetTimeSpan(2),
                    Image = "/images/" + dr.GetString(3),
                    Type = (RecipeType)Enum.Parse(typeof(RecipeType), dr.GetString(4)),
                    CountRecipe = dr.GetInt32(5),
                    Creator = new()
                    {
                        Name = dr.GetString(6),
                        Surname = dr.GetString(7),
                    }
                });
            }
            dr.Close();
            sqlCommand = new($"SELECT [id],[name],[typeQte] FROM [MarmitonVanced].[dbo].[Ingredient] order by [name]", sqlConnection);
            dr = sqlCommand.ExecuteReader();
            while (dr.Read())
            {
                ingredients.Add(new()
                {
                    Id = dr.GetInt32(0),
                    Name = dr.GetString(1),
                    Type = (TypeQuantity)Enum.Parse(typeof(TypeQuantity), dr.GetString(2))
                });
            }
            dr.Close();
            foreach (Recipe recipe in recipes)
            {
                sqlCommand = new($"SELECT [idIngredient],[qte] FROM [MarmitonVanced].[dbo].[IngredientUsed] where idRecipe ={recipe.Id}", sqlConnection);
                dr = sqlCommand.ExecuteReader();
                while (dr.Read())
                {
                    recipe.Ingredients.Add(ingredients.Single(ingredient => ingredient.Id == dr.GetInt32(0)));
                    recipe.Ingredients.Last().Quantity = dr.GetInt32(1);

                }
                dr.Close();
                sqlCommand = new($"SELECT [id],[desc],[pos]  FROM [MarmitonVanced].[dbo].[Step] where idRecipe = {recipe.Id}", sqlConnection);
                dr = sqlCommand.ExecuteReader();
                while (dr.Read())
                {
                    recipe.Steps.Add(new()
                    {
                        Id = dr.GetInt32(0),
                        Desc = dr.GetString(1),
                        Pos = dr.GetInt32(2),
                    });
                }
                recipe.Steps = recipe.Steps.OrderBy(recipeTemp => recipeTemp.Pos).ToList();
                dr.Close();
            }
            res.Add(recipes);
            res.Add(ingredients);
            sqlConnection.Close();
            return View(res);
        }

        public IActionResult Search(string search)
        {
            List<Recipe> recipes = [];
            SqlConnection sqlConnection = new(configuration["ConnectionStrings:db"]);
            sqlConnection.Open();
            SqlCommand sqlCommand = new($"SELECT r.[id],r.[name],[time],[image],[type],[count],u.name,u.surname FROM [MarmitonVanced].[dbo].[Recipe] as r join [MarmitonVanced].[dbo].[User] as u on r.idUser = u.id where r.name like '%{search}%'", sqlConnection);
            SqlDataReader dr = sqlCommand.ExecuteReader();
            while (dr.Read())
            {
                recipes.Add(new()
                {
                    Id = dr.GetInt32(0),
                    Name = dr.GetString(1),
                    Time = dr.GetTimeSpan(2),
                    Image = "/images/" + dr.GetString(3),
                    Type = (RecipeType)Enum.Parse(typeof(RecipeType), dr.GetString(4)),
                    CountRecipe = dr.GetInt32(5),
                    Creator = new()
                    {
                        Name = dr.GetString(6),
                        Surname = dr.GetString(7),
                    }
                });
            }
            dr.Close();
            sqlConnection.Close();
            return View("index", recipes);
        }

        public IActionResult Details(int id)
        {
            SqlConnection sqlConnection = new(configuration["ConnectionStrings:db"]);
            sqlConnection.Open();
            SqlCommand sqlCommand = new($"SELECT r.[id],r.[name],[time],[image],[type],[count],u.name,u.surname FROM [MarmitonVanced].[dbo].[Recipe] as r join [MarmitonVanced].[dbo].[User] as u on r.idUser = u.id where r.id = {id}\r\n", sqlConnection);
            SqlDataReader dr = sqlCommand.ExecuteReader();
            dr.Read();
            Recipe recipe = new()
            {
                Id = dr.GetInt32(0),
                Name = dr.GetString(1),
                Time = dr.GetTimeSpan(2),
                Image = "/images/" + dr.GetString(3),
                Type = (RecipeType)Enum.Parse(typeof(RecipeType), dr.GetString(4)),
                CountRecipe = dr.GetInt32(5),
                Creator = new()
                {
                    Name = dr.GetString(6),
                    Surname = dr.GetString(7),
                }
            };
            dr.Close();
            sqlCommand = new($"SELECT i.id, i.name,[qte],i.[typeQte] FROM [MarmitonVanced].[dbo].[IngredientUsed] as iu join [MarmitonVanced].[dbo].[Ingredient] as i on i.id = [idIngredient] where idRecipe = {id}", sqlConnection);
            dr = sqlCommand.ExecuteReader();
            while (dr.Read())
            {
                recipe.Ingredients.Add(
                    new()
                    {
                        Id = dr.GetInt32(0),
                        Name = dr.GetString(1),
                        Quantity = dr.GetInt32(2),
                        Type = (TypeQuantity)Enum.Parse(typeof(TypeQuantity), dr.GetString(3))
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

        public async Task<string> updateRecipe()
        {
            var rawRequestBody = await new StreamReader(Request.Body).ReadToEndAsync();
            JArray recipesObject = (JArray)JsonConvert.DeserializeObject(rawRequestBody)!;
            int id = AccountController.GetIdUser(configuration["ConnectionStrings:db"]!, Request.Cookies["token"] ?? "");

            SqlConnection sqlConnection = new(configuration["ConnectionStrings:db"]);
            sqlConnection.Open();
            foreach (JObject recipe in recipesObject)
            {
                SqlCommand sqlCommand;
                if (((JArray)recipe["Ingredients"]!).Count() > 0 && ((JArray)recipe["Steps"]!).Count() > 0)
                {

                    if ((int)(recipe["Id"]!) < 0)
                    {
                        sqlCommand = new($"INSERT INTO [dbo].[Recipe]([name],[time],[image],[idUser],[type],[count])VALUES('{recipe["Name"]}','{recipe["Time"]}','{recipe["Image"]}',{id},'{Enum.Parse(typeof(RecipeType), recipe["Type"]!.ToString())}',{recipe["CountRecipe"]})", sqlConnection);
                        sqlCommand.ExecuteNonQuery();
                        sqlCommand = new($"select [id] from [dbo].[Recipe] where [name]='{recipe["Name"]}' and [time]='{recipe["Time"]}' and [image]='{recipe["Image"]}' and [idUser]={id} and [type]='{Enum.Parse(typeof(RecipeType), recipe["Type"]!.ToString())}' and [count]={recipe["CountRecipe"]}", sqlConnection);
                        recipe["Id"] = (int)sqlCommand.ExecuteScalar();
                    }
                    else
                    {
                        sqlCommand = new($"UPDATE [dbo].[Recipe] SET [name] = '{recipe["Name"]}',[time] ='{recipe["Time"]}',[image] ='{recipe["Image"]}',[idUser] ={id},[type] ='{Enum.Parse(typeof(RecipeType), recipe["Type"]!.ToString())}',[count] ={recipe["CountRecipe"]} WHERE id= {recipe["Id"]}", sqlConnection);
                        sqlCommand.ExecuteNonQuery();
                    }
                    int maxpos = 0;
                        foreach (JObject steps in recipe["Steps"])
                    {
                        maxpos++;
                        sqlCommand = new($"SELECT COUNT(*) FROM [MarmitonVanced].[dbo].[Step] where idRecipe = {recipe["Id"]} and pos = {steps["Pos"]}", sqlConnection);
                        if ((int)sqlCommand.ExecuteScalar() == 1)
                        {
                            sqlCommand = new($"UPDATE [dbo].[Step] SET [desc] = '{steps["Desc"]}'  where idRecipe = {recipe["Id"]} and pos = {steps["Pos"]}", sqlConnection);
                            sqlCommand.ExecuteNonQuery();
                        }
                        else
                        {
                            sqlCommand = new($"INSERT INTO [dbo].[Step]([idRecipe],[desc],[pos]) VALUES ({recipe["Id"]},'{steps["Desc"]}',{steps["Pos"]})", sqlConnection);
                            sqlCommand.ExecuteNonQuery();
                        }
                    }
                    sqlCommand = new($"delete FROM [MarmitonVanced].[dbo].[Step] where idRecipe = {recipe["Id"]} and pos > {maxpos}", sqlConnection);
                    sqlCommand.ExecuteNonQuery();
                    sqlCommand = new($"delete FROM [MarmitonVanced].[dbo].[IngredientUsed] where [idRecipe] = {recipe["Id"]}", sqlConnection);
                    sqlCommand.ExecuteNonQuery();

                    foreach (JObject ingredient in recipe["Ingredients"])
                    {
                        sqlCommand = new($"INSERT INTO [dbo].[IngredientUsed]([idRecipe],[idIngredient],[qte]) VALUES ({recipe["Id"]},'{ingredient["Id"]}',{ingredient["Quantity"]})", sqlConnection);
                        sqlCommand.ExecuteNonQuery();
                    }
                }
            }
            sqlConnection.Close();

            return "validate";
        }

        public async Task<string> removeRecipe(int idRecipe)
        {
            int id = AccountController.GetIdUser(configuration["ConnectionStrings:db"]!, Request.Cookies["token"] ?? "");

            SqlConnection sqlConnection = new(configuration["ConnectionStrings:db"]);
            sqlConnection.Open();
            SqlCommand sqlCommand = new($"select count(*) from [dbo].[Recipe] where [id]={idRecipe} and [idUser]={id}", sqlConnection);

            if (0 == (int)sqlCommand.ExecuteScalar())
                return "";
            sqlCommand = new($"delete from [dbo].[Step] where [idRecipe]={idRecipe}", sqlConnection);
            sqlCommand.ExecuteNonQuery();
            sqlCommand = new($"delete from [dbo].[IngredientUsed] where [idRecipe]={idRecipe}", sqlConnection);
            sqlCommand.ExecuteNonQuery();
            sqlCommand = new($"delete from [dbo].[Recipe] where [id]={idRecipe}", sqlConnection);
            sqlCommand.ExecuteNonQuery();
            return "validate";
        }
    }
}
