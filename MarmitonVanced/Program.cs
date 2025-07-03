using System.Collections.Concurrent;
using System.Net.WebSockets;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorPages();

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

ConcurrentBag<WebSocket> sockets = new();

app.Map("/ws", async (HttpContext context) =>
{
    if (context.WebSockets.IsWebSocketRequest)
    {
        WebSocket webSocket = await context.WebSockets.AcceptWebSocketAsync();
        sockets.Add(webSocket);
        var clientIp = context.Connection.RemoteIpAddress?.ToString();
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
                    sockets.TryTake(out _);
                    break;
                }

                var message = Encoding.UTF8.GetString(buffer, 0, result.Count);
                Console.WriteLine(message);

                // Diffuser à tous les clients connectés
                foreach (var socket in sockets)
                {
                    if (socket.State == WebSocketState.Open)
                    {
                        await socket.SendAsync(
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
            sockets.TryTake(out _);
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
