using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ColegioApp.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CursoController : ControllerBase
    {
        private readonly ColegioDbContext _context;

        public CursoController(ColegioDbContext context)
        {
            this._context = context;
        }

        [HttpGet]
        public async Task<IActionResult> GetCursos()
        {
            var cursos = await _context.Cursos.ToListAsync();
            return Ok(cursos);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetCurso(int id)
        {
            var curso = await _context.Cursos
                .Include(c => c.Profesor)
                .Include(c => c.Nivel)
                .Where(x => x.CursoId == id)
                .Select(u => new
                {
                    u.CursoId,
                    u.NombreCurso,
                    u.Descripcion,
                    u.ProfesorId,
                    u.NivelId,
                    u.Nivel,
                    profesor = new
                    {
                        u.Profesor.Nombre,
                        u.Profesor.Email
                    }
                }).FirstOrDefaultAsync();
            if (curso == null)
            {
                return NotFound();
            }
            return Ok(curso);
        }

        [HttpGet("Nivel/{id}")]
        public async Task<IActionResult> GetCursosByNivel(int id)
        {
            var cursos = await _context.Cursos
                .Include(c => c.Profesor)
                .Where(c => c.NivelId == id)
                .Select(u => new
                {
                    u.CursoId,
                    u.NombreCurso,
                    u.Descripcion,
                    u.ProfesorId,
                    u.NivelId,
                    profesor = new
                    {
                        u.Profesor.Nombre,
                        u.Profesor.Email
                    },
                    
                })
                .ToListAsync();
            return Ok(cursos);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutCurso(int id, Curso curso)
        {
            if (id != curso.CursoId)
            {
                return BadRequest();
            }

            _context.Entry(curso).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CursoExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }
        private bool CursoExists(int id)
        {
            return _context.Cursos.Any(e => e.CursoId == id);
        }
    }
}
