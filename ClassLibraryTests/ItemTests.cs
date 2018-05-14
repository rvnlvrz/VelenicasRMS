using ClassLibrary;
using ClassLibrary.Inventory;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace ClassLibraryTests
{
    [TestClass()]
    public class ItemTests
    {
        private Item _item;

        [TestMethod()]
        public void ItemTest()
        {
            _item = new Item(10, 51.25m, true, 3);
            Assert.IsNotNull(_item);
        }

        [TestMethod()]
        public void AddQuantityTest()
        {
            _item.AddQuantity(5);
            Assert.AreEqual(_item.Quantity, 15);
        }

        [TestMethod()]
        public void SubtractQuantityTest()
        {
            _item.SubtractQuantity(5);
            Assert.AreEqual(_item.Quantity, 10);
        }

        [TestMethod()]
        public void NeedsRestockingTest()
        {
            var item = new Item(10, 51.25m, true, 3);
            item.SubtractQuantity(7);
            Assert.IsTrue(item.NeedsRestocking());
        }
    }
}