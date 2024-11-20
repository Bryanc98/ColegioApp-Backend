using System;
using System.Collections.Generic;

namespace ColegioApp.Models;

public partial class Curso
{
    public int CursoId { get; set; }

    public string NombreCurso { get; set; } = null!;

    public string? Descripcion { get; set; }

    public int ProfesorId { get; set; }

    public int NivelId { get; set; }

    public virtual ICollection<Calificacione> Calificaciones { get; set; } = new List<Calificacione>();

    public virtual ICollection<Estudiante> Estudiantes { get; set; } = new List<Estudiante>();

    public virtual Nivele Nivel { get; set; } = null!;

    public virtual Usuario Profesor { get; set; } = null!;

    public virtual ICollection<RecordAsistencia> RecordAsistencia { get; set; } = new List<RecordAsistencia>();
}
