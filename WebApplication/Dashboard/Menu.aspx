﻿<%@ Page Title="Product Menu" Language="C#" MasterPageFile="~/Dashboard/Dashboard.Master" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="WebApplication.Dashboard.Menu" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Top Panel --%>
    <asp:Panel ID="HeaderPanel" runat="server" DefaultButton="SearchButton">
        <asp:UpdatePanel ID="HeaderUpdatePanel" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="row">
                    <div class="form-group col-sm-4">
                        <div class="input-group">
                            <asp:TextBox ID="SearchTextBox" runat="server" placeholder="Product Category" CssClass="form-control"></asp:TextBox>
                            <div class="input-group-append">
                                <asp:Button ID="SearchButton" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="SearchButton_OnClicktton_OnClick"/>
                            </div>
                        </div>
                    </div>
                    <div class="col mx-auto ">
                        <asp:Button ID="AddMenuButton" runat="server" Text="Add Menu Category" CssClass="btn btn-success pull-right" OnClick="AddMenuButton_OnClick"/>
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
                    <span class="fa fa-table"></span>&nbsp;Product Menu (POS)
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <asp:GridView ID="MenuGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="MenuSqlDataSource" CssClass="table table-sm table-bordered table-striped" AllowPaging="True" AllowSorting="True" OnRowCommand="MenuGridView_OnRowCommand" PagerSettings-Position="Bottom">
                            <Columns>
                                <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID" InsertVisible="False"></asp:BoundField>
                                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"/>
                                <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description"/>
                                <asp:TemplateField HeaderText="Manage">
                                    <ItemTemplate>
                                        <div class="d-flex flex-row justify-content-center">
                                            <asp:Button ID="ViewButton" runat="server" Text="View" CssClass="btn btn-sm btn-secondary mr-2" UseSubmitBehavior="False" CommandName="ViewMenu" CommandArgument='<%# Eval("ID") %>'/>
                                            <asp:Button ID="EditButton" runat="server" Text="Edit" CssClass="btn btn-sm btn-primary mr-2" UseSubmitBehavior="False" CommandName="EditMenu" CommandArgument='<%# Eval("ID") %>' OnClick="EditButton_OnClick"/>
                                            <asp:Button ID="DeleteButton" runat="server" Text="Delete" CssClass="btn btn-sm btn-danger" UseSubmitBehavior="False" CommandName="DeleteMenu" CommandArgument='<%# Eval("ID") %>' OnClick="DeleteButton_OnClick"/>
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
    <asp:Panel ID="EditPanel" runat="server" CssClass="modal fade" role="dialog" TabIndex="-1" DefaultButton="ButtonModalUpdate">
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
                            <asp:FormView ID="EditFormView" runat="server" DefaultMode="Edit" CssClass="w-100" DataSourceID="ModalSqlDataSource" DataKeyNames="ID">
                                <EditItemTemplate>
                                    <div class="form-group row">
                                        <div class="col-sm-3 col-form-label text-right">ID:</div>
                                        <div class="col-sm-9">
                                            <asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' CssClass="form-control"/>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-3 col-form-label text-right">Name:</div>
                                        <div class="col-sm-9">
                                            <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' CssClass="form-control"/>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-3 col-form-label text-right">Description:</div>
                                        <div class="col-sm-9">
                                            <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' CssClass="form-control" TextMode="MultiLine"/>
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
                                    <div class="col-sm-3 col-form-label text-right">Description:</div>
                                    <div class="col-sm-9">
                                    <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' CssClass="form-control" TextMode="MultiLine"/>
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
    <asp:Panel ID="DeletePanel" runat="server" CssClass="modal fade" role="dialog" TabIndex="-1" DefaultButton="ButtonModalDelete">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <asp:UpdatePanel ID="DeleteUpdatePanel" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div class="modal-header">
                            <h5 id="deleteModalTitle" runat="server" class="modal-title">Delete Product Menu</h5>
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
    <asp:SqlDataSource ID="MenuSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" SelectCommand="SELECT * FROM [Menus]" FilterExpression="Name LIKE '%{0}%'">
        <FilterParameters>
            <asp:ControlParameter ControlID="SearchTextBox" Name="Name" PropertyName="Text"/>
        </FilterParameters>
    </asp:SqlDataSource>

    <%-- Data Source --%>
    <asp:SqlDataSource ID="ModalSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" SelectCommand="SELECT * FROM [Menus] WHERE ([ID] = @ID)" DeleteCommand="uspDeleteMenu" DeleteCommandType="StoredProcedure" InsertCommand="uspInsertMenu" InsertCommandType="StoredProcedure" UpdateCommand="uspUpdateMenu" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32"/>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String"/>
            <asp:Parameter Name="Description" Type="String"/>
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="ID" Type="Int32"/>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int32"/>
            <asp:Parameter Name="Name" Type="String"/>
            <asp:Parameter Name="Description" Type="String"/>
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>