using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace ColegioApp.Models;

public partial class ColegioDbContext : DbContext
{
    private readonly IConfiguration _configuration;

    public ColegioDbContext(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    public ColegioDbContext(DbContextOptions<ColegioDbContext> options, IConfiguration configuration)
        : base(options)
    {
        _configuration = configuration;
    }

    public virtual DbSet<Asignatura> Asignaturas { get; set; }

    public virtual DbSet<Asistencia> Asistencias { get; set; }

    public virtual DbSet<RecordAsistencia> RecordAsistencias { get; set; }

    public virtual DbSet<Calificacione> Calificaciones { get; set; }

    public virtual DbSet<Curso> Cursos { get; set; }

    public virtual DbSet<Estudiante> Estudiantes { get; set; }

    public virtual DbSet<Nivele> Niveles { get; set; }

    public virtual DbSet<Role> Roles { get; set; }

    public virtual DbSet<Usuario> Usuarios { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        if (!optionsBuilder.IsConfigured)
        {
            var connectionString = _configuration.GetConnectionString("ColegioDb");
            optionsBuilder.UseSqlServer(connectionString);
        }
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Asignatura>(entity =>
        {
            entity.HasKey(e => e.AsignaturaId).HasName("PK__Asignatu__EB67ED9E7CB21B95");

            entity.HasIndex(e => e.NombreAsignatura, "UQ__Asignatu__101CCCC53D939423").IsUnique();

            entity.Property(e => e.AsignaturaId).HasColumnName("AsignaturaID");
            entity.Property(e => e.NombreAsignatura)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Asistencia>(entity =>
        {
            entity.HasKey(e => e.AsistenciaId).HasName("PK__Asistenc__72710F4579384265");

            entity.Property(e => e.AsistenciaId).HasColumnName("AsistenciaID");
            entity.Property(e => e.EstudianteId).HasColumnName("EstudianteID");
            entity.Property(e => e.Fecha).HasColumnType("datetime");
            entity.Property(e => e.RecordId).HasColumnName("RecordID");

            entity.HasOne(d => d.Estudiante).WithMany(p => p.Asistencia)
                .HasForeignKey(d => d.EstudianteId)
                .HasConstraintName("FK__Asistenci__Estud__6383C8BA");

            entity.HasOne(d => d.Record).WithMany(p => p.Asistencia)
                .HasForeignKey(d => d.RecordId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Asistenci__Recor__73BA3083");
        });

        modelBuilder.Entity<Calificacione>(entity =>
        {
            entity.HasKey(e => e.CalificacionId).HasName("PK__Califica__4CF54ABE1866E906");

            entity.Property(e => e.CalificacionId).HasColumnName("CalificacionID");
            entity.Property(e => e.AsignaturaId).HasColumnName("AsignaturaID");
            entity.Property(e => e.CursoId).HasColumnName("CursoID");
            entity.Property(e => e.EstudianteId).HasColumnName("EstudianteID");
            entity.Property(e => e.FechaRegistro).HasColumnType("datetime");
            entity.Property(e => e.Literal)
                .HasMaxLength(1)
                .IsUnicode(false);

            entity.HasOne(d => d.Asignatura).WithMany(p => p.Calificaciones)
                .HasForeignKey(d => d.AsignaturaId)
                .HasConstraintName("FK__Calificac__Asign__68487DD7");

            entity.HasOne(d => d.Curso).WithMany(p => p.Calificaciones)
                .HasForeignKey(d => d.CursoId)
                .HasConstraintName("FK__Calificac__Curso__6754599E");

            entity.HasOne(d => d.Estudiante).WithMany(p => p.Calificaciones)
                .HasForeignKey(d => d.EstudianteId)
                .HasConstraintName("FK__Calificac__Estud__66603565");
        });

        modelBuilder.Entity<Curso>(entity =>
        {
            entity.HasKey(e => e.CursoId).HasName("PK__Cursos__7E023A3768A653A3");

            entity.Property(e => e.CursoId).HasColumnName("CursoID");
            entity.Property(e => e.Descripcion).HasColumnType("text");
            entity.Property(e => e.NivelId).HasColumnName("NivelID");
            entity.Property(e => e.NombreCurso)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.ProfesorId).HasColumnName("ProfesorID");

            entity.HasOne(d => d.Nivel).WithMany(p => p.Cursos)
                .HasForeignKey(d => d.NivelId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Cursos__NivelID__47DBAE45");

            entity.HasOne(d => d.Profesor).WithMany(p => p.Cursos)
                .HasForeignKey(d => d.ProfesorId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Cursos__NivelID__46E78A0C");
        });

        modelBuilder.Entity<Estudiante>(entity =>
        {
            entity.HasKey(e => e.EstudianteId).HasName("PK__Estudian__6F7683389AC2E557");

            entity.HasIndex(e => e.Email, "UQ__Estudian__A9D10534D424B051").IsUnique();

            entity.Property(e => e.EstudianteId).HasColumnName("EstudianteID");
            entity.Property(e => e.CursoId).HasColumnName("CursoID");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.FechaNacimiento).HasColumnType("datetime");
            entity.Property(e => e.Nombre)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.Sexo)
                .HasMaxLength(1)
                .IsUnicode(false);

            entity.HasOne(d => d.Curso).WithMany(p => p.Estudiantes)
                .HasForeignKey(d => d.CursoId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Estudiant__Curso__693CA210");
        });

        modelBuilder.Entity<Nivele>(entity =>
        {
            entity.HasKey(e => e.NivelId).HasName("PK__Niveles__316FA29733DFBB03");

            entity.Property(e => e.NivelId).HasColumnName("NivelID");
            entity.Property(e => e.CoordinadorId).HasColumnName("CoordinadorID");
            entity.Property(e => e.NombreNivel)
                .HasMaxLength(50)
                .IsUnicode(false);

            entity.HasOne(d => d.Coordinador).WithMany(p => p.Niveles)
                .HasForeignKey(d => d.CoordinadorId)
                .HasConstraintName("FK__Niveles__Coordin__6B24EA82");
        });

        modelBuilder.Entity<RecordAsistencia>(entity =>
        {
            entity.HasKey(e => e.RecordId);

            entity.Property(e => e.RecordId).HasColumnName("RecordID");
            entity.Property(e => e.CursoId).HasColumnName("CursoID");
            entity.Property(e => e.FechaRegistro).HasColumnType("datetime");

            entity.HasOne(d => d.Curso).WithMany(p => p.RecordAsistencia)
                .HasForeignKey(d => d.CursoId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__RecordAsi__Curso__75A278F5");

            entity.HasOne(d => d.UsuarioRegistroNavigation).WithMany(p => p.RecordAsistencia)
                .HasForeignKey(d => d.UsuarioRegistro)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__RecordAsi__Usuar__74AE54BC");
        });

        modelBuilder.Entity<Role>(entity =>
        {
            entity.HasKey(e => e.RoleId).HasName("PK__Roles__8AFACE3A3400B44B");

            entity.HasIndex(e => e.RoleName, "UQ__Roles__8A2B6160EDA88492").IsUnique();

            entity.Property(e => e.RoleId).HasColumnName("RoleID");
            entity.Property(e => e.RoleName)
                .HasMaxLength(50)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Usuario>(entity =>
        {
            entity.HasKey(e => e.UsuarioId).HasName("PK__Usuarios__2B3DE798CC18A69B");

            entity.HasIndex(e => e.Email, "UQ__Usuarios__A9D1053439169C68").IsUnique();

            entity.Property(e => e.UsuarioId).HasColumnName("UsuarioID");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.Nombre)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.PasswordHash)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.RoleId).HasColumnName("RoleID");

            entity.HasOne(d => d.Role).WithMany(p => p.Usuarios)
                .HasForeignKey(d => d.RoleId)
                .HasConstraintName("FK__Usuarios__RoleID__3E52440B");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
