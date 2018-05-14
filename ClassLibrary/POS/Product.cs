using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ClassLibrary.Inventory;

namespace ClassLibrary.POS
{
    class Product
    {
        private int _id;
        private List<Tuple<Item, int>> ingredients;
        private decimal price;

        public bool IsAvailable()
        {
            return ingredients.FindIndex(item => !item.Item1.IsAvailable()) != -1;
        }
    }
}
