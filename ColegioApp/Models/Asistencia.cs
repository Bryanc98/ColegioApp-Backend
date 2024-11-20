using System;
using System.Collections.Generic;

namespace ColegioApp.Models;

public partial class Asistencia
{
    public int AsistenciaId { get; set; }

    public int? EstudianteId { get; set; }

    public DateTime Fecha { get; set; }

    public bool Presente { get; set; }

    public int RecordId { get; set; }

    public virtual Estudiante? Estudiante { get; set; }

    public virtual RecordAsistencia Record { get; set; } = null!;
}
