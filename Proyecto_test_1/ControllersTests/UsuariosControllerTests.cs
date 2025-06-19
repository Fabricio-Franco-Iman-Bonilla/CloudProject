using System.Linq;
using System.Threading.Tasks;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.EntityFrameworkCore;
using Proyecto.Controllers;
using Proyecto.Data;
using Proyecto.Models;
using BCrypt.Net;
using Proyecto.Tests.Helpers;  // tu InMemoryContextFactory

namespace Proyecto.Tests.ControllersTests
{
    [TestClass]
    public class UsuariosControllerTests
    {
        [TestMethod]
        public async Task Create_Post_HashesPassword()
        {
            // Arrange: contexto en memoria único
            var ctx = InMemoryContextFactory.Create("User_Hash_Test");

            // Para cumplir FKs, crea un Rol y una Persona:
            ctx.Roles.Add(new Rol { Id = 1, Nombre = "rol1" });
            ctx.Personas.Add(new Persona { Id = 1, Nombre = "Persona1", Dni = "12345678", FechaNacimiento = System.DateTime.Now, Telefono = "123456789", Direccion = "Dir" });
            await ctx.SaveChangesAsync();

            var controller = new UsuariosController(ctx);

            // Modelo que enviaremos al Create (igual que en el formulario)
            var nuevo = new Usuario
            {
                Nombre = "testuser",
                Contraseña = "plain123!",
                RolId = 1,
                PersonaId = 1
            };

            // Act: llama al action Create
            var result = await controller.Create(nuevo);

            // Assert: comprueba que se guardó un usuario
            var guardado = ctx.Usuarios.Single(u => u.Nombre == "testuser");

            // 1) La contraseña en BD no debe ser el texto plano
            Assert.AreNotEqual("plain123!", guardado.Contraseña);

            // 2) Debe pasar BCrypt.Verify con el texto original
            Assert.IsTrue(BCrypt.Net.BCrypt.Verify("plain123!", guardado.Contraseña));
        }
    }
}
