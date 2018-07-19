<%@ Page Language="C#" MasterPageFile="~/Dashboard/Dashboard.Master" AutoEventWireup="true" CodeBehind="InventoryDetails.aspx.cs" Inherits="WebApplication.Dashboard.InventoryDetails" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Inventory Table --%>
    <asp:UpdatePanel ID="FoodUpdatePanel" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="card mb-3 mx-auto" style="width: 36rem;">
                <div class="card-header">
                    <span class="fa fa-table"></span>&nbsp;Food Product Inventory
                </div>
                <div class="card-body">

                    <%-- Search --%>
                    <asp:Panel ID="FoodSearchPanel" runat="server" CssClass="row" DefaultButton="FoodSearchButton">
                        <div class="form-group col-sm-6">
                            <div class="input-group">
                                <asp:TextBox ID="FoodSearchTextBox" runat="server" placeholder="Product Name" CssClass="form-control"></asp:TextBox>
                                <div class="input-group-append">
                                    <asp:Button ID="FoodSearchButton" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="FoodSearchButton_OnClick" />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>

                    <%-- Table --%>
                    <asp:GridView ID="FoodGridView" runat="server" DataSourceID="FoodSqlDataSource" AutoGenerateColumns="False" DataKeyNames="ID" CssClass="table table-sm table-bordered table-striped" AllowSorting="True" AllowPaging="True">
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" Visible="False" />
                            <asp:BoundField DataField="InventoryID" HeaderText="InventoryID" SortExpression="InventoryID" ReadOnly="True" Visible="False" />
                            <asp:BoundField DataField="ProductID" HeaderText="ID" SortExpression="ProductID" ReadOnly="True" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" ReadOnly="True" />
                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                            <asp:TemplateField ShowHeader="False">
                                <EditItemTemplate>
                                    <div class="d-flex flex-row justify-content-center">
                                        <asp:LinkButton ID="UpdateLinkButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-sm btn-success"></asp:LinkButton>
                                        &nbsp;<asp:LinkButton ID="CancelLinkButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-sm btn-secondary"></asp:LinkButton>
                                    </div>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <div class="d-flex flex-row justify-content-center">
                                        <asp:LinkButton ID="EditLinkButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" CssClass="btn btn-sm btn-primary"></asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <%-- Inventory Table --%>
    <asp:UpdatePanel ID="BeverageUpdatePanel" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="card mb-3 mx-auto" style="width: 36rem;">
                <div class="card-header">
                    <span class="fa fa-table"></span>&nbsp;Beverage Product Inventory
                </div>
                <div class="card-body">

                    <%-- Search --%>
                    <asp:Panel ID="BeverageSearchPanel" runat="server" CssClass="row" DefaultButton="BeverageSearchButton">
                        <div class="form-group col-sm-6">
                            <div class="input-group">
                                <asp:TextBox ID="BeverageSearchTextBox" runat="server" placeholder="Product Name" CssClass="form-control"></asp:TextBox>
                                <div class="input-group-append">
                                    <asp:Button ID="BeverageSearchButton" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="BeverageSearchButton_OnClick" />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>

                    <%-- Table --%>
                    <asp:GridView ID="BeverageGridView" runat="server" DataSourceID="BeverageSqlDataSource" AutoGenerateColumns="False" DataKeyNames="ID" CssClass="table table-sm table-bordered table-striped" AllowSorting="True" AllowPaging="True">
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" Visible="False" />
                            <asp:BoundField DataField="InventoryID" HeaderText="InventoryID" SortExpression="InventoryID" ReadOnly="True" Visible="False" />
                            <asp:BoundField DataField="ProductID" HeaderText="ID" SortExpression="ProductID" ReadOnly="True" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" ReadOnly="True" />
                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                            <asp:TemplateField ShowHeader="False">
                                <EditItemTemplate>
                                    <div class="d-flex flex-row justify-content-center">
                                        <asp:LinkButton ID="UpdateLinkButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-sm btn-success"></asp:LinkButton>
                                        &nbsp;<asp:LinkButton ID="CancelLinkButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-sm btn-secondary"></asp:LinkButton>
                                    </div>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <div class="d-flex flex-row justify-content-center">
                                        <asp:LinkButton ID="EditLinkButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" CssClass="btn btn-sm btn-primary"></asp:LinkButton>
                                    </div>
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
        UpdateCommand="uspUpdateInventoryItem" UpdateCommandType="StoredProcedure" FilterExpression="Name LIKE '%{0}%'">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="InventoryID" QueryStringField="InventoryID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="Quantity" Type="Int32" />
        </UpdateParameters>
        <FilterParameters>
            <asp:ControlParameter Name="Name" ControlID="FoodSearchTextBox" PropertyName="Text" />
        </FilterParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="BeverageSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" SelectCommand="SELECT i.ID, i.InventoryID, i.ProductID, p.Name, i.Quantity 
FROM InventoryItems i
	INNER JOIN [Beverage Products] p ON i.ProductID = p.ID 
WHERE (i.InventoryID = @InventoryID)"
        UpdateCommand="uspUpdateInventoryItem" UpdateCommandType="StoredProcedure" FilterExpression="Name LIKE '%{0}%'">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="InventoryID" QueryStringField="InventoryID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="Quantity" Type="Int32" />
        </UpdateParameters>
        <FilterParameters>
            <asp:ControlParameter Name="Name" ControlID="BeverageSearchTextBox" PropertyName="Text" />
        </FilterParameters>
    </asp:SqlDataSource>
</asp:Content>
