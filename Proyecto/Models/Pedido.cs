using System.ComponentModel.DataAnnotations;

namespace Proyecto.Models
{
    public class Pedido
    {
        public Pedido()
        {
            DetallePedidos = new HashSet<DetallePedido>();
            RegistroPagos = new HashSet<RegistroPago>();
        }
        public int Id { get; set; }
        public DateTime Fecha { get; set; }
        [Required(ErrorMessage = "El estado es obligatorio.")]
        [RegularExpression("Pendiente|En Curso|Enviado|Aprobado", ErrorMessage = "El estado debe ser válido (Pendiente, En Curso, Enviado o Aprobado).")]
        public string Estado { get; set; }


        public int ProveedorId { get; set; }
        public int ProductoId { get; set; }
        public int AdminId { get; set; }
        public Proveedor Proveedor { get; set; }
        public Producto Producto { get; set; }
        public Administrador Administrador { get; set; }
        public IEnumerable<DetallePedido> DetallePedidos { get; set; }
        public IEnumerable<RegistroPago> RegistroPagos { get; set; }
    }
}
