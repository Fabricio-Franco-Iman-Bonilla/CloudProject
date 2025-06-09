using Microsoft.EntityFrameworkCore;
using Proyecto.Models;
using Proyecto.Data;

public class AuthService
{
    private readonly ProyectoContext _context;

    public AuthService(ProyectoContext context)
    {
        _context = context;
    }

    public async Task<Usuario> LoginAsync(string nombre, string contraseña)
    {
        // Busca al usuario con su Rol incluido
        var usuario = await _context.Usuarios
            .Include(u => u.Rol)
            .FirstOrDefaultAsync(u => u.Nombre == nombre);

        if (usuario == null)
            return null;

        // Verifica contraseña hasheada
        bool passwordCorrecta = BCrypt.Net.BCrypt.Verify(contraseña, usuario.Contraseña);
        if (!passwordCorrecta)
            return null;

        return usuario;
    }
}
