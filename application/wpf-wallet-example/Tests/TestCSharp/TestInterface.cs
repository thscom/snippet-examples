using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TestCSharp
{

    class Car : IEquatable<Car>
    {
        public string? Name { get; set; }
        public string? Description { get; set; }

        public bool Equals(Car? other)
        {
            return this.Name == other?.Name;
        }
    }
    public sealed class TestInterface
    {
        public void Test_01_IEquatable()
        {
            Car c1 = new Car() { Name = "A" ,Description = "A.."};
            Car c2 = new Car() { Name = "A", Description = "A." };
            Assert.AreEqual(c1, c2);
            Assert.IsFalse(ReferenceEquals(c1, c2));
        }

        public void Test_02_IEquatable()
        {
            var cs = new[] { new { ID=1, Name= "A" }, new { ID = 2, Name = "A" } };
            var cs2 = from c in cs where c.ID < 2 select c;
            Assert.AreEqual(1, cs2.Count());
        }
    }
}
