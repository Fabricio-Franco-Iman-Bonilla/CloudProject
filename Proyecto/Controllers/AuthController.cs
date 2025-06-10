using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using System.Net.Http;
using System.Threading.Tasks;
using System.Collections.Generic;
using Proyecto.Controllers;

public class AuthController : Controller
{
    private readonly AuthService _authService;
    private readonly LoginAttemptService _loginService;

    public AuthController(AuthService authService, LoginAttemptService loginService)
    {
        _authService = authService;
        _loginService = loginService;
    }

    [HttpGet]
    public IActionResult Index()
    {
        return View();
    }

    [HttpPost]
    public async Task<IActionResult> Login(string nombre, string contra)
    {
        if (_loginService.IsLocked(nombre, out TimeSpan tiempoRestante))
        {
            ModelState.AddModelError(string.Empty, $"Demasiados intentos fallidos. Intenta de nuevo en {tiempoRestante.Seconds} segundos.");
            return View("Index");
        }

        var recaptchaResponse = Request.Form["g-recaptcha-response"];
        var secretKey = "6LcdREorAAAAAE3LdF07YLdVZmi54v9mtG_qQKOB";
        var client = new HttpClient();
        var result = await client.PostAsync($"https://www.google.com/recaptcha/api/siteverify?secret={secretKey}&response={recaptchaResponse}", null);
        var json = await result.Content.ReadAsStringAsync();

        if (!json.Contains("\"success\": true"))
        {
            ModelState.AddModelError(string.Empty, "Captcha no validado. Inténtalo nuevamente.");
            return View("Index");
        }

        var usuario = await _authService.LoginAsync(nombre, contra);

        if (usuario == null)
        {
            _loginService.RegisterFailedAttempt(nombre);
            int intentos = _loginService.GetAttemptCount(nombre);
            string mensaje = $"Usuario o contraseña incorrectos. Intento {intentos} de 3.";
            if (intentos >= 3)
                mensaje += " Tu cuenta ha sido bloqueada por 1 minuto.";
            ModelState.AddModelError(string.Empty, mensaje);
            return View("Index");
        }

        _loginService.ResetAttempts(nombre);

        var claims = new List<Claim>
        {
            new Claim(ClaimTypes.Name, usuario.Nombre),
            new Claim(ClaimTypes.Role, usuario.Rol.Nombre)
        };

        var identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
        var principal = new ClaimsPrincipal(identity);

        await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, principal);

        return Redirect("/Aguilu/Inicio");
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Logout()
    {
        await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
        return RedirectToAction("Index");
    }
}
