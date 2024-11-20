using System;
using System.Collections.Generic;

namespace ColegioApp.Models;

public partial class Asignatura
{
    public int AsignaturaId { get; set; }

    public string NombreAsignatura { get; set; } = null!;

    public virtual ICollection<Calificacione> Calificaciones { get; set; } = new List<Calificacione>();
}
