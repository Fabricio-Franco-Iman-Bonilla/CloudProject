using Proyecto.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Proyecto_test_1.ValidacionDni
{
    internal class DniTest
    { 
        [TestMethod]
        public void TestMethod1()
        {
            Decimal precioCosto = 220;
            Decimal precioVenta = 100;

            Producto producto = new Producto();


            bool result = producto.PrecioEsValido(precioCosto, precioVenta);

            //Se esperaba True
            bool expected = true;

            //Assert.IsTrue(result);

            Assert.AreEqual(expected, result);
        }

        [TestMethod]
        public void TestMethod2()
        {
            string dni = "12346754";
            Persona geraldin = new Persona();

            bool result = geraldin.ValidarDNI(dni);

            //Se esperaba True
            bool expected = true;

            //Assert.IsTrue(result);

            Assert.AreEqual(expected, result);
        }

    }

}
