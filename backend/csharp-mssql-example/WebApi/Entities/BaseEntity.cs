namespace WebApi.Models
{
    public abstract class BaseEntity
    {
        /// <summary>
        /// Create Time
        /// </summary>
        public DateTime CreateTime { get; set; } = DateTime.Now;

        /// <summary>
        /// Modify Time
        /// </summary>
        public DateTime UpdateTime { get; set; }

        /// <summary>
        /// Status:  0-Normal  1-Frozen 2-Deleted
        /// </summary>
        public int Status { get; set; }
    }
}
