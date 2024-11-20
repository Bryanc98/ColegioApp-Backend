using ColegioApp.Dto;
using ColegioApp.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ColegioApp.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AsistenciaController : ControllerBase
    {
        private readonly ColegioDbContext _context;
        public AsistenciaController(ColegioDbContext context)
        {
            _context = context;
        }


        [HttpGet("Record")]
        public async Task<IActionResult> GetAsistencia(int? cursoId, int? nivelId, int? recordId)
        {
            var asistencias = await _context.RecordAsistencias
            .Include(r => r.Curso)
            .Where(r => (cursoId == null || r.Curso.CursoId == cursoId)
            && (nivelId == null || r.Curso.Nivel.NivelId == nivelId)
                    && (recordId == null || r.RecordId == recordId))
        .Select(a => new
        {
            a.RecordId,
            a.FechaRegistro,
            a.UsuarioRegistro,
            Curso = new
            {
                a.Curso.CursoId,
                a.Curso.NombreCurso
            },
            Nivel = new
            {
                a.Curso.Nivel.NivelId,
                a.Curso.Nivel.NombreNivel
            }
        })
        .ToListAsync();
            return Ok(asistencias);
        }



        [HttpGet("{id}")]
        public async Task<IActionResult> GetAsistenciaByRecordId(int id)
        {
            var record = await _context.RecordAsistencias
                .Include(r => r.Curso)
                .Where(r => r.RecordId == id)
                .Select(r => new
                {
                    r.RecordId,
                    r.FechaRegistro,
                    Curso = new
                    {
                        r.Curso.CursoId,
                        r.Curso.NombreCurso
                    },
                    Nivel = new
                    {
                        r.Curso.Nivel.NivelId,
                        r.Curso.Nivel.NombreNivel
                    }
                })
                .FirstOrDefaultAsync();

            if (record == null)
            {
                return NotFound();
            }

            var asistencias = await _context.Asistencias
                .Include(a => a.Estudiante)
                .Where(a => a.RecordId == record.RecordId)
                .Select(a => new
                {
                    a.AsistenciaId,
                    a.Estudiante!.EstudianteId,
                    nombre = a.Estudiante.Nombre,
                    a.Presente
                })
                .ToListAsync();

            var result = new
            {
                Record = record,
                Asistencias = asistencias
            };

            return Ok(result);
        }


        [HttpPost]
        public async Task<IActionResult> PostAsistencia(RecordAsistenciaDto record)
        {
            if (record == null || record.Asistencias == null || !record.Asistencias.Any())
            {
                return BadRequest("El registro de asistencia no es válido.");
            }

            var existeAsistencia = await _context.RecordAsistencias
                .AnyAsync(r => r.CursoId == record.CursoId && r.FechaRegistro.Date == record.FechaRegistro.Date);

            if (existeAsistencia)
            {
                return BadRequest("Ya existe un registro de asistencia para este curso en la fecha especificada.");
            }

            var recordAsistencia = new RecordAsistencia
            {
                CursoId = record.CursoId,
                FechaRegistro = record.FechaRegistro,
                UsuarioRegistro = record.UsuarioRegistro
            };

            _context.RecordAsistencias.Add(recordAsistencia);
            await _context.SaveChangesAsync();

            foreach (var asistenciaDto in record.Asistencias)
            {
                var asistencia = new Asistencia
                {
                    EstudianteId = asistenciaDto.EstudianteId,
                    Fecha = asistenciaDto.Fecha,
                    Presente = asistenciaDto.Presente,
                    RecordId = recordAsistencia.RecordId
                };

                _context.Asistencias.Add(asistencia);
            }

            await _context.SaveChangesAsync();

            return Ok(new
            {
                Message = "Asistencias registradas satisfactoriamente"
            });
        }

        [HttpPut]
        public async Task<IActionResult> PutAsistencia(RecordAsistenciaDto record)
        {
            if (record == null || record.Asistencias == null || !record.Asistencias.Any())
            {
                return BadRequest("El registro de asistencia no es válido.");
            }

            var recordAsistencia = await _context.RecordAsistencias
                .Include(r => r.Asistencia)
                .FirstOrDefaultAsync(r => r.RecordId == record.RecordId);

            if (recordAsistencia == null)
            {
                return NotFound("El registro de asistencia no existe.");
            }

            //Mejora: agregar un campo fechaActualizacion a la tabla recordAsistencias y a asistencias, asi llevar un control de cuando fue modificada
            recordAsistencia.CursoId = record.CursoId;
            recordAsistencia.FechaRegistro = record.FechaRegistro;
            recordAsistencia.UsuarioRegistro = record.UsuarioRegistro;

            foreach (var asistenciaDto in record.Asistencias)
            {
                var asistencia = await _context.Asistencias
                    .FirstOrDefaultAsync(a => a.AsistenciaId == asistenciaDto.AsistenciaId && a.EstudianteId == asistenciaDto.EstudianteId);

                if (asistencia != null)
                {
                    asistencia.EstudianteId = asistenciaDto.EstudianteId;
                    asistencia.Fecha = asistenciaDto.Fecha;
                    asistencia.Presente = asistenciaDto.Presente;
                }
                else
                {
                    asistencia = new Asistencia
                    {
                        EstudianteId = asistenciaDto.EstudianteId,
                        Fecha = asistenciaDto.Fecha,
                        Presente = asistenciaDto.Presente,
                        RecordId = recordAsistencia.RecordId
                    };
                    _context.Asistencias.Add(asistencia);
                }
            }

            await _context.SaveChangesAsync();

            return Ok(new
            {
                Message = "Asistencias actualizadas satisfactoriamente"
            });
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteAsistencia(int id)
        {
            var recordAsistencia = await _context.RecordAsistencias
                .Include(r => r.Asistencia)
                .FirstOrDefaultAsync(r => r.RecordId == id);

            if (recordAsistencia == null)
            {
                return NotFound("El registro de asistencia no existe.");
            }

            // Eliminar las asistencias relacionadas
            var asistencias = await _context.Asistencias
                .Where(a => a.RecordId == id)
                .ToListAsync();

            _context.Asistencias.RemoveRange(asistencias);

            // Eliminar el record de asistencia
            _context.RecordAsistencias.Remove(recordAsistencia);

            await _context.SaveChangesAsync();

            return Ok(new
            {
                Message = "Registro de asistencia y asistencias relacionadas eliminadas satisfactoriamente"
            });
        }
    }
}
