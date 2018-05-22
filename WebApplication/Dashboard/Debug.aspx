<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard/Dashboard.Master" AutoEventWireup="true" CodeBehind="Debug.aspx.cs" Inherits="WebApplication.Dashboard.Debug" %>

<%@ Register Src="~/UserControl/AddItemControl.ascx" TagPrefix="uc1" TagName="AddItemControl" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <uc1:AddItemControl runat="server" id="AddItemControl" />
</asp:Content>
