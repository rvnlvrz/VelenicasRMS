using System.Collections.Generic;

namespace ClassLibrary.POS
{
    public class Order
    {
        public Order()
        {
            Total = 0.00m;
            OrderItems = new List<OrderItem>();
        }

        public List<OrderItem> OrderItems { get; }
        public decimal Total { get; private set; }

        public bool AddOrder(OrderItem orderItem)
        {
            OrderItems.Add(orderItem);
            Total += orderItem.Item.Price;
            return true;
        }

        public bool RemoveOrder(int orderIndex)
        {
            var orderItem = OrderItems[orderIndex];
            OrderItems.RemoveAt(orderIndex);
            Total -= orderItem.Item.Price;
            return true;
        }
    }
}