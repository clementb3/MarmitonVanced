using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Threading.Tasks;
using System.Text;
using System.Security.Cryptography;
using Microsoft.Data.SqlClient;

namespace MarmitonVanced.Controllers
{
    public class AccountController(IConfiguration configuration) : Controller
    {
        public async Task<string> CreateAccount()
        {
            var rawRequestBody = await new StreamReader(Request.Body).ReadToEndAsync();
            JObject accountObject = (JObject)JsonConvert.DeserializeObject(rawRequestBody)!;
            accountObject["password"] = Sha256Hash(accountObject["password"]!.ToString());
            SqlConnection sqlConnection = new(configuration["ConnectionStrings:db"]);
            sqlConnection.Open();
            SqlCommand sqlCommand = new($"INSERT INTO [dbo].[User] ([name],[surname],[mail],[password],[state]) VALUES ('{accountObject["name"]}','{accountObject["surname"]}','{accountObject["mail"]}','{accountObject["password"]}','wait'); select id from [dbo].[User] where [mail]='{accountObject["mail"]}'", sqlConnection);
            int id = (int)sqlCommand.ExecuteScalar();
            string token = Convert.ToBase64String(Guid.NewGuid().ToByteArray());
            sqlCommand = new($"INSERT INTO [dbo].[Token] ([idUser],[token]) VALUES ({id},'{token}')", sqlConnection);
            sqlCommand.ExecuteNonQuery();
            sqlConnection.Close();

            return token;
        }

        public async Task<string> ConnectAccount()
        {
            var rawRequestBody = await new StreamReader(Request.Body).ReadToEndAsync();
            JObject accountObject = (JObject)JsonConvert.DeserializeObject(rawRequestBody)!;
            accountObject["password"] = Sha256Hash(accountObject["password"]!.ToString());
            SqlConnection sqlConnection = new(configuration["ConnectionStrings:db"]);
            sqlConnection.Open();
            SqlCommand sqlCommand = new($"select id from [dbo].[User] where [mail]='{accountObject["mail"]}' and [password]='{accountObject["password"]}'", sqlConnection);
            int? id = (int?)sqlCommand.ExecuteScalar();
            if (id == null)
                return "error : mauvais identifiant";
            string token = Convert.ToBase64String(Guid.NewGuid().ToByteArray());
            sqlCommand = new($"INSERT INTO [dbo].[Token] ([idUser],[token]) VALUES ({id},'{token}')", sqlConnection);
            sqlCommand.ExecuteNonQuery();
            sqlConnection.Close();

            return token;
        }

        public void Deconnect()
        {
            SqlConnection sqlConnection = new(configuration["ConnectionStrings:db"]);
            sqlConnection.Open();
            SqlCommand sqlCommand = new($"delete [MarmitonVanced].[dbo].[Token] where token='{Request.Cookies["token"].Replace("\"","") ?? ""}'", sqlConnection);
            sqlCommand.ExecuteNonQuery();
            sqlConnection.Close();
        }


        private static String Sha256Hash(String value)
        {
            StringBuilder Sb = new();
            Encoding enc = Encoding.UTF8;
            Byte[] result = SHA256.HashData(enc.GetBytes(value));

            foreach (Byte b in result)
                Sb.Append(b.ToString("x2"));

            return Sb.ToString();
        }

        public static int GetIdUser(string connectionString, string token)
        {
            SqlConnection sqlConnection = new(connectionString);
            sqlConnection.Open();
            SqlCommand sqlCommand = new($"SELECT [idUser] FROM [MarmitonVanced].[dbo].[Token] where [token]='{token.Replace("\"", "")}'", sqlConnection);
            int? id = (int?)sqlCommand.ExecuteScalar();
            sqlConnection.Close();
            if (id == null)
                return -1;
            return (int)id;
        }
    }
}
