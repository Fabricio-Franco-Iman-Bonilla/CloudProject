using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Proyecto.Controllers;
using Proyecto.Data;
using Proyecto.Models;
using System;
using System.Threading.Tasks;

namespace Proyecto_test_1.KardexTest
{
    [TestClass]
    public class TestKardex
    {
        private ProyectoContext GetInMemoryDbContext()
        {
            var options = new DbContextOptionsBuilder<ProyectoContext>()
                .UseInMemoryDatabase(databaseName: Guid.NewGuid().ToString())
                .Options;

            var context = new ProyectoContext(options);

            // Datos de prueba
            context.Productos.AddRange(
                new Producto { Id = 1, Nombre = "Producto A" },
                new Producto { Id = 2, Nombre = "Producto B" },
                new Producto { Id = 3, Nombre = "Producto C" }
            );

            context.Kardex.AddRange(
                new Kardex { Id = 1, ProductoId = 1, FechaMovimiento = DateTime.Now },
                new Kardex { Id = 2, ProductoId = 1, FechaMovimiento = DateTime.Now },
                new Kardex { Id = 3, ProductoId = 2, FechaMovimiento = DateTime.Now }
            );

            context.SaveChanges();

            return context;
        }

        [TestMethod]
        public async Task ProductoMasVendido_DeberiaRetornarProductoA()
        {
            // Arrange
            var context = GetInMemoryDbContext();
            var controller = new KardexsController(context);

            // Act
            var result = await controller.ProductoMasVendido() as ViewResult;

            // Assert
            Assert.IsNotNull(result);
            Assert.AreEqual("Producto A", controller.ViewBag.Producto);
            Assert.AreEqual(2, controller.ViewBag.Total);
        }

        [TestMethod]
        public async Task ProductoMenosVendido_DeberiaRetornarProductoB()
        {
            // Arrange
            var context = GetInMemoryDbContext();
            var controller = new KardexsController(context);

            // Act
            var result = await controller.ProductoMenosVendido() as ViewResult;

            // Assert
            Assert.IsNotNull(result);
            Assert.AreEqual("Producto B", controller.ViewBag.Producto);
            Assert.AreEqual(1, controller.ViewBag.Total);
        }
    }
}

