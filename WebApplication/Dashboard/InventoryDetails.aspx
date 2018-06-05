<%@ Page Language="C#" MasterPageFile="~/Dashboard/Dashboard.Master" AutoEventWireup="true" CodeBehind="InventoryDetails.aspx.cs" Inherits="WebApplication.Dashboard.InventoryDetails" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Inventory Table --%>
    <asp:UpdatePanel ID="FoodUpdatePanel" runat="server">
        <ContentTemplate>
            <div class="card mb-3" style="width: 36rem;">
                <div class="card-header">
                    <span class="fa fa-table"></span>&nbsp;Food Product Inventory
                </div>
                <div class="card-body">
                    <asp:GridView ID="FoodGridView" runat="server" DataSourceID="FoodSqlDataSource" AutoGenerateColumns="False" DataKeyNames="ID" CssClass="table table-sm table-bordered table-striped" AllowSorting="True" AllowPaging="True">
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" Visible="False" />
                            <asp:BoundField DataField="InventoryID" HeaderText="InventoryID" SortExpression="InventoryID" ReadOnly="True" Visible="False" />
                            <asp:BoundField DataField="ProductID" HeaderText="ProductID" SortExpression="ProductID" ReadOnly="True" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" ReadOnly="True" />
                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                            <asp:TemplateField ShowHeader="False">
                                <EditItemTemplate>
                                    <asp:LinkButton ID="UpdateLinkButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                    &nbsp;<asp:LinkButton ID="CancelLinkButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="EditLinkButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <%-- Inventory Table --%>
    <asp:UpdatePanel ID="BeverageUpdatePanel" runat="server">
        <ContentTemplate>
            <div class="card mb-3" style="width: 36rem;">
                <div class="card-header">
                    <span class="fa fa-table"></span>&nbsp;Beverage Product Inventory
                </div>
                <div class="card-body">
                    <asp:GridView ID="BeverageGridView" runat="server" DataSourceID="BeverageSqlDataSource" AutoGenerateColumns="False" DataKeyNames="ID" CssClass="table table-sm table-bordered table-striped" AllowSorting="True">
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" Visible="False" />
                            <asp:BoundField DataField="InventoryID" HeaderText="InventoryID" SortExpression="InventoryID" ReadOnly="True" Visible="False" />
                            <asp:BoundField DataField="ProductID" HeaderText="ProductID" SortExpression="ProductID" ReadOnly="True" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" ReadOnly="True" />
                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                            <asp:TemplateField ShowHeader="False">
                                <EditItemTemplate>
                                    <asp:LinkButton ID="UpdateLinkButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                    &nbsp;<asp:LinkButton ID="CancelLinkButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="EditLinkButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <%-- Data Source --%>
    <asp:SqlDataSource ID="FoodSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" SelectCommand="SELECT i.ID, i.InventoryID, i.ProductID, p.Name, i.Quantity 
FROM InventoryItems i
	INNER JOIN [Food Products] p ON i.ProductID = p.ID 
WHERE (i.InventoryID = @InventoryID)"
        UpdateCommand="uspUpdateInventoryItem" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="InventoryID" QueryStringField="InventoryID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="Quantity" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="BeverageSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" SelectCommand="SELECT i.ID, i.InventoryID, i.ProductID, p.Name, i.Quantity 
FROM InventoryItems i
	INNER JOIN [Beverage Products] p ON i.ProductID = p.ID 
WHERE (i.InventoryID = @InventoryID)"
        UpdateCommand="uspUpdateInventoryItem" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="InventoryID" QueryStringField="InventoryID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="Quantity" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
