using ColegioApp.BusinessLogic;
using ColegioApp.Dto;
using ColegioApp.Helpers;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace ColegioApp.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly ColegioDbContext _context;
        private readonly IConfiguration _configuration;
        public AuthController(ColegioDbContext context, IConfiguration configuration)
        {
            _context = context;
            _configuration = configuration;
        }

        [HttpPost("Login")]
        public async Task<IActionResult> LoginUser(LoginDto request)
        {
            var usuario = await _context.Usuarios
                .Where(u => u.Email == request.username)
                .Include(u => u.Role)
                .Include(u => u.Cursos)
                .Include(u => u.Niveles)
                .FirstOrDefaultAsync();

            if (usuario == null || !PasswordHelper.VerifyPassword(request.password!, usuario.PasswordHash))
            {
                return Unauthorized(new
                {
                    Message = "Usuario o contraseña incorrectos"
                });
            }

            var token = new AuthBL(_configuration).GenerateJwtToken(usuario);

            var result = new
            {
                usuario.UsuarioId,
                usuario.Nombre,
                usuario.Email,
                role = new {
                    roleId =  usuario.Role!.RoleId,
                    roleName = usuario.Role.RoleName
                },
                nivel = usuario.Niveles.Select(n => new
                {
                    n.NivelId,
                    n.NombreNivel,
                    n.CoordinadorId
                }).FirstOrDefault(x => x.CoordinadorId == usuario.UsuarioId),
                curso = usuario.Cursos.Select(c => new
                {
                    c.CursoId,
                    c.NombreCurso,
                    c.ProfesorId
                }).FirstOrDefault(x => x.ProfesorId == usuario.UsuarioId),
                Token = token
            };

            return Ok(result);
        }

        

    }
}
