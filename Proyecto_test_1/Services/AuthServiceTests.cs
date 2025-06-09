using System.Threading.Tasks;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Proyecto.Data;
using Proyecto.Controllers;
using Proyecto.Models;
using BCrypt.Net;
using Proyecto.Tests.Helpers;

namespace Proyecto_test_1.Tests.Services

{
    [TestClass]
    public class AuthServiceTests
    {
        [TestMethod]
        public async Task LoginAsync_ConCredencialesCorrectas_RetornaTrue()
        {
            // Arrange
            var ctx = InMemoryContextFactory.Create("Auth_OK");
            var hash = BCrypt.Net.BCrypt.HashPassword("miContra123");
            ctx.Usuarios.Add(new Usuario { Nombre = "pepito", Contraseña = hash, RolId = 1, PersonaId = 1 });
            ctx.SaveChanges();
            var svc = new AuthService(ctx);

            // Act
            var resultado = await svc.LoginAsync("pepito", "miContra123");

            // Assert
            Assert.IsTrue(resultado);
        }

        [TestMethod]
        public async Task LoginAsync_ConContraseñaErronea_RetornaFalse()
        {
            var ctx = InMemoryContextFactory.Create("Auth_Wrong");
            var hash = BCrypt.Net.BCrypt.HashPassword("correcta");
            ctx.Usuarios.Add(new Usuario { Nombre = "juanito", Contraseña = hash });
            ctx.SaveChanges();
            var svc = new AuthService(ctx);

            Assert.IsFalse(await svc.LoginAsync("juanito", "otraContra"));
        }

        [TestMethod]
        public async Task LoginAsync_UsuarioNoExiste_RetornaFalse()
        {
            var ctx = InMemoryContextFactory.Create("Auth_NoUser");
            var svc = new AuthService(ctx);

            Assert.IsFalse(await svc.LoginAsync("nadie", "loQueSea"));
        }
    }
}
