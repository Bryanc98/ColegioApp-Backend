using System;
using System.Collections.Generic;

namespace ColegioApp.Models;

public partial class Nivele
{
    public int NivelId { get; set; }

    public string NombreNivel { get; set; } = null!;

    public int? CoordinadorId { get; set; }

    public virtual Usuario? Coordinador { get; set; }

    public virtual ICollection<Curso> Cursos { get; set; } = new List<Curso>();
}
