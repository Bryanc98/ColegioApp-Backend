using ColegioApp.Dto;
using ColegioApp.Helpers;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Security.Cryptography;

namespace ColegioApp.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsuarioController : ControllerBase
    {
        private readonly ColegioDbContext _context;
        public UsuarioController(ColegioDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IActionResult> GetUsuarios()
        {
            var usuarios = await _context.Usuarios
                             .Include(u => u.Role)
                             .Select(u => new
                             {
                                 u.UsuarioId,
                                 u.Nombre,
                                 u.Email,
                                 u.Role,
                                 Curso = u.Cursos.Select(c => new {
                                     c.CursoId,
                                     c.NombreCurso,
                                     c.ProfesorId
                                 }).FirstOrDefault(x => x.ProfesorId == u.UsuarioId)
                             })
                             .ToListAsync();
            return Ok(usuarios);
        }

        [HttpGet("Rol/{RolId}")]
        public async Task<IActionResult> GetUsuariosByRol(int RolId)
        {

            var usuario = await _context.Usuarios.Where(u => u.RoleId == RolId).Select(u => new
            {
                u.UsuarioId,
                u.Nombre,
                u.Email,
                Curso = u.Cursos.Select(c => new {
                    c.CursoId,
                    c.NombreCurso,
                    c.ProfesorId
                }).FirstOrDefault(x => x.ProfesorId== u.UsuarioId)
            }).ToListAsync();
            return Ok(usuario);
        }
    }
}
