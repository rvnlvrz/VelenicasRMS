<%@ Page Title="Create User Accounts" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreatingUserAccounts.aspx.cs" Inherits="WebApplication.Membership.CreatingUserAccounts" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card mx-auto" style="width: 36rem;">
        <div class="card-header">
            Create Acccount
        </div>
        <div class="card-body">
            <div class="form-group">
                <asp:Label ID="LabelEmail" runat="server" Text="Email"></asp:Label>
                <asp:TextBox ID="Email" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="LabelUsername" runat="server" Text="Username"></asp:Label>
                <asp:TextBox ID="Username" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="LabelPassword" runat="server" Text="Password"></asp:Label>
                <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="LabelSecurityQuestion" runat="server" Text=""></asp:Label>
                <asp:TextBox ID="SecurityAnswer" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <asp:Label ID="CreateAccountResults" runat="server"></asp:Label>
            <hr/>
            <div class="text-right">
                <asp:Button ID="ButtonCreateAccount" runat="server" Text="Create Account" CssClass="btn btn-success" OnClick="ButtonCreateAccount_Click"/>
            </div>
        </div>
    </div>
</asp:Content>
