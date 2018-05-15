using ClassLibrary.Inventory;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace ClassLibraryTests.Inventory
{
    [TestClass]
    public class ItemTests
    {
        [TestMethod]
        public void ItemTest()
        {
            var item = new Item(10, 51.25m, true, 3);
            Assert.IsNotNull(item);
        }

        [TestMethod]
        public void AddQuantityTest()
        {
            var item = new Item(10, 51.25m, true, 3);
            item.AddQuantity(5);
            Assert.AreEqual(item.Quantity, 15);
        }

        [TestMethod]
        public void SubtractQuantityTest()
        {
            var item = new Item(10, 51.25m, true, 3);
            item.SubtractQuantity(5);
            Assert.AreEqual(item.Quantity, 5);
        }

        [TestMethod]
        public void NeedsRestockingTest()
        {
            var item = new Item(10, 51.25m, true, 3);
            item.SubtractQuantity(7);
            Assert.IsTrue(item.NeedsRestocking());
        }

        [TestMethod]
        public void IsAvailableTest()
        {
            var item = new Item(0, 51.25m, true, 3);
            Assert.IsTrue(!item.IsAvailable());
        }
    }
}