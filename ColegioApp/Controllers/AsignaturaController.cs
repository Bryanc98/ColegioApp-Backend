using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ColegioApp.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AsignaturaController : ControllerBase
    {
        private readonly ColegioDbContext _context;
        public AsignaturaController(ColegioDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IActionResult> GetAsignaturas()
        {
            var asignaturas = await _context.Asignaturas
            .Select(a => new
            {
                a.AsignaturaId,
                a.NombreAsignatura
            })
            .OrderBy(a => a.AsignaturaId)
            .ToListAsync();

            return Ok(asignaturas);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetAsignaturaById(int id)
        {
            var asignatura = await _context.Asignaturas
                .Where(a => a.AsignaturaId == id)
                .Select(a => new
                {
                    a.AsignaturaId,
                    a.NombreAsignatura
                })
                .FirstOrDefaultAsync();

            if (asignatura == null)
            {
                return NotFound();
            }

            return Ok(asignatura);
        }
    }
}
