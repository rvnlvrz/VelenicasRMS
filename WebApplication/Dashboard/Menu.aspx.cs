using System;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogicLayer;

namespace WebApplication.Dashboard
{
    public partial class Menu : Page
    {
        private readonly ProductLogic _productLogic = new ProductLogic();
        private DataTable _leftCheckList;
        private DataTable _rightCheckList;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack && ViewState["hasLoaded"] == null)
            {
                // Everything inside this code block only gets executed at first load
                // or when the client requests a page refresh

                Initialize();
                Bind();
                
                ViewState["hasLoaded"] = true;
            }
        }

        private void Initialize()
        {
            InitializeLeftCheckList();
            InitializeRightCheckList();
        }

        private void InitializeLeftCheckList()
        {
            var index = int.Parse(LeftDropDownList.SelectedValue);
            _leftCheckList = index == -1 ? _productLogic.GetProductsByMenuId(null) : _productLogic.GetProductsByMenuId(index);
        }

        private void InitializeRightCheckList()
        {
            var index = int.Parse(RightDropDownList.SelectedValue);
            _rightCheckList = index == -1 ? _productLogic.GetProductsByMenuId(null) : _productLogic.GetProductsByMenuId(index);
        }

        private void Bind()
        {
            BindLeftCheckList();
            BindRightCheckList();
        }

        private void BindLeftCheckList()
        {
            LeftCheckBoxList.DataSource = _leftCheckList;
            LeftCheckBoxList.DataBind();

            var listItems = LeftCheckBoxList.Items
                .Cast<ListItem>()
                .OrderBy(item => item.Text)
                .ToArray();

            LeftCheckBoxList.Items.Clear();
            LeftCheckBoxList.Items.AddRange(listItems);
        }

        private void BindRightCheckList()
        {
            RightCheckBoxList.DataSource = _rightCheckList;
            RightCheckBoxList.DataBind();

            var listItems = RightCheckBoxList.Items
                .Cast<ListItem>()
                .OrderBy(item => item.Text)
                .ToArray();

            RightCheckBoxList.Items.Clear();
            RightCheckBoxList.Items.AddRange(listItems);
        }

        protected void SearchButton_OnClicktton_OnClick(object sender, EventArgs e)
        {
            //GridUpdatePanel.Update();
        }

        protected void AddMenuButton_OnClick(object sender, EventArgs e)
        {
            // Show edit modal
            ScriptManager.RegisterStartupScript(EditUpdatePanel, EditUpdatePanel.GetType(), "show",
                "$(function () { $('#" + EditPanel.ClientID + "').modal('show'); });", true);
            EditFormView.ChangeMode(FormViewMode.Insert);
            ButtonModalUpdate.Text = "Add";
            ModalTitle.InnerHtml = "Add Product Menu";
            //EditUpdatePanel.Update();
        }

        protected void EditButton_OnClick(object sender, EventArgs e)
        {
            // Show edit modal
            ScriptManager.RegisterStartupScript(EditUpdatePanel, EditUpdatePanel.GetType(), "show",
                "$(function () { $('#" + EditPanel.ClientID + "').modal('show'); });", true);
            EditFormView.ChangeMode(FormViewMode.Edit);
            ButtonModalUpdate.Text = "Update";
            ModalTitle.InnerHtml = "Edit Product Menu";
            //EditUpdatePanel.Update();
        }

        protected void DeleteButton_OnClick(object sender, EventArgs e)
        {
            // Show delete modal
            ScriptManager.RegisterStartupScript(DeleteUpdatePanel, DeleteUpdatePanel.GetType(), "show",
                "$(function () { $('#" + DeletePanel.ClientID + "').modal('show'); });", true);
            //DeleteUpdatePanel.Update();
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
            //GridUpdatePanel.Update();
        }

        protected void ButtonModalDelete_Click(object sender, EventArgs e)
        {
            MenuObjectDataSource.DeleteParameters[0].DefaultValue = Session["MenuID"].ToString();
            MenuObjectDataSource.Delete();

            // Hide delete modal (calls main DOM)
            ScriptManager.RegisterStartupScript(GridUpdatePanel, GridUpdatePanel.GetType(), "hide",
                "$(function () { $('#" + DeletePanel.ClientID + "').modal('hide'); });", true);
            MenuGridView.DataBind();
            //GridUpdatePanel.Update();
        }

        protected void LeftDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            var value = LeftDropDownList.SelectedValue;
            if (value == RightDropDownList.SelectedValue)
            {
                var count = RightDropDownList.Items.Count;
                if (count <= 1) return;

                var rIndex = RightDropDownList.SelectedIndex;
                if (rIndex == 0) RightDropDownList.SelectedIndex = 1;
                else if (rIndex == count - 1) RightDropDownList.SelectedIndex = count - 2;
                else RightDropDownList.SelectedIndex += 1;
            }

            Initialize();
            Bind();
        }

        protected void RightDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            var value = RightDropDownList.SelectedValue;
            if (value == LeftDropDownList.SelectedValue)
            {
                var count = LeftDropDownList.Items.Count;
                if (count <= 1) return;

                var lIndex = LeftDropDownList.SelectedIndex;
                if (lIndex == 0) LeftDropDownList.SelectedIndex = 1;
                else if (lIndex == count - 1) LeftDropDownList.SelectedIndex = count - 2;
                else LeftDropDownList.SelectedIndex += 1;
            }

            Initialize();
            Bind();
        }

        protected void MoveRight_OnClick(object sender, EventArgs e)
        {
            // Show edit modal
            ScriptManager.RegisterStartupScript(ConfirmationUpdatePanel, ConfirmationUpdatePanel.GetType(), "show",
                "$(function () { $('#" + ConfirmationPanel.ClientID + "').modal('show'); });", true);
            return;

            // Get values for all selected items
            var selectedItems = LeftCheckBoxList.Items.Cast<ListItem>()
                .Where(item => item.Selected)
                .Select(item => item.Value)
                .ToList();

            foreach (var item in selectedItems)
            {
                _productLogic.UpdateMenuId(int.Parse(RightDropDownList.SelectedValue), int.Parse(item));
            }

            Initialize();
            Bind();
        }

        protected void MoveLeft_OnClick(object sender, EventArgs e)
        {
            // Get values for all selected items
            var selectedItems = RightCheckBoxList.Items.Cast<ListItem>()
                .Where(item => item.Selected)
                .Select(item => item.Value)
                .ToList();

            foreach (var item in selectedItems)
            {
                _productLogic.UpdateMenuId(int.Parse(LeftDropDownList.SelectedValue), int.Parse(item));
            }

            Initialize();
            Bind();
        }
    }
}