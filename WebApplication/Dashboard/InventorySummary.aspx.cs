using System;
using System.IO;
using System.Web.UI;

namespace WebApplication.Dashboard
{
    public partial class InventorySummary : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void GoButton_OnClick(object sender, EventArgs e)
        {
            PivotGridView.DataBind();
        }

        protected void ExportButton_OnClick(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=Inventory Summary.xls");
            Response.Charset = "";
            Response.ContentType = "application/excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                PivotGridView.AllowPaging = false;
           
                PivotGridView.DataBind();
                PivotGridView.RenderControl(hw);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }
    }
}