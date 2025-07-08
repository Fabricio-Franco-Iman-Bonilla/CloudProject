using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using Proyecto.Controllers;
using Proyecto.Data;
using Proyecto.Services;


var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();
builder.Services.AddSingleton<SessionManagerService>();

builder.Services.AddDbContext<ProyectoContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

// Servicios personalizados
builder.Services.AddScoped<AuthService>();
builder.Services.AddSingleton<LoginAttemptService>(); // 👈 Mueve esto arriba, antes del Build()

// Autenticación
builder.Services
    .AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(options =>
    {
        options.Cookie.Name = "AuthCookie";
        options.LoginPath = "/Auth/Index";
        options.AccessDeniedPath = "/Home/Index";
        options.ExpireTimeSpan = TimeSpan.FromHours(1);
        options.SlidingExpiration = false;
    });

// Autorización (sin fallback por ahora)
builder.Services.AddAuthorization();

var app = builder.Build();

// Configuración de entorno
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

//PARA CONFIGURAR CSP
app.Use(async (context, next) =>
{
    var nonce = Convert.ToBase64String(Guid.NewGuid().ToByteArray());
    context.Items["cspNonce"] = nonce;

    context.Response.Headers.Add("Content-Security-Policy",
        $"default-src 'self'; " +
        $"script-src 'self' 'nonce-{nonce}' https://www.google.com https://www.gstatic.com https://cdn.jsdelivr.net; " +
        $"style-src 'self' 'nonce-{nonce}' https://fonts.googleapis.com https://cdn.jsdelivr.net; " +
        $"font-src 'self' https://fonts.gstatic.com; " +
        $"img-src 'self' data: https://www.google.com https://www.gstatic.com; " +
        $"frame-src https://www.google.com https://www.recaptcha.net; " +
        $"connect-src 'self'; " +
        $"form-action 'self'; " +
        $"frame-ancestors 'none'; " +
        $"object-src 'none'; " +
        $"base-uri 'self';"); // ← importante para CSP moderna
    await next();


    await next();
});




//PARA CLICKJACKING
app.Use(async (context, next) =>
{
    context.Response.Headers.Add("X-Frame-Options", "DENY");
    await next();
});


app.UseRouting();

// Prevención de cacheo en páginas protegidas
app.Use(async (ctx, next) =>
{
    ctx.Response.Headers["Cache-Control"] = "no-store, no-cache, must-revalidate";
    ctx.Response.Headers["Pragma"] = "no-cache";
    ctx.Response.Headers["Expires"] = "0";
    await next();
});

app.UseAuthentication();
app.UseAuthorization();

// Rutas
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Auth}/{action=Index}/{id?}");

app.Run();
