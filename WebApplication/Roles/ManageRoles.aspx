<%@ Page Title="Manage Roles" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageRoles.aspx.cs" Inherits="WebApplication.Roles.ManageRoles" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Button ID="CreateRoleButton" runat="server" Text="Create Role" OnClick="CreateRoleButton_Click" />
    <asp:TextBox ID="RoleName" runat="server"></asp:TextBox>
    <asp:GridView ID="RoleView" runat="server" AutoGenerateColumns="False">
        <Columns>
            <asp:TemplateField HeaderText="Role">    
                <ItemTemplate>    
                    <asp:Label runat="server" ID="RoleNameLabel" Text='<%# Container.DataItem %>' />    
                </ItemTemplate>    
            </asp:TemplateField>    
        </Columns>
    </asp:GridView>
</asp:Content>
