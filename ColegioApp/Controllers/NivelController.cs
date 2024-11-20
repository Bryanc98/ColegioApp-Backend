using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ColegioApp.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NivelController : ControllerBase
    {
        private readonly ColegioDbContext _context;

        public NivelController(ColegioDbContext context)
        {
            this._context = context;
        }

        [HttpGet]
        public async Task<IActionResult> GetNiveles()
        {
            var niveles = await _context.Niveles.ToListAsync();
            return Ok(niveles);
        }
    }
}
