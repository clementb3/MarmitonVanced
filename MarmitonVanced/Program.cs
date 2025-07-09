using System.Collections.Concurrent;
using System.Net.WebSockets;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorPages();
builder.Services.AddSingleton<Dictionary<string, int>>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapRazorPages();

var webSocketOptions = new WebSocketOptions
{
    KeepAliveInterval = TimeSpan.FromSeconds(120),
    AllowedOrigins = { "*" }
};

app.UseWebSockets(webSocketOptions);

List<List<object>> sockets = new();

app.Map("/ws", async (HttpContext context) =>
{
    if (context.WebSockets.IsWebSocketRequest)
    {
        WebSocket webSocket = await context.WebSockets.AcceptWebSocketAsync();
        string clientIp = context.Connection.RemoteIpAddress?.ToString() ?? "";
        sockets.Add([clientIp, webSocket]);
        Console.WriteLine($"Client connecté depuis : {clientIp}");

        var buffer = new byte[1024 * 4];
        try
        {
            while (webSocket.State == WebSocketState.Open)
            {
                var result = await webSocket.ReceiveAsync(new ArraySegment<byte>(buffer), CancellationToken.None);

                if (result.MessageType == WebSocketMessageType.Close)
                {
                    Console.WriteLine("Déconnexion WebSocket.");
                    await webSocket.CloseAsync(WebSocketCloseStatus.NormalClosure, "Bye", CancellationToken.None);
                    sockets.Remove(sockets.First(socket => ((WebSocket)socket[1]) == webSocket));
                    break;
                }

                var message = Encoding.UTF8.GetString(buffer, 0, result.Count);
                Console.WriteLine(message);

                // Diffuser à tous les clients connectés
                foreach (var socket in sockets)
                {
                    if (((WebSocket)socket[1]).State == WebSocketState.Open && ((string)socket[0]) == clientIp)
                    {
                        await ((WebSocket)socket[1]).SendAsync(
                            Encoding.UTF8.GetBytes(message),
                            WebSocketMessageType.Text,
                            true,
                            CancellationToken.None);
                    }
                }
            }
        }
        catch (WebSocketException ex)
        {
            Console.WriteLine($"WebSocket fermé de façon inattendue : {ex.Message}");
        }
        finally
        {
            sockets.Remove(sockets.First(socket => ((WebSocket)socket[1]) == webSocket));
        }
    }
    else
    {
        context.Response.StatusCode = 400;
    }
});

app.UseEndpoints(endpoints =>
{
    _ = endpoints.MapControllerRoute(
        name: "default",
        pattern: "{controller=Recipe}/{action=Index}");
});

app.Run();
