using System;
using System.Collections.Generic;

namespace ColegioApp.Models;

public partial class RecordAsistencia
{
    public int RecordId { get; set; }

    public DateTime FechaRegistro { get; set; }

    public int UsuarioRegistro { get; set; }

    public int CursoId { get; set; }

    public virtual ICollection<Asistencia> Asistencia { get; set; } = new List<Asistencia>();

    public virtual Curso Curso { get; set; } = null!;

    public virtual Usuario UsuarioRegistroNavigation { get; set; } = null!;
}
