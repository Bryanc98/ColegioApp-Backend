using System;
using System.Collections.Generic;

namespace ColegioApp.Models;

public partial class Usuario
{
    public int UsuarioId { get; set; }

    public string Nombre { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string PasswordHash { get; set; } = null!;

    public int? RoleId { get; set; }

    public virtual ICollection<Curso> Cursos { get; set; } = new List<Curso>();

    public virtual ICollection<Nivele> Niveles { get; set; } = new List<Nivele>();

    public virtual ICollection<RecordAsistencia> RecordAsistencia { get; set; } = new List<RecordAsistencia>();

    public virtual Role? Role { get; set; }
}
