using ClassLibrary.Inventory;

namespace ClassLibrary.POS
{
    public class OrderItem
    {
        public Item Item { get; }
        private int Quantity { get; set; }

        public OrderItem(Item item, int quantity)
        {
            Quantity = quantity;
            Item = item;
        }

        public bool AddQuantity(int value)
        {
            Quantity = Quantity + value;
            return true;
        }

        public bool SubtractQuantity(int value)
        {
            Quantity = Quantity - value;
            return true;
        }
    }
}
