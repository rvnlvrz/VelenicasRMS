<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DataTableControl.ascx.cs" Inherits="WebApplication.UserControl.DataTableControl" %>

<div class="card mb-3">
    <div class="card-header"><span class="fa fa-table"></span> Table Title</div>
    <div class="card-body">
        <asp:GridView ID="GridViewTable" runat="server" CssClass="table table-bordered"></asp:GridView>
    </div>
</div>