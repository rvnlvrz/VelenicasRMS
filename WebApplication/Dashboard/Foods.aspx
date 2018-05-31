<%@ Page Title="Foods" Language="C#" MasterPageFile="~/Dashboard/Dashboard.Master" AutoEventWireup="true" CodeBehind="Foods.aspx.cs" Inherits="WebApplication.Dashboard.Products" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Top Panel --%>
    <asp:Panel ID="HeaderPanel" runat="server" DefaultButton="SearchButton">
        <asp:UpdatePanel ID="HeaderUpdatePanel" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="row">
                    <div class="form-group col-sm-4">
                        <div class="input-group">
                            <asp:TextBox ID="SearchTextBox" runat="server" placeholder="Product Name" CssClass="form-control"></asp:TextBox>
                            <div class="input-group-append">
                                <asp:Button ID="SearchButton" runat="server" Text="Search" CssClass="btn btn-primary"/>
                            </div>
                        </div>
                    </div>
                    <div class="col mx-auto ">
                        <asp:Button ID="AddProductButton" runat="server" Text="Add Food" CssClass="btn btn-success pull-right" OnClick="AddProductButton_OnClick"/>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>

    <%-- Table --%>
    <asp:UpdatePanel ID="GridUpdatePanel" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="card mb-3">
                <div class="card-header">
                    <span class="fa fa-table"></span>&nbsp;Food Products
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <asp:GridView ID="ProductsGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="FoodsSqlDataSource" CssClass="table table-bordered table-striped" AllowPaging="True" AllowSorting="True" OnRowCommand="ProductsGridView_RowCommand">
                            <Columns>
                                <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID"></asp:BoundField>
                                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"/>
                                <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" DataFormatString="{0:c}"/>
                                <asp:BoundField DataField="PersonCount" HeaderText="Serving Count" SortExpression="PersonCount"/>
                                <asp:TemplateField HeaderText="Manage">
                                    <ItemTemplate>
                                        <div class="d-flex flex-row justify-content-center">
                                            <asp:Button ID="EditButton" runat="server" Text="Edit" CssClass="btn btn-primary mr-2" UseSubmitBehavior="False" OnClick="EditButton_OnClick" CommandName="EditProduct" CommandArgument='<%# Eval("ID") %>'/>
                                            <asp:Button ID="DeleteButton" runat="server" Text="Delete" CssClass="btn btn-danger" UseSubmitBehavior="False" OnClick="DeleteButton_OnClick" CommandName="DeleteProduct" CommandArgument='<%# Eval("ID") %>'/>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="text-center"/>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <%-- Add/Edit Modal --%>
    <asp:Panel ID="EditPanel" runat="server" CssClass="modal fade" role="dialog" TabIndex="-1">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <asp:UpdatePanel ID="EditUpdatePanel" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div class="modal-header">
                            <h5 id="ModalTitle" runat="server" class="modal-title">Edit Food</h5>
                            <button type="button" class="close" aria-label="Close" data-dismiss="modal">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <asp:FormView ID="EditFormView" runat="server" DefaultMode="Edit" CssClass="w-100" OnItemUpdating="EditFormView_OnItemUpdating" OnItemInserting="EditFormView_OnItemInserting" DataSourceID="ModalSqlDataSource" DataKeyNames="ID">
                                <EditItemTemplate>
                                    <div class="form-group row">
                                        <div class="col-sm-3 col-form-label text-right">ID:</div>
                                        <asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' CssClass="col-sm-9 col-form-label"/>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-3 col-form-label text-right">Name:</div>
                                        <div class="col-sm-9">
                                            <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' CssClass="form-control"/>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-3 col-form-label text-right">Price:</div>
                                        <div class="col-sm-9">
                                            <asp:TextBox ID="PriceTextBox" runat="server" Text='<%# Bind("Price") %>' CssClass="form-control nospinner" TextMode="Number"/>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-3 col-form-label text-right">Good for:</div>
                                        <div class="col-sm-9">
                                            <asp:TextBox ID="PersonCountTextBox" runat="server" Text='<%# Bind("PersonCount") %>' CssClass="form-control nospinner" TextMode="Number"/>
                                        </div>
                                    </div>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <div class="form-group row">
                                        <div class="col-sm-3 col-form-label text-right">Name:</div>
                                        <div class="col-sm-9">
                                            <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' CssClass="form-control"/>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-3 col-form-label text-right">Price:</div>
                                        <div class="col-sm-9">
                                            <asp:TextBox ID="PriceTextBox" runat="server" Text='<%# Bind("Price") %>' CssClass="form-control nospinner" TextMode="Number"/>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-3 col-form-label text-right">Good for:</div>
                                        <div class="col-sm-9">
                                            <asp:TextBox ID="PersonCountTextBox" runat="server" Text='<%# Bind("PersonCount") %>' CssClass="form-control nospinner" TextMode="Number"/>
                                        </div>
                                    </div>
                                </InsertItemTemplate>
                            </asp:FormView>
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="ButtonModalUpdate" runat="server" Text="Update" CssClass="btn btn-primary" OnClick="ButtonModalUpdate_OnClick"/>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </asp:Panel>

    <%-- Delete Modal --%>
    <asp:Panel ID="DeletePanel" runat="server" CssClass="modal fade" role="dialog" TabIndex="-1">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <asp:UpdatePanel ID="DeleteUpdatePanel" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div class="modal-header">
                            <h5 id="deleteModalTitle" runat="server" class="modal-title">Delete Product</h5>
                            <button type="button" class="close" aria-label="Close" data-dismiss="modal">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            Are you sure you wish to delete this item?
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="ButtonModalDelete" runat="server" Text="Delete" CssClass="btn btn-danger" OnClick="ButtonModalDelete_Click"/>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </asp:Panel>

    <%-- Data Source --%>
    <asp:SqlDataSource ID="FoodsSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" SelectCommand="SELECT * FROM [Food Products]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="ModalSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" SelectCommand="SELECT * FROM [Food Products] WHERE ([ID] = @ID)" DeleteCommand="uspDeleteFood" DeleteCommandType="StoredProcedure" InsertCommand="uspInsertFood" InsertCommandType="StoredProcedure" UpdateCommand="EXEC [dbo].uspUpdateFood @Name, @Price, @PersonCount, @ID" UpdateCommandType="Text">
        <DeleteParameters>
            <asp:Parameter Name="ProductID" Type="Int32"/>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="name" Type="String"/>
            <asp:Parameter Name="price" Type="Decimal"/>
            <asp:Parameter Name="personCount" Type="Int32"/>
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="ID"/>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>