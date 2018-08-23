﻿using System;
using System.Web.Security;
using System.Web.UI;

namespace WebApplication.Membership
{
    public partial class CreatingUserAccounts : Page
    {
        private const string PasswordQuestion = "In what city were you born?";

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!Page.IsPostBack)
            //    LabelSecurityQuestion.Text = PasswordQuestion;

            if (Request.IsAuthenticated && !string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
                // This is an unauthorized, authenticated request...
                Response.Redirect("~/Unauthorized.aspx");
        }

        protected void CreateUserWizard_CreatingUser(object sender, System.Web.UI.WebControls.LoginCancelEventArgs e)
        {
            //string trimmedUserName = CreateUserWizard.UserName.Trim();

            //LiteralControl errorControl = CreateUserWizardStep1.FindControl("ErrorMessage") as LiteralControl;

            //if (errorControl == null)
            //{
            //    e.Cancel = true;
            //   return;
            //};    

            //if (CreateUserWizard.UserName.Length != trimmedUserName.Length)
            //{
            //    // Show the error message
            //    errorControl.Text = "The username cannot contain leading or trailing spaces.";
            //    errorControl.Visible = true;

            //    // Cancel the create user workflow
            //    e.Cancel = true;
            //}
            //else
            //{
            //    // Username is valid, make sure that the password does not contain the username

            //    if (CreateUserWizard.Password.IndexOf(CreateUserWizard.UserName, StringComparison.OrdinalIgnoreCase) >= 0)
            //    {
            //        // Show the error message
            //        errorControl.Text = "The username may not appear anywhere in the password.";
            //        errorControl.Visible = true;
            //        // Cancel the create user workflow
            //        e.Cancel = true;
            //    }
            //}
        }

        //protected void ButtonCreateAccount_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        var user = System.Web.Security.Membership.CreateUser(Username.Text, Password.Text, Email.Text,
        //            PasswordQuestion, SecurityAnswer.Text, true, out var createStatus);

        //        switch (createStatus)
        //        {
        //            case MembershipCreateStatus.Success:
        //                CreateAccountResults.Text = "The user account was successfully created!";
        //                CreateAccountResults.CssClass = "text-success";
        //                break;
        //            case MembershipCreateStatus.DuplicateUserName:
        //                CreateAccountResults.Text = "There already exists a user with this username.";
        //                CreateAccountResults.CssClass = "text-danger";
        //                break;

        //            case MembershipCreateStatus.DuplicateEmail:
        //                CreateAccountResults.Text = "There already exists a user with this email address.";
        //                CreateAccountResults.CssClass = "text-danger";
        //                break;
        //            case MembershipCreateStatus.InvalidEmail:
        //                CreateAccountResults.Text = "The email address you provided is invalid.";
        //                CreateAccountResults.CssClass = "text-danger";
        //                break;
        //            case MembershipCreateStatus.InvalidAnswer:
        //                CreateAccountResults.Text = "The security answer was invalid.";
        //                CreateAccountResults.CssClass = "text-danger";
        //                break;
        //            case MembershipCreateStatus.InvalidPassword:
        //                CreateAccountResults.Text =
        //                    "The password you provided is invalid. It must be seven characters long and have at least one non-alphanumeric character.";
        //                CreateAccountResults.CssClass = "text-danger";
        //                break;
        //            default:
        //                CreateAccountResults.Text = "An unknown error occured. The user account was not created.";
        //                CreateAccountResults.CssClass = "text-danger";
        //                break;
        //        }
        //    }
        //    catch (Exception exception)
        //    {
        //        Console.WriteLine(exception);
        //        throw;
        //    }
        //}
    }
}