<%@ Page Title="Inventory" Language="C#" MasterPageFile="~/Dashboard/Dashboard.Master" AutoEventWireup="true" CodeBehind="Inventory.aspx.cs" Inherits="WebApplication.Dashboard.Inventory" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Top Panel --%>
    <asp:Panel ID="HeaderPanel" CssClass="mb-3" runat="server">
        <asp:UpdatePanel ID="HeaderUpdatePanel" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="row">
                    <div class="col mx-auto ">
                        <asp:Button ID="CreateRecordButton" runat="server" Text="Create Record" CssClass="btn btn-success pull-right" OnClick="CreateRecordButton_OnClick" CausesValidation="False" />
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>

    <%-- Inventory Table --%>
    <asp:UpdatePanel ID="GridUpdatePanel" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="card mb-3">
                <div class="card-header">
                    <span class="fa fa-table"></span>&nbsp;Inventory Records
                </div>
                <div class="card-body">
                    <asp:GridView ID="InventoryGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="InventorySqlDataSource" CssClass="table table-sm table-bordered table-striped" AllowPaging="True" AllowSorting="True" OnRowCommand="InventoryGridView_OnRowCommand" GridLines="None">
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID" InsertVisible="False"></asp:BoundField>
                            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" DataFormatString="{0:F}" />
                            <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" />
                            <asp:TemplateField HeaderText="Manage">
                                <ItemTemplate>
                                    <div class="d-flex flex-row justify-content-center">
                                        <asp:Button ID="ViewButton" runat="server" Text="View" CssClass="btn btn-sm btn-secondary mr-2" UseSubmitBehavior="False" CommandName="ViewRecord" CommandArgument='<%# Eval("ID") %>' />
                                        <asp:Button ID="EditButton" runat="server" Text="Edit" CssClass="btn btn-sm btn-primary mr-2" UseSubmitBehavior="False" CommandName="EditRecord" CommandArgument='<%# Eval("ID") %>' OnClick="EditButton_OnClick" />
                                        <asp:Button ID="DeleteButton" runat="server" Text="Delete" CssClass="btn btn-sm btn-danger" UseSubmitBehavior="False" CommandName="DeleteRecord" CommandArgument='<%# Eval("ID") %>' OnClick="DeleteButton_OnClick" />
                                    </div>
                                </ItemTemplate>
                                <HeaderStyle CssClass="text-center" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <%-- Inventory Details Table --%>
    <asp:UpdatePanel ID="PivotGridUpdatePanel" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="card mb-3">
                <div class="card-header">
                    <span class="fa fa-table"></span>&nbsp;Inventory Summary
                </div>
                <div class="card-body">

                    <%-- Top Panel --%>
                    <asp:Panel ID="OptionsPanel" runat="server">
                        <asp:UpdatePanel ID="OptionsUpdatePanel" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <div class="d-flex flex-row">
                                    <div class=" col-form-label">Display From:</div>
                                    <asp:DropDownList ID="FromDropDownList" runat="server" DataSourceID="RecordSqlDataSource" DataTextField="Value" DataValueField="ID" CssClass="form-control col-2 mx-2"></asp:DropDownList>
                                    <div class="col-form-label">To</div>
                                        <asp:DropDownList ID="ToDrowDownList" runat="server" DataSourceID="RecordSqlDataSource" DataValueField="ID" DataTextField="Value" CssClass="form-control col-2 mx-2"></asp:DropDownList>
                                    <asp:Button ID="GoButton" runat="server" Text="Go" CssClass="btn btn-success" />
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </asp:Panel>

                    <%-- Grid View --%>
                    <asp:GridView ID="PivotGridView" runat="server" DataKeyNames="ProductName" CssClass="table table-sm table-bordered table-striped" AllowPaging="True" AllowSorting="True" GridLines="None" AutoGenerateColumns="False">
                    </asp:GridView>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <%-- Edit Panel --%>
    <asp:Panel ID="EditPanel" runat="server" CssClass="modal fade" role="dialog" TabIndex="-1" DefaultButton="ButtonModalUpdate">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <asp:UpdatePanel ID="EditUpdatePanel" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div class="modal-header">
                            <h5 id="ModalTitle" runat="server" class="modal-title"></h5>
                            <button type="button" class="close" aria-label="Close" data-dismiss="modal">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <asp:FormView ID="EditFormView" runat="server" DefaultMode="Insert" CssClass="w-100" DataSourceID="ModalSqlDataSource" DataKeyNames="ID">
                                <EditItemTemplate>
                                    <div class="form-group row">
                                        <div class="col-sm-3 col-form-label text-right">ID:</div>
                                        <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' CssClass="col-sm-9 col-form-label" />
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-3 col-form-label text-right">Date:</div>
                                        <div class="col-sm-9">
                                            <asp:TextBox ID="DateTextBox" runat="server" Text='<%# Bind("Date", "{0:s}") %>' CssClass="form-control" TextMode="DateTimeLocal" />
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-3 col-form-label text-right">Type:</div>
                                        <div class="col-sm-9">
                                            <asp:DropDownList ID="TypeDropDownList" runat="server" Text='<%# Bind("Type") %>' CssClass="form-control">
                                                <asp:ListItem Text="Opening" Value="Opening"></asp:ListItem>
                                                <asp:ListItem Text="Closing" Value="Closing"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <div class="form-group row">
                                        <div class="col-sm-3 col-form-label text-right">Source:</div>
                                        <div class="col-sm-9">
                                            <asp:DropDownList ID="DropDownList1" runat="server" Text='<%# Bind("SourceRecord") %>' CssClass="form-control" DataSourceID="RecordSqlDataSource" DataValueField="ID" DataTextField="Value">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-3 col-form-label text-right">Type:</div>
                                        <div class="col-sm-9">
                                            <asp:DropDownList ID="TypeDropDownList" runat="server" Text='<%# Bind("Type") %>' CssClass="form-control">
                                                <asp:ListItem Text="Opening" Value="Opening"></asp:ListItem>
                                                <asp:ListItem Text="Closing" Value="Closing"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-3 col-form-label text-right">Date:</div>
                                        <div class="col-sm-9">
                                            <asp:TextBox ID="DateTextBox" runat="server" Text='<%# Bind("Date", "{0:s}") %>' CssClass="form-control" TextMode="DateTimeLocal" />
                                        </div>
                                    </div>
                                </InsertItemTemplate>
                            </asp:FormView>
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="ButtonModalUpdate" runat="server" Text="Update" CssClass="btn btn-primary" OnClick="ButtonModalUpdate_OnClick" />
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
                            <h5 id="deleteModalTitle" runat="server" class="modal-title">Delete Product</h5>
                            <button type="button" class="close" aria-label="Close" data-dismiss="modal">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            Are you sure you wish to delete this item?
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="ButtonModalDelete" runat="server" Text="Delete" CssClass="btn btn-danger" OnClick="ButtonModalDelete_Click" />
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </asp:Panel>

    <%-- Data Source --%>
    <asp:SqlDataSource ID="InventorySqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" SelectCommand="SELECT * FROM [Inventory]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="RecordSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" SelectCommand="SELECT [ID], CONCAT([ID],' - ', [Date]) as Value FROM [Inventory] ORDER BY ID DESC"></asp:SqlDataSource>

    <asp:SqlDataSource ID="ModalSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" SelectCommand="SELECT * FROM [Inventory] WHERE ([ID] = @ID)" InsertCommand="uspInsertInventory" InsertCommandType="StoredProcedure" UpdateCommand="uspUpdateInventory" UpdateCommandType="StoredProcedure" DeleteCommand="uspDeleteInventory" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Type" Type="String" />
            <asp:Parameter Name="Date" Type="DateTime" />
            <asp:Parameter Name="SourceRecord" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="ID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="Type" Type="String" />
            <asp:Parameter Name="Date" Type="DateTime" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
