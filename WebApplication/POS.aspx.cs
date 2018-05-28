using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication
{
    public partial class POS : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            Session["foodKey"] = e.CommandArgument.ToString();
         }

        protected void ListView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void BtnAddOrder_ServerClick(object sender, EventArgs e)
        {
            // Go get each selected item from the checkbox list
            List<string> selectedValues = CheckBoxList1.Items.Cast<ListItem>()
                .Where(li => li.Selected)
                .Select(li => li.Value)
                .ToList();

            // do black magic here
        }
    }
}