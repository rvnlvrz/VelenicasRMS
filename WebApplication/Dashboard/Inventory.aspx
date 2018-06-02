<%@ Page Title="Inventory" Language="C#" MasterPageFile="~/Dashboard/Dashboard.Master" AutoEventWireup="true" CodeBehind="Inventory.aspx.cs" Inherits="WebApplication.Dashboard.Inventory" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Top Panel --%>
    <asp:Panel ID="HeaderPanel" CssClass="mb-3" runat="server">
        <asp:UpdatePanel ID="HeaderUpdatePanel" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="row">
                    <div class="col mx-auto ">
                        <asp:Button ID="CreateRecordButton" runat="server" Text="Create Record" CssClass="btn btn-success pull-right" OnClick="CreateRecordButton_OnClick"/>
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
                    <span class="fa fa-table"></span>&nbsp;Inventory Records
                </div>
                <div class="card-body">
                    <asp:GridView ID="InventoryGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="InventorySqlDataSource" CssClass="table table-sm table-bordered table-striped" AllowPaging="True" AllowSorting="True" OnRowCommand="InventoryGridView_OnRowCommand" GridLines="None">
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID" InsertVisible="False"></asp:BoundField>
                            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" DataFormatString="{0:f}"/>
                            <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type"/>
                            <asp:TemplateField HeaderText="Manage">
                                <ItemTemplate>
                                    <div class="d-flex flex-row justify-content-center">
                                        <asp:Button ID="ViewButton" runat="server" Text="View" CssClass="btn btn-sm btn-primary mr-2" UseSubmitBehavior="False" CommandName="ViewRecord" CommandArgument='<%# Eval("ID") %>'/>
                                        <asp:Button ID="DeleteButton" runat="server" Text="Delete" CssClass="btn btn-sm btn-danger" UseSubmitBehavior="False" CommandName="DeleteRecord" CommandArgument='<%# Eval("ID") %>' OnClick="DeleteButton_OnClick"/>
                                    </div>
                                </ItemTemplate>
                                <HeaderStyle CssClass="text-center"/>
                            </asp:TemplateField>
                        </Columns>
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
                                    ID:
                                    <asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>'/>
                                    <br/>
                                    Date:
                                    <asp:TextBox ID="DateTextBox" runat="server" Text='<%# Bind("Date") %>'/>
                                    <br/>
                                    Type:
                                    <asp:TextBox ID="TypeTextBox" runat="server" Text='<%# Bind("Type") %>'/>
                                    <br/>
                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    Date:
                                    <asp:TextBox ID="DateTextBox" runat="server" Text='<%# Bind("Date") %>'/>
                                    <br/>
                                    Type:
                                    <asp:TextBox ID="TypeTextBox" runat="server" Text='<%# Bind("Type") %>'/>
                                    <br/>
                                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                                    &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    ID:
                                    <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                                    <br />
                                    Date:
                                    <asp:Label ID="DateLabel" runat="server" Text='<%# Bind("Date") %>' />
                                    <br />
                                    Type:
                                    <asp:Label ID="TypeLabel" runat="server" Text='<%# Bind("Type") %>' />
                                    <br />
                                    <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                                    &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
                                    &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
                                </ItemTemplate>
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

    <%-- Data Source --%>
    <asp:SqlDataSource ID="InventorySqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" SelectCommand="SELECT * FROM [Inventory]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="ModalSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" SelectCommand="SELECT * FROM [Inventory]" InsertCommand="uspInsertInventory" InsertCommandType="StoredProcedure" UpdateCommand="uspUpdateInventory" UpdateCommandType="StoredProcedure" DeleteCommand="uspDeleteInventory" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Type" Type="String"/>
            <asp:Parameter Name="Date" Type="DateTime"/>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int32"/>
            <asp:Parameter Name="Type" Type="String"/>
            <asp:Parameter Name="Date" Type="DateTime"/>
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>