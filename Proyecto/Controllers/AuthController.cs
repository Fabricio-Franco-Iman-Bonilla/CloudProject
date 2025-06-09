using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using System.Security.Claims;
using Proyecto.Models;

namespace Proyecto.Controllers
{
    public class AuthController : Controller
    {
        private readonly AuthService _authService;

        public AuthController(AuthService authService)
        {
            _authService = authService;
        }

        [HttpGet]
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Login(string nombre, string contra)
        {
            // 1. Capturar respuesta del reCAPTCHA enviada desde el navegador
            var recaptchaResponse = Request.Form["g-recaptcha-response"];

            // 2. Validar con la API de Google
            var secretKey = "6LcdREorAAAAAE3LdF07YLdVZmi54v9mtG_qQKOB"; // ← Reemplaza por tu clave secreta
            var client = new HttpClient();
            var result = await client.PostAsync($"https://www.google.com/recaptcha/api/siteverify?secret={secretKey}&response={recaptchaResponse}", null);
            var json = await result.Content.ReadAsStringAsync();

            if (!json.Contains("\"success\": true"))
            {
                ModelState.AddModelError(string.Empty, "Captcha no validado. Inténtalo nuevamente.");
                return View("Index");
            }

            // 3. Validar credenciales del usuario
            var usuario = await _authService.LoginAsync(nombre, contra);

            if (usuario == null)
            {
                ModelState.AddModelError(string.Empty, "Usuario o contraseña incorrectos.");
                return View("Index");
            }

            // 4. Crear sesión
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
}
