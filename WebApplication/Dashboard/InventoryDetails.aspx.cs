using System;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace WebApplication.Dashboard
{
    public partial class InventoryDetails : System.Web.UI.Page
    {
        private string _recordId;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                _recordId = Request.QueryString[0];
                using (var connection = new SqlConnection(ConfigurationManager
                    .ConnectionStrings["VelenicasRMSConnectionString"].ConnectionString))
                {
                    var command = new SqlCommand($"SELECT * FROM [dbo].[Inventory] WHERE [ID] = {_recordId}", connection);
                    DataAdapter adapter = new SqlDataAdapter(command);

                    command.Connection.Open();
                    var dataSet = new DataSet();
                    adapter.Fill(dataSet);

                    DateTime dt = DateTime.Parse(dataSet.Tables[0].Rows[0][1].ToString());
                    Title = dt.ToString("f");
                }
            }
            catch (Exception exception)
            {
                Console.WriteLine(exception);
                throw;
            }
        }

        protected void FoodSearchButton_OnClick(object sender, EventArgs e)
        {
            FoodUpdatePanel.Update();
        }

        protected void BeverageSearchButton_OnClick(object sender, EventArgs e)
        {
            BeverageUpdatePanel.Update();
        }
    }
}