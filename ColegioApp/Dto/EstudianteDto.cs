namespace ColegioApp.Dto
{
    public class EstudianteDto
    {
        public int estudianteId { get; set; }

        public string nombre { get; set; } = null!;

        public string? email { get; set; }

        public string sexo { get; set; } = null!;

        public DateTime fechaNacimiento { get; set; }

        public int cursoId { get; set; }
    }
}
