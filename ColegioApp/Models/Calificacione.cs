using System;
using System.Collections.Generic;

namespace ColegioApp.Models;

public partial class Calificacione
{
    public int CalificacionId { get; set; }

    public int? EstudianteId { get; set; }

    public int? CursoId { get; set; }

    public int? AsignaturaId { get; set; }

    public int? Nota { get; set; }

    public string? Literal { get; set; } = null!;

    public DateTime FechaRegistro { get; set; }

    public virtual Asignatura? Asignatura { get; set; }

    public virtual Curso? Curso { get; set; }

    public virtual Estudiante? Estudiante { get; set; }
}
