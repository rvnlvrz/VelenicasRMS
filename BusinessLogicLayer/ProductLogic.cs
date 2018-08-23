using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccessLayer;
using DataAccessLayer.VelenicasRMSTableAdapters;

namespace BusinessLogicLayer
{
    public class ProductLogic
    {
        private ProductsTableAdapter _productsTableAdapter;

        private ProductsTableAdapter Adapter
        {
            get
            {
                if (_productsTableAdapter == null)
                    _productsTableAdapter = new ProductsTableAdapter();
                return _productsTableAdapter;
            }
        }

        public VelenicasRMS.ProductsDataTable GetProductsByMenuId(int? menuId)
        {
            if (menuId == -1) menuId = null;
            return Adapter.GetProductsByMenuID(menuId);
        }

        public bool UpdateMenuId(int? menuId, int productId)
        {
            if (menuId == -1) menuId = null;
            return Adapter.UpdateMenuID(menuId, productId) == 1;
        }
    }
}
