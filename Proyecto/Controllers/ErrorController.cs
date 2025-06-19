using Microsoft.AspNetCore.Mvc;

public class ErrorController : Controller
{
    [Route("Error/Unauthorized")]
    public IActionResult UnauthorizedAccess()
    {
        return View("Unauthorized");
    }
}
