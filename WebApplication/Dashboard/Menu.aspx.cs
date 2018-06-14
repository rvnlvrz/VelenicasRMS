using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication.Dashboard
{
    public partial class Menu : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void SearchButton_OnClicktton_OnClick(object sender, EventArgs e)
        {
            GridUpdatePanel.Update();
        }

        protected void AddMenuButton_OnClick(object sender, EventArgs e)
        {
            // Show edit modal
            ScriptManager.RegisterStartupScript(EditUpdatePanel, EditUpdatePanel.GetType(), "show",
                "$(function () { $('#" + EditPanel.ClientID + "').modal('show'); });", true);
            EditFormView.ChangeMode(FormViewMode.Insert);
            ButtonModalUpdate.Text = "Add";
            ModalTitle.InnerHtml = "Add Product Menu";
            EditUpdatePanel.Update();
        }

        protected void EditButton_OnClick(object sender, EventArgs e)
        {
            // Show edit modal
            ScriptManager.RegisterStartupScript(EditUpdatePanel, EditUpdatePanel.GetType(), "show",
                "$(function () { $('#" + EditPanel.ClientID + "').modal('show'); });", true);
            EditFormView.ChangeMode(FormViewMode.Edit);
            ButtonModalUpdate.Text = "Update";
            ModalTitle.InnerHtml = "Edit Product Menu";
            EditUpdatePanel.Update();
        }

        protected void DeleteButton_OnClick(object sender, EventArgs e)
        {
            // Show delete modal
            ScriptManager.RegisterStartupScript(DeleteUpdatePanel, DeleteUpdatePanel.GetType(), "show",
                "$(function () { $('#" + DeletePanel.ClientID + "').modal('show'); });", true);
            DeleteUpdatePanel.Update();

        }

        protected void MenuGridView_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            Session["MenuID"] = e.CommandArgument;

            if (e.CommandName == "EditMenu")
            {
                ModalSqlDataSource.SelectParameters[0].DefaultValue = e.CommandArgument.ToString();
                ModalSqlDataSource.Select(DataSourceSelectArguments.Empty);
            }
            else if (e.CommandName == "ViewMenu")
            {
                Response.Redirect($"MenuDetails.aspx?InventoryID={Session["MenuID"]}");
            }
        }

        protected void ButtonModalUpdate_OnClick(object sender, EventArgs e)
        {
            if (EditFormView.CurrentMode == FormViewMode.Edit)
                EditFormView.UpdateItem(true);
            else
                EditFormView.InsertItem(true);

            // Refereshes now ;)
            ScriptManager.RegisterStartupScript(GridUpdatePanel, GridUpdatePanel.GetType(), "hide",
                "$(function () { $('#" + EditPanel.ClientID + "').modal('hide'); });", true);
            MenuGridView.DataBind();
            GridUpdatePanel.Update();
        }

        protected void ButtonModalDelete_Click(object sender, EventArgs e)
        {
            ModalSqlDataSource.DeleteParameters[0].DefaultValue = Session["MenuID"].ToString();
            ModalSqlDataSource.Delete();

            // Hide delete modal (calls main DOM)
            ScriptManager.RegisterStartupScript(GridUpdatePanel, GridUpdatePanel.GetType(), "hide",
                "$(function () { $('#" + DeletePanel.ClientID + "').modal('hide'); });", true);
            MenuGridView.DataBind();
            GridUpdatePanel.Update();
        }
    }
}