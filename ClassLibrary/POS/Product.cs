using System;
using System.Collections.Generic;
using ClassLibrary.Inventory;

namespace ClassLibrary.POS
{
    public class Product
    {
        private int _id;
        private List<Tuple<Item, int>> ingredients;
        private decimal price;

        public int Id()
        {
            return _id;
        }

        public bool IsAvailable()
        {
            return ingredients.FindIndex(item => !item.Item1.IsAvailable()) != -1;
        }
    }
}