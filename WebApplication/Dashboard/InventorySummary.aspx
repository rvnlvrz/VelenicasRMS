<%@ Page Title="Inventory Summary" Language="C#" MasterPageFile="~/Dashboard/Dashboard.Master" AutoEventWireup="true" CodeBehind="InventorySummary.aspx.cs" Inherits="WebApplication.Dashboard.InventorySummary" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

     <%-- Inventory Details Table --%>
    <asp:UpdatePanel ID="PivotGridUpdatePanel" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="card mb-3">
                <div class="card-header">
                    <span class="fa fa-table"></span>&nbsp;Inventory Summary
                </div>
                <div class="card-body">

                    <%-- Top Panel --%>
                    <asp:Panel ID="OptionsPanel" runat="server" CssClass="mb-2">
                        <asp:UpdatePanel ID="OptionsUpdatePanel" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <div class="d-flex flex-row">
                                    <div class=" col-form-label">Display From:</div>
                                    <asp:DropDownList ID="FromDropDownList" runat="server" DataSourceID="RecordSqlDataSource" DataTextField="Value" DataValueField="ID" CssClass="form-control col-2 mx-2" OnSelectedIndexChanged="FromDropDownList_OnSelectedIndexChanged"></asp:DropDownList>
                                    <div class="col-form-label">To</div>
                                    <asp:DropDownList ID="ToDropDownList" runat="server" DataSourceID="RecordSqlDataSource" DataValueField="ID" DataTextField="Value" CssClass="form-control col-2 mx-2"></asp:DropDownList>
                                    <asp:Button ID="GoButton" runat="server" Text="Go" CssClass="btn btn-success" OnClick="GoButton_OnClick"/>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </asp:Panel>

                    <%-- Grid View --%>
                    <asp:GridView ID="PivotGridView" runat="server" DataKeyNames="ProductName" CssClass="table table-sm table-bordered table-striped"  AllowSorting="True" GridLines="None" AutoGenerateColumns="False" DataSourceID="PivotSqlDataSource">
                    </asp:GridView>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    
    <asp:SqlDataSource ID="PivotSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" SelectCommand="EXEC [dbo].[uspGetInventoryTable] @StartIndex, @EndIndex">
        <SelectParameters>
            <asp:ControlParameter ControlID="FromDropDownList" Name="StartIndex" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="ToDropDownList" Name="EndIndex" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
     </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="RecordSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" SelectCommand="SELECT [ID], CONCAT([ID],' - ', [Date]) as Value FROM [Inventory] ORDER BY ID DESC"></asp:SqlDataSource>
</asp:Content>
