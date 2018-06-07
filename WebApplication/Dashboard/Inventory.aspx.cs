using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication.Dashboard
{
    public partial class Inventory : Page
    {
        private TextBox _dateControl;

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
            _dateControl = (TextBox) EditFormView.FindControl("DateTextBox");
            _dateControl.Text = DateTime.Now.ToString("s");
            EditUpdatePanel.Update();
        }

        protected void EditButton_OnClick(object sender, EventArgs e)
        {
            // Show edit modal
            ScriptManager.RegisterStartupScript(EditUpdatePanel, EditUpdatePanel.GetType(), "show",
                "$(function () { $('#" + EditPanel.ClientID + "').modal('show'); });", true);
            EditFormView.ChangeMode(FormViewMode.Edit);
            ButtonModalUpdate.Text = "Update";
            ModalTitle.InnerHtml = "Edit Inventory Record";
            EditUpdatePanel.Update();
        }

        protected void DeleteButton_OnClick(object sender, EventArgs e)
        {
            // Show delete modal
            ScriptManager.RegisterStartupScript(DeleteUpdatePanel, DeleteUpdatePanel.GetType(), "show",
                "$(function () { $('#" + DeletePanel.ClientID + "').modal('show'); });", true);
            DeleteUpdatePanel.Update();
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

        protected void ButtonModalDelete_Click(object sender, EventArgs e)
        {
            ModalSqlDataSource.DeleteParameters[0].DefaultValue = Session["recordID"].ToString();
            ModalSqlDataSource.Delete();

            // Hide delete modal (calls main DOM)
            ScriptManager.RegisterStartupScript(GridUpdatePanel, GridUpdatePanel.GetType(), "hide",
                "$(function () { $('#" + DeletePanel.ClientID + "').modal('hide'); });", true);
            InventoryGridView.DataBind();
            GridUpdatePanel.Update();
        }

        protected void InventoryGridView_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            Session["recordID"] = e.CommandArgument;

            if (e.CommandName == "EditRecord")
            {
                ModalSqlDataSource.SelectParameters[0].DefaultValue = e.CommandArgument.ToString();
                ModalSqlDataSource.Select(DataSourceSelectArguments.Empty);
            }
            else if (e.CommandName == "ViewRecord")
            {
                Response.Redirect($"InventoryDetails.aspx?InventoryID={Session["recordID"]}");
            }
        }
    }
}