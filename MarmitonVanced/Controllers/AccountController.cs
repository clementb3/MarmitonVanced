using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Threading.Tasks;
using System.Text;
using System.Security.Cryptography;
using Microsoft.Data.SqlClient;
using Microsoft.IdentityModel.Protocols.OpenIdConnect;
using Microsoft.IdentityModel.Protocols;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;

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
            sqlCommand = new($"select [name] from [dbo].[User] where [mail]='{accountObject["mail"]}'", sqlConnection);
            string name = (string)sqlCommand.ExecuteScalar();
            sqlConnection.Close();
            return token + ";" + name;
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
            sqlCommand = new($"select [name] from [dbo].[User] where [mail]='{accountObject["mail"]}'", sqlConnection);
            string name = (string)sqlCommand.ExecuteScalar();
            sqlConnection.Close();
            return token + ";" + name;
        }

        public async Task<string> ConnectAccountGoogle()
        {
            var rawRequestBody = await new StreamReader(Request.Body).ReadToEndAsync();
            JObject accountObject = (JObject)JsonConvert.DeserializeObject(rawRequestBody)!;
            ClaimsPrincipal? account = ValidateGoogleTokenAsync(accountObject["token"]!.ToString());
            if (account == null)
                return "error : mauvais identifiant";
            SqlConnection sqlConnection = new(configuration["ConnectionStrings:db"]);
            sqlConnection.Open();
            SqlCommand sqlCommand = new($"select id from [dbo].[User] where [mail]='{accountObject["mail"]}'", sqlConnection);
            int? id = (int?)sqlCommand.ExecuteScalar();
            if (id == null)
            {
                sqlCommand = new($"INSERT INTO [dbo].[User]([name], [surname], [password], [mail], [state]) VALUES('{accountObject["name"]}', '{accountObject["surname"]}', '{Convert.ToBase64String(Guid.NewGuid().ToByteArray())}', '{accountObject["mail"]}', 'wait'); select id from [dbo].[User] where[mail] = '{accountObject["mail"]}'", sqlConnection);
                id = (int)sqlCommand.ExecuteScalar();
            }
            string token = Convert.ToBase64String(Guid.NewGuid().ToByteArray());
            sqlCommand = new($"INSERT INTO [dbo].[Token] ([idUser],[token]) VALUES ({id},'{token}')", sqlConnection);
            sqlCommand.ExecuteNonQuery();
            sqlCommand = new($"select [name] from [dbo].[User] where [mail]='{accountObject["mail"]}'", sqlConnection);
            string name = (string) sqlCommand.ExecuteScalar();
            sqlConnection.Close();
            return token + ";" + name;
        }



        private ClaimsPrincipal? ValidateGoogleTokenAsync(string idToken)
        {
            var clientId = "790687088837-7obcub3b4bm7q6m5tuqcmhklv96t80rr.apps.googleusercontent.com"; // Remplace par ton vrai client ID

            var configManager = new ConfigurationManager<OpenIdConnectConfiguration>(
                "https://accounts.google.com/.well-known/openid-configuration",
                new OpenIdConnectConfigurationRetriever(),
                new HttpDocumentRetriever());

            var task = configManager.GetConfigurationAsync();
            task.Wait();
            var config = task.Result;

            var tokenHandler = new JwtSecurityTokenHandler();

            var validationParameters = new TokenValidationParameters
            {
                ValidIssuer = "https://accounts.google.com",
                ValidAudiences = new[] { clientId },
                IssuerSigningKeys = config.SigningKeys
            };

            try
            {
                SecurityToken validatedToken;
                var principal = tokenHandler.ValidateToken(idToken, validationParameters, out validatedToken);
                return principal;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Token invalide : " + ex.Message);
                return null;
            }
        }

        public void Deconnect()
        {
            try
            {
                SqlConnection sqlConnection = new(configuration["ConnectionStrings:db"]);
                sqlConnection.Open();
                SqlCommand sqlCommand = new($"delete [MarmitonVanced].[dbo].[Token] where token='{(Request.Cookies["token"] ?? "") .Replace("\"", "") ?? ""}'", sqlConnection);
                sqlCommand.ExecuteNonQuery();
                sqlConnection.Close();
            }
            catch { }
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
