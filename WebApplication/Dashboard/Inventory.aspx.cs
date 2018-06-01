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
            ModalTitle.InnerHtml = "Add Record";
            EditUpdatePanel.Update();
        }

        protected void EditFormView_OnItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            throw new NotImplementedException();
        }

        protected void EditFormView_OnItemInserting(object sender, FormViewInsertEventArgs e)
        {
            throw new NotImplementedException();
        }

        protected void ButtonModalUpdate_OnClick(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }
    }
}