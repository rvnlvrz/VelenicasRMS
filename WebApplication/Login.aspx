<%@ Page Title="Sign In" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="backdrop">
        <div class="backdrop-tint d-flex align-items-center">
            <div class="mx-auto" style="margin-top: -10rem;">
                <div class="row">
                    <div class="title-border" style="width: 24rem;">
                        <h4 class="my-1">Velenica's Kitchen</h4>
                    </div>
                </div>
                <%-- Login Card --%>
                <div class="row">
                    <div class="card" style="border-color: rebeccapurple; width: 24rem;">
                        <div class="card-body">
                            <asp:Login ID="Login" runat="server" LoginButtonText="Sign In" TitleText="" RenderOuterTable="False">
                                <LayoutTemplate>
                                    <div class="form-group">
                                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
                                        <asp:TextBox ID="UserName" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ValidationGroup="Login" Display="Dynamic" CssClass="text-danger">User Name is required.</asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                                        <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ValidationGroup="Login" Display="Dynamic" CssClass="text-danger">Password is required.</asp:RequiredFieldValidator>
                                    </div>
                                    <asp:CheckBox ID="RememberMe" runat="server" CssClass="" Text="&nbsp;Remember Me" />
                                    <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                    <div class="text-right">
                                        <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Sign In" ValidationGroup="Login" CssClass="btn btn-success" />
                                    </div>
                                </LayoutTemplate>
                            </asp:Login>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
