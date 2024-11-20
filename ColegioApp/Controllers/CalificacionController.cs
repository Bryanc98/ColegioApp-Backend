using ColegioApp.Dto;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ColegioApp.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CalificacionController : ControllerBase
    {
        private readonly ColegioDbContext _context;
        public CalificacionController(ColegioDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IActionResult> GetCalificaciones(int? cursoId, int? nivelId)
        {
            var calificaciones = await _context.Calificaciones
            .Include(c => c.Curso)
            .Include(c => c.Asignatura)
            .Include(c => c.Estudiante)
            .Where(c => (cursoId == null || c.Curso!.CursoId == cursoId)
            && (nivelId == null || c.Curso!.Nivel.NivelId == nivelId))
            .Select(c => new
            {
                c.CalificacionId,
                c.Nota,
                c.Literal,
                asignatura = new
                {
                    c.Asignatura!.AsignaturaId,
                    c.Asignatura.NombreAsignatura
                },
                nivel = new
                {
                    c.Curso!.Nivel.NivelId,
                    c.Curso.Nivel.NombreNivel
                },
                curso = new
                {
                    c.Curso.CursoId,
                    c.Curso.NombreCurso
                },
                estudiante = new
                {
                    c.Estudiante!.EstudianteId,
                    c.Estudiante.Nombre
                }
            })
            .ToListAsync();

            if (calificaciones == null)
            {
                return NotFound();
            }

            return Ok(calificaciones);
        }

        [HttpGet("Estudiante")]
        public async Task<IActionResult> GetCalificacionesPaginadas(int cursoId, int pageNumber = 1, int pageSize = 2)
        {
            var totalCount = await _context.Estudiantes
                .Where(e => e.CursoId == cursoId)
                .CountAsync();

            var estudiantes = await _context.Estudiantes
                .Include(e => e.Curso)
                .ThenInclude(c => c.Nivel)
                .Include(e => e.Curso)
                .ThenInclude(c => c.Calificaciones)
                .ThenInclude(cal => cal.Asignatura)
                .Where(e => e.CursoId == cursoId)
                .OrderBy(e => e.EstudianteId)
                .Skip((pageNumber - 1) * pageSize)
                .Take(pageSize)
                .Select(e => new
                {
                    totalCount = totalCount,
                    Estudiante = new
                    {
                        e.EstudianteId,
                        e.Nombre
                    },
                    Curso = new
                    {
                        e.Curso.CursoId,
                        e.Curso.NombreCurso
                    },
                    Nivel = new
                    {
                        e.Curso.Nivel.NivelId,
                        e.Curso.Nivel.NombreNivel
                    },
                    Calificaciones = e.Curso.Calificaciones
                        .Where(cal => cal.EstudianteId == e.EstudianteId)
                        .Select(cal => new
                        {
                            cal.CalificacionId,
                            cal.Nota,
                            cal.Literal,
                            Asignatura = new
                            {
                                cal.Asignatura!.AsignaturaId,
                                cal.Asignatura.NombreAsignatura
                            }
                        }).ToList()
                })
                .ToListAsync();

            if (estudiantes == null || !estudiantes.Any())
            {
                return NotFound("No se encontraron estudiantes para el curso especificado.");
            }

            return Ok(estudiantes);
        }

        [HttpPost]
        public async Task<ActionResult> PostCalificacion(CalificacionDto datosCalificacion)
        {
            foreach (var calificacion in datosCalificacion.Calificaciones)
            {
                if (calificacion.Nota != null)
                {
                    if (calificacion.CalificacionId != 0 && CalificacioneExists(calificacion.CalificacionId))
                    {
                        // Actualizar la calificación existente
                        var calificacionExistente = await _context.Calificaciones.FindAsync(calificacion.CalificacionId);
                        if (calificacionExistente != null)
                        {
                            calificacionExistente.Nota = calificacion.Nota;
                            calificacionExistente.Literal = calificacion.Literal;
                            _context.Entry(calificacionExistente).State = EntityState.Modified;
                        }
                    }
                    else
                    {
                        // Crear una nueva calificación
                        Calificacione nuevaCalificacion = new Calificacione
                        {
                            EstudianteId = datosCalificacion.Estudiante.EstudianteId,
                            CursoId = datosCalificacion.Curso.CursoId,
                            AsignaturaId = calificacion.AsignaturaId,
                            Nota = calificacion.Nota,
                            Literal = calificacion.Literal,
                            FechaRegistro = DateTime.Now
                        };
                        _context.Calificaciones.Add(nuevaCalificacion);
                    }
                }
            }

            await _context.SaveChangesAsync();

            return Ok(new
            {
                Message = "Calificaciones actualizadas correctamente"
            });
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutCalificacion(int id, Calificacione calificacion)
        {
            if (id != calificacion.CalificacionId)
            {
                return BadRequest();
            }

            _context.Entry(calificacion).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CalificacioneExists(id))
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

        private bool CalificacioneExists(int id)
        {
            return _context.Calificaciones.Any(e => e.CalificacionId == id);
        }
    }
}
