<%@ Page Title="Inventory" Language="C#" MasterPageFile="~/Dashboard/Dashboard.Master" AutoEventWireup="true" CodeBehind="Inventory.aspx.cs" Inherits="WebApplication.Dashboard.Inventory" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="DateDataSource" DataTextField="Date" DataValueField="ID">
                <asp:ListItem Text="Today's Date" Value="-1"></asp:ListItem>
            </asp:DropDownList>
            <asp:Button ID="GoButton" runat="server" Text="Go" CssClass="btn btn-primary"/>
            <asp:ListView ID="ListView1" runat="server"></asp:ListView>
        </ContentTemplate>
    </asp:UpdatePanel>
    
    <%-- Data Source --%>
    <asp:SqlDataSource ID="DateDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" SelectCommand="SELECT * FROM [Inventory]"></asp:SqlDataSource>
</asp:Content>
