<%@ Page Title="Foods" Language="C#" MasterPageFile="~/Dashboard/Dashboard.Master" AutoEventWireup="true" CodeBehind="Foods.aspx.cs" Inherits="WebApplication.Dashboard.Products" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel ID="Panel1" runat="server" DefaultButton="SearchButton">
        <div class="row">
            <div class="form-group col-sm-4">
                <div class="input-group">
                    <asp:TextBox ID="SearchTextBox" runat="server" placeholder="Product Name" CssClass="form-control"></asp:TextBox>
                    <div class="input-group-append">
                        <asp:Button ID="SearchButton" runat="server" Text="Search" CssClass="btn btn-primary" />
                    </div>
                </div>
            </div>
            <div class="col mx-auto ">
                <asp:Button ID="AddProductButton" runat="server" Text="Add Food" CssClass="btn btn-success pull-right" />
            </div>
        </div>
    </asp:Panel>

    <%-- Table --%>
    <div class="card mb-3">
        <div class="card-header">
            <span class="fa fa-table"></span>&nbsp;Food Products
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <asp:GridView ID="ProductGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="FoodsSqlDataSource" CssClass="table table-bordered table-striped" AllowPaging="True">
                    <Columns>
                        <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" FooterText="ID">
                            <HeaderStyle CssClass="text-center" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" FooterText="Food Name" />
                        <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" DataFormatString="{0:C2}" FooterText="Price" />
                        <asp:TemplateField HeaderText="Manage" FooterText="Manage" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                            <ItemTemplate>
                                <asp:Button ID="EditProductButton" runat="server" CausesValidation="false" CommandName="" Text="Edit" CssClass="btn btn-primary"/>
                                <asp:Button ID="DeleteProductButton" runat="server" CausesValidation="false" CommandName="" Text="Delete" CssClass="btn btn-danger"/>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <%-- Data Source --%>
    <asp:SqlDataSource ID="FoodsSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" SelectCommand="SELECT * FROM [Food Products]"></asp:SqlDataSource>
</asp:Content>
