﻿using System.Collections.Generic;

namespace ClassLibrary
{
    public class Order
    {
        public List<OrderItem> OrderItems { get; private set; }
        private decimal Total { get; set; }

        public Order()
        {
            Total = 0.00m;
            OrderItems = new List<OrderItem>();
        }

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
