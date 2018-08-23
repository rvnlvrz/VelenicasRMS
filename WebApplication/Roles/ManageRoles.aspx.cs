using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Web.Security.Roles;

namespace WebApplication.Roles
{
    public partial class ManageRoles : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BindRoles();
            }
        }

        protected void CreateRoleButton_Click(object sender, EventArgs e)
        {
            string roleName = RoleName.Text;
            if (RoleExists(roleName)) return;

            CreateRole(roleName);
            BindRoles();
            RoleName.Text = null;
        }

        private void BindRoles()
        {
            RoleView.DataSource = GetAllRoles();
            RoleView.DataBind();
        }
    }
}