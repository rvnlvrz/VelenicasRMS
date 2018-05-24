<%@ Page Title="Debug Page" Language="C#" MasterPageFile="~/Dashboard/Dashboard.Master" AutoEventWireup="true" CodeBehind="Debug.aspx.cs" Inherits="WebApplication.Dashboard.Debug" EnableViewState="True" %>

<%@ Register Src="~/UserControl/AddProductControl.ascx" TagPrefix="uc1" TagName="AddProductControl" %>
<%@ Register Src="~/UserControl/EditProductControl.ascx" TagPrefix="uc1" TagName="EditProductControl" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <uc1:AddProductControl runat="server" ID="AddProductControl"/>
    </div>
    <div>        
        <uc1:EditProductControl runat="server" ID="EditProductControl" />
    </div>
</asp:Content>
