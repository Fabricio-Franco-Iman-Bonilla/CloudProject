using System.ComponentModel.DataAnnotations;
using System.Text.RegularExpressions;

namespace Proyecto.Models
{
    public class Persona
    {
        public Persona() { Usuarios = new HashSet<Usuario>(); }
        public int Id { get; set; }
        [StringLength(100)]
        public string Nombre { get; set; }
        [StringLength(8)]
        public string Dni { get; set; }
        public DateTime FechaNacimiento { get; set; }
        [StringLength(9)]
        public string Telefono { get; set; }
        [StringLength(200)]
        public string Direccion { get; set; }
        public IEnumerable<Usuario> Usuarios { get; set; }
        //----------------------------
        public bool ValidarDNI(string dni)
        {
            if (string.IsNullOrWhiteSpace(dni))
                return false;

            // Regex: inicio (^) + 8 dígitos (\d{8}) + fin ($)
            return Regex.IsMatch(dni, @"^\d{8}$");
        }
    }
}
