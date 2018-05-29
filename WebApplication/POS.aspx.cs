using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Transactions;
using System.Configuration;

namespace WebApplication
{
    public partial class POS : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["VelenicasRMSConnectionString"].ConnectionString;

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

            foreach (var value in selectedValues)
            {
                AddToTransaction(Convert.ToInt32(value));
            }

            GridView1.DataBind();
            ScriptManager.RegisterStartupScript(BtnConfirmStart, GetType(), "CategoricalMenuModal",
                @"$('#CategoricalMenuModal').modal('hide');", true);
        }

        protected void BtnConfirmStart_ServerClick(object sender, EventArgs e)
        {
            int transactionID = -1;

            using (TransactionScope scope = new TransactionScope(TransactionScopeOption.RequiresNew))
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(connString))
                    {
                        using (SqlCommand comm = new SqlCommand("AddNewTransaction", conn))
                        {
                            comm.CommandType = CommandType.StoredProcedure;

                            conn.Open();

                            comm.ExecuteNonQuery();
                            scope.Complete();
                        }
                    }
                }
                catch (Exception)
                {

                }
            }

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand("SELECT IDENT_CURRENT('Orders') AS ID", conn))
                {
                    conn.Open();

                    using (SqlDataReader reader = comm.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            transactionID = Convert.ToInt32(reader["ID"]);
                        }
                    }
                }
            }

            Session["transacID"] = transactionID;
            GridView1.DataBind();
            ScriptManager.RegisterStartupScript(BtnConfirmStart, GetType(), "NewTransacModal",
                @"$('#NewTransacModal').modal('hide');", true);

        }

        protected void AddToTransaction(int menuItemID)
        {
            using (TransactionScope scope = new TransactionScope(TransactionScopeOption.RequiresNew))
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(connString))
                    {
                        using (SqlCommand comm = new SqlCommand("AddToTransaction", conn))
                        {
                            comm.CommandType = CommandType.StoredProcedure;
                            comm.Parameters.Add("@MenuItemID", SqlDbType.Int).Value = Convert.ToInt32(menuItemID);
                            comm.Parameters.Add("@quant", SqlDbType.Int).Value = 1;

                            conn.Open();

                            comm.ExecuteNonQuery();
                            scope.Complete();
                        }
                    }
                }
                catch (Exception)
                {

                }
            }
        }

        protected void BtnConCancelTransac_ServerClick(object sender, EventArgs e)
        {
            GridView1.DataBind();
            ScriptManager.RegisterStartupScript(BtnConfirmStart, GetType(), "CancelTransacModal",
                @"$('#CancelTransacModal').modal('hide');", true);
        }

        protected void BtnUpdateTransac_ServerClick(object sender, EventArgs e)
        {
            TextBox quantTbx = (TextBox)FvwTransacItem.Row.FindControl("QuantityTextBox");
            TextBox priceTbx = (TextBox)FvwTransacItem.Row.FindControl("PriceTextBox");

            if (DiscountTextBox.Enabled)
            {
                decimal price = Convert.ToDecimal(priceTbx.Text);
                decimal discount = ((Convert.ToDecimal(DiscountTextBox.Text) / 100m));
                decimal discountedPrice = price - (price * discount);
                decimal newPrice = Convert.ToDecimal(discountedPrice) * Convert.ToInt32(quantTbx.Text);
                priceTbx.Text = newPrice.ToString();
            }
            else
            {
                priceTbx.Text = (Convert.ToInt32(quantTbx.Text) * Convert.ToDecimal(priceTbx.Text)).ToString();
            }


            FvwTransacItem.UpdateItem(true);
            GridView1.DataBind();

            ScriptManager.RegisterStartupScript(BtnConfirmStart, GetType(), "UpdateTransacModal",
                @"$('#UpdateTransacModal').modal('hide');", true);
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            HfdTransacID.Value = e.CommandArgument.ToString();
        }

        protected void ChkDiscount_CheckedChanged(object sender, EventArgs e)
        {
            if (ChkDiscount.Checked)
            {
                DiscountTextBox.Enabled = true;
            }
            else
            {
                DiscountTextBox.Enabled = false;
            }
        }
    }
}