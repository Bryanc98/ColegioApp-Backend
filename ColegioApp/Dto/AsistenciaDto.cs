namespace ColegioApp.Dto
{
    public class AsistenciaDto
    {
        public int AsistenciaId { get; set; }

        public int? EstudianteId { get; set; }

        public DateTime Fecha { get; set; }

        public bool Presente { get; set; }

        public int RecordId { get; set; }
    }
}
