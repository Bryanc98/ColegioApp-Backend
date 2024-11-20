namespace ColegioApp.Dto
{
    public class CalificacionDto
    {
        public required CursoCalificacion Curso { get; set; }
        public required EstudianteCalificacion Estudiante { get; set; }
        public required Nivel Nivel { get; set; }
        public required List<Calificacion> Calificaciones { get; set; }



    }

    public class CursoCalificacion
    {
        public int CursoId { get; set; }
        public string? NombreCurso { get; set; }
    }

    public class EstudianteCalificacion
    {
        public int EstudianteId { get; set; }
        public string? NombreEstudiante { get; set; }
    }

    public class Nivel
    {
        public int NivelId { get; set; }
        public string? NombreNivel { get; set; }
    }

    public class Calificacion
    {
        public int CalificacionId { get; set; }
        public int AsignaturaId { get; set; }
        public string? NombreAsignatura { get; set; }
        public int? Nota { get; set; }
        public string? Literal { get; set; }
    }
}
