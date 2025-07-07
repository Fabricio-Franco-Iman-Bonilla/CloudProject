using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Proyecto.Controllers;
using Proyecto.Data;
using Proyecto.Models;
using System.Threading.Tasks;

namespace Proyecto.Tests.Controllers
{
    [TestClass]
    public class ProveedorsControllerTests
    {
        private ProyectoContext _context;
        private ProveedorsController _controller;

        [TestInitialize]
        public void Setup()
        {
            // Crear una base de datos en memoria
            var options = new DbContextOptionsBuilder<ProyectoContext>()
                .UseInMemoryDatabase(databaseName: "TestDb")
                .Options;

            _context = new ProyectoContext(options);
            _controller = new ProveedorsController(_context);
        }

        [TestMethod]
        public async Task Create_ValidProveedor_RedirectsToIndex()
        {
            // Arrange
            var proveedor = new Proveedor
            {
                Nombre = "Proveedor Test",
                Telefono = "123456789",
                Email = "test@correo.com"
            };

            // Act
            var result = await _controller.Create(proveedor);

            // Assert
            var redirectToActionResult = result as RedirectToActionResult;
            Assert.IsNotNull(redirectToActionResult);
            Assert.AreEqual("Index", redirectToActionResult.ActionName);

            // Verifica si fue guardado en la base de datos
            Assert.AreEqual(1, await _context.Proveedor.CountAsync());
        }

        [TestMethod]
        public async Task Create_InvalidProveedor_ReturnsViewWithModel()
        {
            // Arrange
            var proveedor = new Proveedor
            {
                Nombre = "", // Campo requerido vacío para provocar error
                Telefono = "123456789",
                Email = "correo@correo.com"
            };

            _controller.ModelState.AddModelError("Nombre", "El nombre es requerido");

            // Act
            var result = await _controller.Create(proveedor);

            // Assert
            var viewResult = result as ViewResult;
            Assert.IsNotNull(viewResult);
            Assert.IsInstanceOfType(viewResult.Model, typeof(Proveedor));
            Assert.AreEqual(proveedor, viewResult.Model);
        }
    }
}
