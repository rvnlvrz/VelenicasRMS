using ClassLibrary;
using ClassLibrary.Inventory;
using ClassLibrary.POS;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace ClassLibraryTests
{
    [TestClass()]
    public class OrderTests
    {
        private Order _order;

        [TestMethod()]
        public void OrderTest()
        {
            _order = new Order();
            Assert.IsNotNull(_order);
        }

        [TestMethod()]
        public void AddOrderTest()
        {
            _order = new Order();
            _order.AddOrder(new OrderItem(new Item(10, 51.25m, true, 3), 5));
            _order.AddOrder(new OrderItem(new Item(2, 51.25m, true, 3), 5));
            _order.AddOrder(new OrderItem(new Item(1, 51.25m, true, 3), 5));
            _order.AddOrder(new OrderItem(new Item(2, 51.25m, true, 3), 5));
            _order.AddOrder(new OrderItem(new Item(1, 51.25m, true, 3), 5));
            Assert.AreEqual(_order.OrderItems.Count, 5);
        }

        [TestMethod()]
        public void RemoveOrderTest()
        {
            _order = new Order();
            _order.AddOrder(new OrderItem(new Item(10, 51.25m, true, 3), 5));
            _order.AddOrder(new OrderItem(new Item(2, 51.25m, true, 3), 5));
            _order.AddOrder(new OrderItem(new Item(1, 51.25m, true, 3), 5));
            _order.AddOrder(new OrderItem(new Item(2, 51.25m, true, 3), 5));
            _order.AddOrder(new OrderItem(new Item(1, 51.25m, true, 3), 5));
            int index = _order.OrderItems.FindIndex(item => item.Item.Quantity == 10);
            _order.RemoveOrder(index);
            Assert.AreEqual(_order.OrderItems.Count, 4);
        }
    }
}