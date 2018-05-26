<%@ Page Title="Debug" Language="C#" MasterPageFile="~/Dashboard/Dashboard.Master" AutoEventWireup="true" CodeBehind="Debug.aspx.cs" Inherits="WebApplication.Dashboard.Debug" %>

<%@ Register Src="~/UserControl/AddProductControl.ascx" TagPrefix="uc1" TagName="AddProductControl" %>
<%@ Register Src="~/UserControl/DataTableControl.ascx" TagPrefix="uc1" TagName="DataTableControl" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <uc1:AddProductControl runat="server" ID="AddProductControl" />
    <br />
    <uc1:DataTableControl runat="server" id="DataTableControl" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
</asp:Content>
