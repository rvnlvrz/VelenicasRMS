using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication.Dashboard
{
    public partial class Beverages : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void EditFormView_OnItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            // Hide update modal (calls main DOM)
            ScriptManager.RegisterStartupScript(GridUpdatePanel, GridUpdatePanel.GetType(), "hide",
                "$(function () { $('#" + EditPanel.ClientID + "').modal('hide'); });", true);
            ProductsGridView.DataBind();
            GridUpdatePanel.Update();
        }

        protected void EditFormView_OnItemInserting(object sender, FormViewInsertEventArgs e)
        {
            // Hide update modal (calls main DOM)
            ScriptManager.RegisterStartupScript(GridUpdatePanel, GridUpdatePanel.GetType(), "hide",
                "$(function () { $('#" + EditPanel.ClientID + "').modal('hide'); });", true);
            ProductsGridView.DataBind();
            GridUpdatePanel.Update();
        }

        protected void ButtonModalUpdate_OnClick(object sender, EventArgs e)
        {
            if (EditFormView.CurrentMode == FormViewMode.Edit)
                EditFormView.UpdateItem(true);
            else
                EditFormView.InsertItem(true);

            // Refereshes now ;)
            ProductsGridView.DataBind();
            GridUpdatePanel.Update();
        }

        protected void ProductsGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            Session["productID"] = e.CommandArgument;

            if (e.CommandName == "EditProduct")
            {
                ModalSqlDataSource.SelectParameters[0].DefaultValue = e.CommandArgument.ToString();
                ModalSqlDataSource.Select(DataSourceSelectArguments.Empty);
            }
        }

        protected void AddProductButton_OnClick(object sender, EventArgs e)
        {
            // Show edit modal
            ScriptManager.RegisterStartupScript(EditUpdatePanel, EditUpdatePanel.GetType(), "show",
                "$(function () { $('#" + EditPanel.ClientID + "').modal('show'); });", true);
            EditFormView.ChangeMode(FormViewMode.Insert);
            ButtonModalUpdate.Text = "Add";
            ModalTitle.InnerHtml = "Add Product";
            EditUpdatePanel.Update();
        }

        protected void EditButton_OnClick(object sender, EventArgs e)
        {
            // Show edit modal
            ScriptManager.RegisterStartupScript(EditUpdatePanel, EditUpdatePanel.GetType(), "show",
                "$(function () { $('#" + EditPanel.ClientID + "').modal('show'); });", true);
            EditFormView.ChangeMode(FormViewMode.Edit);
            ButtonModalUpdate.Text = "Update";
            ModalTitle.InnerHtml = "Edit Food";
            EditUpdatePanel.Update();
        }

        protected void DeleteButton_OnClick(object sender, EventArgs e)
        {
            // Show delete modal
            ScriptManager.RegisterStartupScript(DeleteUpdatePanel, DeleteUpdatePanel.GetType(), "show",
                "$(function () { $('#" + DeletePanel.ClientID + "').modal('show'); });", true);
            DeleteUpdatePanel.Update();
        }

        protected void ButtonModalDelete_Click(object sender, EventArgs e)
        {
            ModalSqlDataSource.DeleteParameters[0].DefaultValue = Session["productID"].ToString();
            ModalSqlDataSource.Delete();

            // Hide delete modal (calls main DOM)
            ScriptManager.RegisterStartupScript(GridUpdatePanel, GridUpdatePanel.GetType(), "hide",
                "$(function () { $('#" + DeletePanel.ClientID + "').modal('hide'); });", true);
            ProductsGridView.DataBind();
            GridUpdatePanel.Update();
        }

        protected void SearchButton_OnClick(object sender, EventArgs e)
        {
            BeveragesSqlDataSource.Select(DataSourceSelectArguments.Empty);
            GridUpdatePanel.Update();
        }
    }
}