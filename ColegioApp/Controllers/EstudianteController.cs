using ColegioApp.Dto;
using ColegioApp.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ColegioApp.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EstudianteController : ControllerBase
    {
        private readonly ColegioDbContext _context;

        public EstudianteController(ColegioDbContext context)
        {
            this._context = context;
        }

        [HttpGet]
        public async Task<IActionResult> GetAllEstudiantes()
        {
            var estudiantes = await _context.Estudiantes.ToListAsync();
            return Ok(estudiantes);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetEstudianteById(int id)
        {
            var estudiante = await _context.Estudiantes.FindAsync(id);
            if (estudiante == null)
            {
                return NotFound();
            }
            return Ok(estudiante);
        }

        [HttpGet("Curso/{cursoId}")]
        public async Task<IActionResult> GetEstudiantesByCurso(int cursoId)
        {
            var estudiantes = await _context.Estudiantes
                .Include(e => e.Curso)
                .Where(e => e.CursoId == cursoId)
                .Select(u => new
                {
                    u.EstudianteId,
                    u.Nombre,
                    u.Email,
                    u.Sexo,
                    u.FechaNacimiento,
                    u.CursoId,
                    curso = new
                    {
                        cursoId = u.Curso.CursoId,
                        nombreCurso = u.Curso.NombreCurso
                    }

                })
                .ToListAsync();

            if (estudiantes == null || estudiantes.Count == 0)
            {
                return NotFound();
            }
            return Ok(estudiantes);
        }

        [HttpGet("Nivel/{nivelId}")]
        public async Task<IActionResult> GetEstudiantesByNivel(int nivelId)
        {
            var estudiantes = await _context.Estudiantes
                .Include(e => e.Curso)
                .Where(e => e.Curso.Nivel.NivelId == nivelId)
                .Select(u => new
                {
                    u.EstudianteId,
                    u.Nombre,
                    u.Email,
                    u.Sexo,
                    u.FechaNacimiento,
                    u.CursoId,
                    curso = new
                    {
                        cursoId = u.Curso.CursoId,
                        nombreCurso = u.Curso.NombreCurso
                    }

                })
                .ToListAsync();

            if (estudiantes == null || estudiantes.Count == 0)
            {
                return NotFound();
            }
            return Ok(estudiantes);
        }

        [HttpPost]
        public IActionResult AddEstudiante(EstudianteDto estudiante)
        {
            if(estudiante == null)
            {
                return BadRequest();
            }

            var datosEstudiante = new Estudiante
            {
                Nombre = estudiante.nombre,
                Email = estudiante.email,
                Sexo = estudiante.sexo,
                FechaNacimiento = estudiante.fechaNacimiento,
                CursoId = estudiante.cursoId
            };

            _context.Estudiantes.Add(datosEstudiante);
            _context.SaveChanges();

            return Ok(new
            {
                Message = "Estudiante registrado satisfactoriamente"
            });
        }

        [HttpPut]
        public IActionResult EditEstudiante(EstudianteDto updatedEstudiante)
        {
            var estudiante = _context.Estudiantes.Find(updatedEstudiante.estudianteId);
            if (estudiante == null)
            {
                return NotFound();
            }

            estudiante.Nombre = updatedEstudiante.nombre;
            estudiante.Email = updatedEstudiante.email;
            estudiante.Sexo = updatedEstudiante.sexo;
            estudiante.FechaNacimiento = updatedEstudiante.fechaNacimiento;
            estudiante.CursoId = updatedEstudiante.cursoId;

            _context.SaveChanges();
            return Ok(estudiante);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteEstudiante(int id)
        {
            var estudiante = await _context.Estudiantes
                .Include(e => e.Asistencia)
                .Include(e => e.Calificaciones)
                .FirstOrDefaultAsync(e => e.EstudianteId == id);

            if (estudiante == null)
            {
                return NotFound();
            }

            _context.Asistencias.RemoveRange(estudiante.Asistencia);
            _context.Calificaciones.RemoveRange(estudiante.Calificaciones);
            _context.Estudiantes.Remove(estudiante);
            await _context.SaveChangesAsync();

            return Ok(new
            {
                Message = "Estudiante eliminado satisfactoriamente"
            });
        }
    }
}
