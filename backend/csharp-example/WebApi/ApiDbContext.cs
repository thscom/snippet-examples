using Microsoft.EntityFrameworkCore;
using WebApi.Models;

namespace WebApi
{
    public class ApiDbContext : DbContext
    {
        /// <summary>
        /// Connection String
        /// </summary>
        private string _connectionString;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="connectionString"></param>
        public ApiDbContext(string connectionString)
        {
            _connectionString = connectionString;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="options"></param>
        public ApiDbContext(DbContextOptions<ApiDbContext> options) : base(options) { }

        /// <summary>
        /// Entity Decalration
        /// </summary>
        public virtual DbSet<UserEntity> UserEntities { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlServer(_connectionString);
                //base.OnConfiguring(optionsBuilder);
            }
        }

        /// <summary>
        /// Mapping for Table and Entity
        /// </summary>
        /// <param name="modelBuilder"></param>
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            //base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<UserEntity>(entity =>
            {
                entity.ToTable("users").HasKey(u => u.Id);
            });
        }
    }

}
