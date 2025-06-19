using System.Collections.Concurrent;

namespace Proyecto.Services
{
    public class SessionManagerService
    {
        private readonly ConcurrentDictionary<string, bool> _usuariosActivos = new();

        public bool SesionValida(string nombreUsuario)
        {
            return !_usuariosActivos.ContainsKey(nombreUsuario);
        }

        public void ActivarSesion(string nombreUsuario)
        {
            _usuariosActivos[nombreUsuario] = true;
        }

        public void CerrarSesion(string nombreUsuario)
        {
            _usuariosActivos.TryRemove(nombreUsuario, out _);
        }
    }
}
