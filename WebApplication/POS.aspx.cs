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
            BtnCancelTransac.DataBind();
            BtnPay.DataBind();
        }

        protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            Session["foodKey"] = e.CommandArgument.ToString();

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
                Session[value] = "selected";
                CheckBoxList1.Items.FindByValue(value).Enabled = false;
                CheckBoxList1.Items.FindByValue(value).Selected = false;
            }

            GridView1.DataBind();
            LvwTotals.DataBind();
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

            Session.Abandon();
            Session.RemoveAll();
            Session["transacID"] = transactionID;
            GridView1.DataBind();
            ListView1.DataBind();
            CheckBoxList1.DataBind();
            BtnCancelTransac.DataBind();
            BtnPay.DataBind();
            ScriptManager.RegisterStartupScript(BtnConfirmStart, GetType(), "NewTransacModal",
                @"$('#NewTransacModal').modal('hide');", true);

        }

        protected bool IsInTransaction()
        {
            if (Session["transacID"] == null)
            {
                return false;
            }
            else
            {
                return true;
            }
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
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand("DeleteTransaction", conn))
                {
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.Add("@tranID", SqlDbType.Int).Value = Convert.ToInt32(Session["transacID"]);
                    conn.Open();
                    comm.ExecuteNonQuery();
                }
            }

            //Session.Remove("transacID");
            Session.Abandon();
            Session.RemoveAll();
            LvwTotals.DataBind();
            GridView1.DataBind();
            ListView1.DataBind();
            CheckBoxList1.DataBind();
            BtnCancelTransac.DataBind();
            BtnPay.DataBind();
            ScriptManager.RegisterStartupScript(BtnCancelTransac, GetType(), "CancelTransacModal",
                @"$('#CancelTransacModal').modal('hide');", true);
        }

        protected void BtnUpdateTransac_ServerClick(object sender, EventArgs e)
        {
            TextBox quantTbx = (TextBox)FvwTransacItem.Row.FindControl("QuantityTextBox");
            TextBox priceTbx = (TextBox)FvwTransacItem.Row.FindControl("PriceTextBox");
            TextBox idTbx = (TextBox)FvwTransacItem.Row.FindControl("MenuItemIDTextbox");

            if (Session[$"price_{idTbx.Text}"] == null)
            {
                Session[$"price_{idTbx.Text}"] = priceTbx.Text;
            }

            decimal originalPrice = Convert.ToDecimal(Session[$"price_{idTbx.Text}"]);
            int quantity = Convert.ToInt32(quantTbx.Text);

            if (DiscountTextBox.Enabled)
            {
                decimal discount = (Convert.ToDecimal(DiscountTextBox.Text) / 100m);
                decimal discountAmount = originalPrice * discount;
                decimal discountedPrice = originalPrice = discountAmount;
                decimal computedPrice = discountedPrice * Convert.ToDecimal(quantTbx.Text);
                priceTbx.Text = computedPrice.ToString();
            }
            else if (ChkSenior.Checked)
            {
                int count = GetServingCount(Convert.ToInt32(HfdTransacID.Value));
                decimal discount = 0.20m;
                decimal perServingPrice = originalPrice / count;
                decimal seniorDiscount = perServingPrice * discount;
                decimal computedPrice = originalPrice - seniorDiscount;
                priceTbx.Text = computedPrice.ToString();
            }
            else
            {
                priceTbx.Text = (Convert.ToInt32(quantTbx.Text) * Convert.ToDecimal(originalPrice)).ToString();
            }

            if (IsValid)
            {

                FvwTransacItem.UpdateItem(true);

                GridView1.DataBind();
                LvwTotals.DataBind();

                ScriptManager.RegisterStartupScript(BtnConfirmStart, GetType(), "UpdateTransacModal",
                    @"$('#UpdateTransacModal').modal('hide');", true);
            }
        }

        protected int GetServingCount(int productID)
        {
            int count = -1;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand("SELECT PersonCount FROM Foods WHERE " +
                    "productID = @id", conn))
                {
                    comm.Parameters.Add("@id", SqlDbType.Int).Value = productID;
                    conn.Open();
                    using (SqlDataReader reader = comm.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            count = Convert.ToInt32(reader["PersonCount"]);
                        }
                    }
                }
            }

            return count;
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            HfdTransacID.Value = e.CommandArgument.ToString();
            ReqValDiscount.DataBind();
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

            ReqValDiscount.DataBind();

        }

        protected void Button2_ServerClick(object sender, EventArgs e)
        {
            SourceTransacItemEdit.Delete();
            LvwTotals.DataBind();
            GridView1.DataBind();
            Session[HfdTransacID.Value] = null;
            CheckBoxList1.Items.FindByValue(HfdTransacID.Value).Enabled = true;
            CheckBoxList1.DataBind();
            ScriptManager.RegisterStartupScript(Button2, GetType(), "DeleteProdModal",
                @"$('#DeleteProdModal').modal('hide');", true);
        }

        protected void BtnPay_Click(object sender, EventArgs e)
        {
            FvwTotal.DataBind();
            Label TotalLabel = (Label)FvwTotal.FindControl("TotalLabel");
            TbxPayable.Text = TotalLabel.Text;
        }

        protected void TbxTender_TextChanged(object sender, EventArgs e)
        {
            if (TbxTender.Text != string.Empty)
            {
                decimal tender = Convert.ToDecimal(TbxTender.Text);
                decimal payable = Convert.ToDecimal(TbxPayable.Text);
                decimal change = Math.Abs(payable - tender);
                TbxChange.Text = change.ToString();
            }
            else
            {
                TbxChange.Text = 0.ToString();
            }
        }

        protected void BtnEndTran_ServerClick(object sender, EventArgs e)
        {
            if (IsValid)
            {
                //using (SqlConnection conn = new SqlConnection(connString))
                //{
                //    using (SqlCommand comm = new SqlCommand("DeleteTransaction", conn))
                //    {
                //        comm.CommandType = CommandType.StoredProcedure;
                //        comm.Parameters.Add("@tranID", SqlDbType.Int).Value = Convert.ToInt32(Session["transacID"]);
                //        conn.Open();
                //        comm.ExecuteNonQuery();
                //    }
                //}

                Session.Remove("transacID");
                LvwTotals.DataBind();
                GridView1.DataBind();
                BtnCancelTransac.DataBind();
                BtnPay.DataBind();
                ScriptManager.RegisterStartupScript(BtnEndTran, GetType(), "EndTranModal",
                    @"$('#EndTranModal').modal('hide');", true);
            }
        }

        protected void BtnCancelCheckout_ServerClick(object sender, EventArgs e)
        {
            TbxTender.Text = "";
            TbxChange.Text = 0.ToString();
            ClientScript.RegisterStartupScript(GetType(), "disableTendrErr", @"$(#ReqValTender).hide();",
                true);
        }

        protected void CancelUpd_ServerClick(object sender, EventArgs e)
        {
        }

        protected void ChkSenior_CheckedChanged(object sender, EventArgs e)
        {
            if (ChkSenior.Checked)
            {
                TbxSeniorDiscount.Text = "20";
            }
            else
            {
                TbxSeniorDiscount.Text = string.Empty;
            }
        }

        protected void CheckBoxList1_DataBound(object sender, EventArgs e)
        {
            foreach (ListItem li in CheckBoxList1.Items)
            {
                if (Session[li.Value] != null)
                {
                    li.Enabled = false;
                }
            }
        }

        protected void BtnCancelTransac_Click(object sender, EventArgs e)
        {

        }
    }
}