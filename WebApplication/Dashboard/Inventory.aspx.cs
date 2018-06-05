using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication.Dashboard
{
    public partial class Inventory : Page
    {
        private SqlDataAdapter _pivotDataAdapter;
        private DataSet _pivotDataSet;
        private TextBox _dateControl;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateTable();
            }
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
            PivotGridView.DataBind();
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
            PivotGridView.DataBind();
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

        protected void PopulateTable()
        {
            using (var connection = new SqlConnection(ConfigurationManager
                    .ConnectionStrings["VelenicasRMSConnectionString"].ConnectionString))
                {
                    var selectCommand = new SqlCommand
                    {
                        CommandText = "uspGetInventoryTable",
                        CommandType = CommandType.StoredProcedure,
                        Connection = connection,
                        Parameters =
                        {
                            new SqlParameter("@StartDate", SqlDbType.DateTime),
                            new SqlParameter("@EndDate", SqlDbType.DateTime)
                        }
                    };
                    selectCommand.Parameters[0].Value = DateTime.Now.ToString(CultureInfo.CurrentCulture);
                    selectCommand.Parameters[1].Value = DateTime.Now.AddDays(6).ToString(CultureInfo.CurrentCulture);
                    

                    _pivotDataSet = new DataSet("Pivot");
                    _pivotDataAdapter = new SqlDataAdapter(selectCommand);

                    connection.Open();
                    _pivotDataAdapter.Fill(_pivotDataSet);

                    if (_pivotDataSet.Tables.Count == 0)
                    {
                        return;
                    }

                    for (var i = 0; i < _pivotDataSet.Tables[0].Columns.Count; i++)
                    {
                        var col = _pivotDataSet.Tables[0].Columns[i];
                        var field = new BoundField();
                        if (i == 0)
                        {
                            field.HeaderText = "Product Name";
                        }
                        else
                        {
                            var dt = DateTime.Parse(col.ColumnName);
                            field.HeaderText = $"{dt:MMMM dd, yyyy \n hh:mm tt}";
                        }

                        field.DataField = col.ColumnName;
                        PivotGridView.Columns.Add(field);
                    }

                    PivotGridView.DataSource = _pivotDataSet;
                    PivotGridView.DataBind();
                }
        }
    }
}