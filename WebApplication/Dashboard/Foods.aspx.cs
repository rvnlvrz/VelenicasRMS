using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogicLayer;

namespace WebApplication.Dashboard
{
    public partial class Foods : Page
    {
        private readonly FoodLogic _foodLogic = new FoodLogic();
        private DataTable _table = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack && ViewState["hasLoaded"] == null)
            {
                ViewState["sortExpression"] = "ID ASC";
                ViewState["hasLoaded"] = true;

                Initialize();
                Bind();
            }
        }

        private void Initialize()
        {
            // Data Initialization
            _table = _foodLogic.GetFoodProducts();

            // Data Filtration (I'll keep this here for the meantime, I might need to change it)
            var view = new DataView(_table) {RowFilter = $"Name LIKE '%{SearchTextBox.Text}%'"};
            _table = view.ToTable();

            // Sort
            _table.DefaultView.Sort = ViewState["sortExpression"].ToString();
        }

        private void Bind()
        {
            ProductsGridView.DataSource = _table;
            ProductsGridView.DataBind();
            GridUpdatePanel.Update();
        }

        protected void SearchButton_OnClick(object sender, EventArgs e)
        {
            Initialize();
            Bind();
        }

        protected void ButtonModalUpdate_OnClick(object sender, EventArgs e)
        {
            if (EditFormView.CurrentMode == FormViewMode.Edit)
                EditFormView.UpdateItem(true);
            else
                EditFormView.InsertItem(true);

            // Refereshes now ;)
            Initialize();
            Bind();
        }

        protected void ProductsGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            ViewState["productID"] = e.CommandArgument;

            if (e.CommandName != "EditProduct") return;
            FoodObjectDataSource.SelectParameters[0].DefaultValue = e.CommandArgument.ToString();
            FoodObjectDataSource.Select();
        }

        protected void ButtonModalDelete_Click(object sender, EventArgs e)
        {
            // Delete product 
            if (!_foodLogic.DeleteFoodProduct(int.Parse(ViewState["productID"].ToString())))
                return;

            // Refresh local data
            Initialize();

            // Hide delete modal (calls main DOM)
            ScriptManager.RegisterStartupScript(GridUpdatePanel, GridUpdatePanel.GetType(), "hide",
                "$(function () { $('#" + DeletePanel.ClientID + "').modal('hide'); });", true);

            // Bind changes to UI
            Bind();
        }

        protected void ProductsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            Initialize();
            ProductsGridView.PageIndex = e.NewPageIndex;
            Bind();
        }

        protected void ProductsGridView_Sorting(object sender, GridViewSortEventArgs e)
        {
            Initialize();

            var sortData = ViewState["sortExpression"].ToString().Trim().Split(' ');
            if (e.SortExpression == sortData[0])
            {
                if (sortData[1] == "ASC")
                {
                    _table.DefaultView.Sort = e.SortExpression + " " + "DESC";
                    ViewState["sortExpression"] = e.SortExpression + " " + "DESC";
                }
                else
                {
                    _table.DefaultView.Sort = e.SortExpression + " " + "ASC";
                    ViewState["sortExpression"] = e.SortExpression + " " + "ASC";
                }
            }
            else
            {
                _table.DefaultView.Sort = e.SortExpression + " " + "ASC";
                ViewState["sortExpression"] = e.SortExpression + " " + "ASC";
            }

            Bind();
        }

        #region Modals

        protected void AddButton_OnClick(object sender, EventArgs e)
        {
            // Show edit modal
            ScriptManager.RegisterStartupScript(EditUpdatePanel, EditUpdatePanel.GetType(), "show",
                "$(function () { $('#" + EditPanel.ClientID + "').modal('show'); });", true);
            EditFormView.ChangeMode(FormViewMode.Insert);
            ButtonModalUpdate.Text = "Add";
            ModalTitle.InnerHtml = "Add Food";
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

        protected void EditFormView_OnItemInserting(object sender, FormViewInsertEventArgs e)
        {
            // Hide update modal (calls main DOM)
            ScriptManager.RegisterStartupScript(GridUpdatePanel, GridUpdatePanel.GetType(), "hide",
                "$(function () { $('#" + EditPanel.ClientID + "').modal('hide'); });", true);
            ProductsGridView.DataBind();
            GridUpdatePanel.Update();
        }

        protected void EditFormView_OnItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            // Hide update modal (calls main DOM)
            ScriptManager.RegisterStartupScript(GridUpdatePanel, GridUpdatePanel.GetType(), "hide",
                "$(function () { $('#" + EditPanel.ClientID + "').modal('hide'); });", true);
            ProductsGridView.DataBind();
            GridUpdatePanel.Update();
        }

        #endregion
    }
}