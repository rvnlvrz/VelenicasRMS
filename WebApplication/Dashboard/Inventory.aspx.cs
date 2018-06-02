using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication.Dashboard
{
    public partial class Inventory : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void CreateRecordButton_OnClick(object sender, EventArgs e)
        {
            // Show edit modal
            ScriptManager.RegisterStartupScript(EditUpdatePanel, EditUpdatePanel.GetType(), "show",
                "$(function () { $('#" + EditPanel.ClientID + "').modal('show'); });", true);
            EditFormView.ChangeMode(FormViewMode.Insert);
            ButtonModalUpdate.Text = "Add";
            ModalTitle.InnerHtml = "Add Inventory Record";
            var dateControl = (TextBox) EditFormView.FindControl("DateTextBox");
            dateControl.Text = DateTime.Now.ToString("s");
            EditUpdatePanel.Update();
        }

        protected void ButtonModalUpdate_OnClick(object sender, EventArgs e)
        {
            if (EditFormView.CurrentMode == FormViewMode.Edit)
                EditFormView.UpdateItem(true);
            else
                EditFormView.InsertItem(true);

            // Hide update modal (calls main DOM)
            ScriptManager.RegisterStartupScript(GridUpdatePanel, GridUpdatePanel.GetType(), "hide",
                "$(function () { $('#" + EditPanel.ClientID + "').modal('hide'); });", true);
            InventoryGridView.DataBind();
            GridUpdatePanel.Update();
        }

        protected void InventoryGridView_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            throw new NotImplementedException();
        }

        protected void DeleteButton_OnClick(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }
    }
}