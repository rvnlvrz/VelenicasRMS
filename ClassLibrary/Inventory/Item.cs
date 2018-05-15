namespace ClassLibrary.Inventory
{
    public class Item
    {
        private int _id;

        public Item(int quantity, decimal price, bool resellable, int threshold)
        {
            Quantity = quantity;
            Price = price;
            Resellable = resellable;
            Threshold = threshold;
        }

        public int Quantity { get; private set; }
        private int Threshold { get; }
        public decimal Price { get; }
        private bool Resellable { get; }

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

        public int Id()
        {
            return _id;
        }

        public bool NeedsRestocking()
        {
            return Quantity <= Threshold;
        }

        public bool IsAvailable()
        {
            return Quantity != 0;
        }
    }
}