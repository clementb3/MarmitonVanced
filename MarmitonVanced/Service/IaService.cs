using MarmitonVanced.Abstract;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium;
using System;
using MarmitonVanced.Models;
using Microsoft.Data.SqlClient;
using System.Xml.Linq;
using Microsoft.Identity.Client;
using System.Text.RegularExpressions;
using System.Text.Json;

namespace MarmitonVanced.Service
{
    public class IaService : IIaService
    {
        private readonly List<string> StopWord = JsonSerializer.Deserialize<List<string>>(File.ReadAllText("stop_words_french.json"))!;
        private List<Recipe> Recipes = [];

        public List<int> GetRecipes(string request)
        {
            UpdateRecettes();
            request = request.ToLower();
            string promptTemp = Regex.Replace(request, @"[^\p{L}\s]", "");

            string[] mots = promptTemp.Split(' ', StringSplitOptions.RemoveEmptyEntries);

            List<string> motsCles = [.. mots
                .Where(m => !StopWord.Contains(m))
                .Select(m => m.ToLower())
                .Select(m => m.EndsWith('s') && m.Length > 1 ? m[..^1] : m)
                .Distinct()];

            List<Recipe> recipesScored = GetScores(motsCles, request);

            return [.. recipesScored.Select(recipe => recipe.Id).Take(15)];
        }

        private List<Recipe> GetScores(List<string> motsCles, string prompt)
        {
            TimeWords timeWord = JsonSerializer.Deserialize<TimeWords>(File.ReadAllText("wordTime.json"))!;


            List<Recipe> recipes = [.. Recipes];
            if (motsCles.Exists(mot => mot.Contains("minute", StringComparison.CurrentCultureIgnoreCase)))
            {
                int pos = prompt.Split(" ").ToList().IndexOf(prompt.Split(" ").ToList().FirstOrDefault(word => word.Contains("minute", StringComparison.CurrentCultureIgnoreCase) || word.Contains("minutes", StringComparison.CurrentCultureIgnoreCase))!);
                if (pos > 0)
                    if (int.TryParse(prompt.Split(" ").ToList()[pos - 1], out int time))
                    {
                        recipes = [.. recipes.Where(recetteTime => recetteTime.Time.TotalMinutes < time)];
                    }
                var t = prompt.Split(" ").ToList()[pos - 1];
            }
            else
            {
                int countShort = timeWord.Short.Count(m => motsCles.Contains(m));
                int countMedium = timeWord.Medium.Count(m => motsCles.Contains(m));
                int countLong = timeWord.Long.Count(m => motsCles.Contains(m));
                if (countShort > 0 || countMedium > 0 || countLong > 0)
                {
                    if (countShort > countMedium && countShort > countLong)
                        recipes = [.. recipes.Where(recetteTime => recetteTime.Time.TotalMinutes <= 20)];
                    else if (countLong > countShort && countLong > countMedium)
                        recipes = [.. recipes.Where(recetteTime => recetteTime.Time.TotalMinutes > 40)];
                    else
                        recipes = [.. recipes.Where(recetteTime => recetteTime.Time.TotalMinutes > 20 && recetteTime.Time.TotalMinutes <= 40)];
                }
            }
            if (motsCles.Contains("dessert") || motsCles.Contains("desserts"))
                recipes = [.. recipes.Where(recetteTime => recetteTime.Type == RecipeType.Dessert)];
            if (motsCles.Contains("entrée") || motsCles.Contains("entré") || motsCles.Contains("entree") || motsCles.Contains("entre") || motsCles.Contains("entrées") || motsCles.Contains("entrés") || motsCles.Contains("entrees") || motsCles.Contains("entres"))
                recipes = [.. recipes.Where(recetteTime => recetteTime.Type == RecipeType.Entrée)];
            if (motsCles.Contains("plat") || motsCles.Contains("plats"))
                recipes = [.. recipes.Where(recetteTime => recetteTime.Type == RecipeType.Plat)];
            recipes = [.. recipes
                .Select(recipe => new
                {
                    Recette = recipe,
                    Score = motsCles.Count(word => recipe.Description.Contains(word, StringComparison.CurrentCultureIgnoreCase))
                })
                .Where(recipe => recipe.Score > 0)
                .OrderByDescending(recipe => recipe.Score)
                .Select(recipe => recipe.Recette)];
            return recipes;
        }

        private void UpdateRecettes()
        {
            List<Recipe> recipes = [];
            SqlConnection sqlConnection = new("Server=localhost;Database=MarmitonVanced;Trusted_Connection=True;");
            sqlConnection.Open();
            SqlCommand sqlCommand = new($"SELECT r.[id],r.[name],[time],[image],[type],[count],u.name,u.surname,(r.[name]+' '+STRING_AGG( i.name,' ')) as details FROM [MarmitonVanced].[dbo].[Recipe] as r join [MarmitonVanced].[dbo].[User] as u on r.idUser = u.id join [MarmitonVanced].[dbo].[IngredientUsed] as iu on iu.idRecipe = r.id join [MarmitonVanced].[dbo].[Ingredient] as i on iu.idIngredient = i.id group by r.[id],r.[name],[time],[image],[type],[count],u.name,u.surname,r.[name]", sqlConnection);
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
                    Description = dr.GetString(8)
                });
            }
            dr.Close();
            sqlConnection.Close();
            Recipes = recipes;
        }
    }
}
