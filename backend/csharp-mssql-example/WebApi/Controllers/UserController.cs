using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApi.Constants;
using WebApi.Models;
using WebApi.Services;

namespace WebApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    [ApiExplorerSettings(GroupName = nameof(VersionInfo.v1))]
    public class UserController : ControllerBase
    {

        private ApiDbContext _context;
        private readonly AuthService _authService;

        private readonly ILogger<UserController> _logger;

        public UserController(ApiDbContext context, AuthService authService, ILogger<UserController> logger)
        {
            _authService = authService;
            _logger = logger;
            _context = context;
            _context.Database.EnsureCreated();
        }

        /// <summary>
        /// Get All Users
        /// </summary>
        /// <returns></returns>
        [HttpGet("[action]")]
        public async Task<ActionResult<IEnumerable<UserEntity>>> GetUsers()
        {
            var users = await _context.UserEntities.ToListAsync();
            return Ok(users);
        }

        [HttpGet("[action]")]
        public string Login(string username = "John", string password = "123")
        {
            var user = new UserEntity()
            {
                Id = 1,
                Name = username,
                Password = password,
                Roles = ["admin"]
            };

            return _authService.Create(user);

        }

        [Authorize]
        [HttpGet("[action]")]
        public StatusCodeResult testAuth()
        {
            return StatusCode(StatusCodes.Status200OK);
        }

        [Authorize("rolePolicy")]
        [HttpGet("[action]")]
        public StatusCodeResult testRole()
        {
            return StatusCode(StatusCodes.Status200OK);
        }

        // Example
        //[HttpGet(Name = "GetWeatherForecast")]
        //public IEnumerable<WeatherForecast> Get()
        //{
        //    return Enumerable.Range(1, 5).Select(index => new WeatherForecast
        //    {
        //        Date = DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
        //        TemperatureC = Random.Shared.Next(-20, 55),
        //        Summary = Summaries[Random.Shared.Next(Summaries.Length)]
        //    })
        //    .ToArray();
        //}
    }
}
