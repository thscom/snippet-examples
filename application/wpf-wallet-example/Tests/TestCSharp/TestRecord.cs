namespace TestCSharp
{

    record Person (string FirstName, string LastName);

    [TestClass]
    public sealed class TestRecord
    {
        [TestMethod]
        public void Test_01_Record()
        {
            Person p = new Person("Tom", "Crouse");
            Console.WriteLine(p);
            Person p1 = new Person("Tom", "Crouse");
            Assert.AreEqual(p, p1);
            Assert.IsFalse(ReferenceEquals(p, p1));
        }
    }
}
