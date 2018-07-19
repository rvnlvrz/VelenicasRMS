using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_login_OnClick(object sender, EventArgs e)
        {
            //// Validate the user against the Membership framework user store
            //if (System.Web.Security.Membership.ValidateUser(Username.Text, Password.Text))
            //{
            //    // Log the user into the site without cookies
            //    FormsAuthentication.RedirectFromLoginPage(Username.Text, false);
            //}
        }
    }
}