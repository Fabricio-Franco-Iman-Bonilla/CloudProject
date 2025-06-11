using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using System.Net.Http;
using System.Threading.Tasks;
using System.Collections.Generic;
using Proyecto.Controllers;
using Proyecto.Services;


public class AuthController : Controller
{
    private readonly AuthService _authService;
    private readonly LoginAttemptService _loginService;
    private readonly SessionManagerService _sessionService;

    public AuthController(AuthService authService, LoginAttemptService loginService, SessionManagerService sessionService)
    {
        _authService = authService;
        _loginService = loginService;
        _sessionService = sessionService;

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
        //
        var usuario = await _authService.LoginAsync(nombre, contra);

        // Validación: si el usuario no existe
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

        // Validación: si ya tiene sesión activa
        if (!_sessionService.SesionValida(usuario.Nombre))
        {
            ModelState.AddModelError(string.Empty, "Este usuario ya tiene una sesión activa.");
            return View("Index");
        }

        //
        _loginService.ResetAttempts(nombre);

        var claims = new List<Claim>
        {
            new Claim(ClaimTypes.Name, usuario.Nombre),
            new Claim(ClaimTypes.Role, usuario.Rol.Nombre)
        };

        var identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
        var principal = new ClaimsPrincipal(identity);

        _sessionService.ActivarSesion(usuario.Nombre);

        await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, principal);

        return Redirect("/Aguilu/Inicio");
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Logout()
    {
        // Cierra sesión en memoria
        _sessionService.CerrarSesion(User.Identity.Name);

        // Cierra sesión en cookie
        await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);

        return RedirectToAction("Index");
    }
}
