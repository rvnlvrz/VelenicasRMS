using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication.UserControl
{
    public partial class AddItemControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataTable dt = new DataTable();
                DataRow row;
                DataColumn col1 = new DataColumn("col1");
                DataColumn col2 = new DataColumn("col2");

                dt.Columns.Add(col1);
                dt.Columns.Add(col2);

                row = dt.NewRow();
                row["col1"] = "1";
                row["col2"] = "Food";
                dt.Rows.Add(row);
                row = dt.NewRow();
                row["col1"] = "2";
                row["col2"] = "Beverage";
                dt.Rows.Add(row);

                DropDownListType.DataValueField = "col1";
                DropDownListType.DataTextField = "col2";

                DropDownListType.Items.Add("Food");
                DropDownListType.Items.Add("Beverage");
                DropDownListType.DataBind();
            }
        }

        protected void DropDownListType_SelectedIndexChanged(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }
    }
}