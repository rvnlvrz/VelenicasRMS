<%@ Page Title="Dashboard Home" Language="C#" MasterPageFile="~/Dashboard/Dashboard.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="WebApplication.Dashboard.Index" %>
<%@ Register TagPrefix="rsweb" Namespace="Microsoft.Reporting.WebForms" Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
   
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" ProcessingMode="Remote" Width="100%" Height="700px" AsyncRendering="False">
        <ServerReport ReportServerUrl="http://localhost/reportserver" ReportPath="/Report/Inventory Report" />
    </rsweb:ReportViewer>

</asp:Content>
