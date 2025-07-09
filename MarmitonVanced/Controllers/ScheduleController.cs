using MarmitonVanced.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using Microsoft.IdentityModel.Tokens;

namespace MarmitonVanced.Controllers
{
    public class ScheduleController(IConfiguration configuration) : Controller
    {
        public IActionResult Index()
        {
            int id = AccountController.GetIdUser(configuration["ConnectionStrings:db"]!, Request.Cookies["token"] ?? "");
            if (id == -1)
            {
                Response.Redirect(configuration["url"] + "/recipe?error=auth");
            }
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
                });
            }
            dr.Close();
            string data = "";
            List<DateTime> dates = [];
            sqlCommand = new($"SELECT [date] FROM [MarmitonVanced].[dbo].[Schedule] where idUser={id} group by [date]", sqlConnection);
            dr = sqlCommand.ExecuteReader();
            while (dr.Read())
                dates.Add(dr.GetDateTime(0));
            dr.Close();
            foreach (DateTime date in dates)
            {
                data += "schedule[\"" + DateOnly.FromDateTime(date).ToString() + "h" + date.Hour + "\"] = ";
                List<int> entries = [];
                List<int> plats = [];
                List<int> desserts = [];
                sqlCommand = new($"SELECT s.[idRecipe],r.[type] FROM [MarmitonVanced].[dbo].[Schedule] as s join Recipe as r on r.id =s.idRecipe where s.idUser={id} and s.[date] ='{date}'", sqlConnection);
                dr = sqlCommand.ExecuteReader();
                while (dr.Read())
                {
                    if (dr.GetString(1) == "Entrée")
                        entries.Add(dr.GetInt32(0));
                    if (dr.GetString(1) == "Plat")
                        plats.Add(dr.GetInt32(0));
                    if (dr.GetString(1) == "Dessert")
                        desserts.Add(dr.GetInt32(0));
                }
                dr.Close();
                data += "[" + JsonConvert.SerializeObject(entries) + "," + JsonConvert.SerializeObject(plats) + "," + JsonConvert.SerializeObject(desserts) + "];";
            }
            recipes.Add(new()
            {
                Id = -1,
                Type = RecipeType.data,
                Image = data
            });
            sqlConnection.Close();
            return View(recipes);
        }


        public async Task<string> Update()
        {
            var rawRequestBody = await new StreamReader(Request.Body).ReadToEndAsync();
            JArray scheduleObject = (JArray)JsonConvert.DeserializeObject(rawRequestBody)!;
            int id = AccountController.GetIdUser(configuration["ConnectionStrings:db"]!, Request.Cookies["token"] ?? "");
            SqlConnection sqlConnection = new(configuration["ConnectionStrings:db"]);
            sqlConnection.Open();
            SqlCommand sqlCommand = new($"delete FROM [MarmitonVanced].[dbo].[Schedule] where idUser={id}", sqlConnection);
            sqlCommand.ExecuteNonQuery();
            string commande = "";
            foreach (JObject schedule in scheduleObject.Cast<JObject>())
            {
                DateTime date = DateTime.Parse(schedule.ToString().Split("\"")[1].Split("h")[0] + " " + schedule.ToString().Split("h")[1].Split("\"")[0] + ":00:00");
                List<int> entries = [.. schedule.ToString().Split("[")[2].Split("]")[0].Replace("\"", "").Replace("\r", "").Replace("\n", "").Replace(" ", "").Split(",").Where(number => !String.IsNullOrEmpty(number)).Select(number => int.Parse(number)).Distinct()];
                List<int> plats = [.. schedule.ToString().Split("[")[3].Split("]")[0].Replace("\"", "").Replace("\r", "").Replace("\n", "").Replace(" ", "").Split(",").Where(number => !String.IsNullOrEmpty(number)).Select(number => int.Parse(number)).Distinct()];
                List<int> desserts = [.. schedule.ToString().Split("[")[4].Split("]")[0].Replace("\"", "").Replace("\r", "").Replace("\n", "").Replace(" ", "").Split(",").Where(number => !String.IsNullOrEmpty(number)).Select(number => int.Parse(number)).Distinct()];
                foreach (int idRecipe in entries.Concat(plats).Concat(desserts))
                {
                    commande += $"({idRecipe},{id},'{date}'),";
                }
            }
            commande = commande[..^1];
            sqlCommand = new($"INSERT INTO [dbo].[Schedule] ([idRecipe] ,[idUser] ,[date]) VALUES {commande}", sqlConnection);
            sqlCommand.ExecuteNonQuery();
            sqlConnection.Close();

            return "vlidate";
        }

    }
}
