using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccessLayer;
using DataAccessLayer.VelenicasRMSTableAdapters;

namespace BusinessLogicLayer
{
    public class BeverageLogic
    {
        private BeverageProductsTableAdapter _productsTableAdapter;

        private BeverageProductsTableAdapter Adapter
        {
            get
            {
                if (_productsTableAdapter == null)
                    _productsTableAdapter = new BeverageProductsTableAdapter();
                return _productsTableAdapter;
            }
        }

        public VelenicasRMS.BeverageProductsDataTable GetBeverageProducts()
        {
            return Adapter.GetBeverageProducts();
        }

        public VelenicasRMS.BeverageProductsDataTable GetBeverageProducts(int id)
        {
            return Adapter.GetBeverageProductByID(id);
        }

        public bool DeleteFoodProduct(int productId)
        {
            var rowsAffected = Adapter.DeleteBeverageProduct(productId);
            return rowsAffected == 1;
        }
    }
}
