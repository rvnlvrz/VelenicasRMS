using DataAccessLayer;
using DataAccessLayer.VelenicasRMSTableAdapters;

namespace BusinessLogicLayer
{
    public class FoodLogic
    {
        private FoodProductsTableAdapter _productsTableAdapter;

        private FoodProductsTableAdapter Adapter
        {
            get
            {
                if (_productsTableAdapter == null)
                    _productsTableAdapter = new FoodProductsTableAdapter();
                return _productsTableAdapter;
            }
        }

        public VelenicasRMS.FoodProductsDataTable GetFoodProducts()
        {
            return Adapter.GetFoodProducts();
        }

        public VelenicasRMS.FoodProductsDataTable GetFoodProducts(int id)
        {
            return Adapter.GetFoodProductByID(id);
        }

        public bool AddFoodProduct(decimal price, string name, int personCount)
        {
            var rowsAffected = Adapter.AddFoodProduct(name, price, personCount);
            return rowsAffected == 1;
        }

        public bool UpdateFoodProduct(string name, decimal price, int personCount, int productId)
        {
            var rowsAffected = Adapter.UpdateFoodProduct(name, price, personCount, productId);
            return rowsAffected == 1;
        }

        public bool DeleteFoodProduct(int productId)
        {
            var rowsAffected = Adapter.DeleteFoodProduct(productId);
            return rowsAffected == 1;
        }
    }
}