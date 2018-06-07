using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication.Dashboard
{
    public partial class InventorySummary : System.Web.UI.Page
    {
        private readonly DataSet _pivotDataSet = new DataSet();
        private SqlDataAdapter _pivotDataAdapter;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) PopulateTable(0, 15);
        }

        private void ClearTable()
        {
            PivotGridView.DataSource = null;
            PivotGridView.DataBind();
            PivotGridUpdatePanel.Update();
        }

        protected void GoButton_OnClick(object sender, EventArgs e)
        {
            var start = Convert.ToInt32(FromDropDownList.SelectedValue);
            var end = Convert.ToInt32(ToDropDownList.SelectedValue);

            PopulateTable(start, end);
        }

        protected void FromDropDownList_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            ClearTable();
        }

        private void PopulateTable(int start, int end)
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
                        new SqlParameter("@StartIndex", SqlDbType.Int),
                        new SqlParameter("@EndIndex", SqlDbType.Int)
                    }
                };
                selectCommand.Parameters[0].Value = start;
                selectCommand.Parameters[1].Value = end;

                _pivotDataSet.Clear();
                _pivotDataAdapter = new SqlDataAdapter(selectCommand);

                connection.Open();
                _pivotDataAdapter.Fill(_pivotDataSet);

                if (_pivotDataSet.Tables.Count == 0) return;

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
                PivotGridUpdatePanel.Update();
            }
        }
    }
}