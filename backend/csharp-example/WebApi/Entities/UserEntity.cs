using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApi.Models
{
    public class UserEntity : BaseEntity
    {
        [Key, Column("id", Order = 1)]
        public int Id { get; set; }

        [Column("username")]

        public string Name { get; set; }

        [Column("password")]
        public string Password { get; set; }

        [Column("roles")]
        public string[] Roles { get; set; }
    }
}

