using System;
using System.Collections.Generic;

namespace ColegioApp.Models;

public partial class Estudiante
{
    public int EstudianteId { get; set; }

    public string Nombre { get; set; } = null!;

    public string? Email { get; set; }

    public string Sexo { get; set; } = null!;

    public DateTime FechaNacimiento { get; set; }

    public int CursoId { get; set; }

    public virtual ICollection<Asistencia> Asistencia { get; set; } = new List<Asistencia>();

    public virtual ICollection<Calificacione> Calificaciones { get; set; } = new List<Calificacione>();

    public virtual Curso Curso { get; set; } = null!;
}
