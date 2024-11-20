namespace ColegioApp.Dto
{
    public class RecordAsistenciaDto
    {
        public int RecordId { get; set; }

        public int CursoId { get; set; }

        public DateTime FechaRegistro { get; set; }

        public int UsuarioRegistro { get; set; }

        public virtual ICollection<AsistenciaDto> Asistencias { get; set; } = new List<AsistenciaDto>();
    }
}
