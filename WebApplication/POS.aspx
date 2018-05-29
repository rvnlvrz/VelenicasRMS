<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="POS.aspx.cs" Inherits="WebApplication.POS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="wrap">
        <div class="container">
            <div class="row no-gutters">
                <div class="col">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ListView1" />
                        </Triggers>
                        <ContentTemplate>
                            <asp:ListView ID="ListView1" runat="server" DataKeyNames="ID" DataSourceID="SourceCategories"
                                GroupItemCount="3" OnItemCommand="ListView1_ItemCommand" OnSelectedIndexChanged="ListView1_SelectedIndexChanged">
                                <EmptyDataTemplate>
                                    <table runat="server" style="">
                                        <tr>
                                            <td>No data was returned.</td>
                                        </tr>
                                    </table>
                                </EmptyDataTemplate>
                                <EmptyItemTemplate>
                                    <td runat="server" />
                                </EmptyItemTemplate>
                                <GroupTemplate>
                                    <div class="col mb-1 mr-1" id="itemPlaceholderContainer" runat="server">
                                        <div id="itemPlaceholder" runat="server"></div>
                                    </div>
                                </GroupTemplate>
                                <ItemTemplate>
                                    <asp:Button ID="Button1" runat="server" Text='<%# Eval("Name") %>'
                                        CssClass="btn btn-block btn-lg btn-primary" data-toggle="modal"
                                        data-target="#CategoricalMenuModal" CommandArgument='<%# Eval("ID") %>' />
                                </ItemTemplate>
                                <LayoutTemplate>
                                    <div class="container" id="groupPlaceholderContainer" runat="server">
                                        <div class="row no-gutters">
                                            <div class="" id="groupPlaceholder" runat="server">
                                            </div>
                                        </div>
                                    </div>
                                </LayoutTemplate>
                            </asp:ListView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <div class="col">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="GridView1" />
                        </Triggers>
                        <ContentTemplate>
                            <div class="row">
                                <div class="col">
                                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                                        DataSourceID="SourceItems" CssClass="table" BorderStyle="None" GridLines="Horizontal"
                                        ShowHeaderWhenEmpty="True">
                                        <Columns>
                                            <%-- <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" />
                                            <asp:BoundField DataField="MenuItemID" HeaderText="MenuItemID" SortExpression="MenuItemID" />--%>
                                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                            <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                                            <asp:TemplateField HeaderText="Actions" ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <div class="row no-gutters">
                                                        <div class="col-sm-0 mr-1">
                                                            <asp:Button ID="GrdBtnUpdateProd" runat="server" Text="Edit" CssClass="btn btn-success btn-block"
                                                                CommandArgument='<%# Eval("ID") %>' CausesValidation="false" data-toggle="modal"
                                                                data-target="#EditLibIndexModal" />
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <asp:Button ID="GrdBtnDeleteProd" runat="server" Text="Delete" CssClass="btn btn-danger btn-block"
                                                                CommandArgument='<%# Eval("ID") %>' CausesValidation="false" data-toggle="modal"
                                                                data-target="#EditLibIndexModal" />
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                                <ItemStyle Wrap="False" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle BorderStyle="Solid" />
                                        <RowStyle Wrap="False" />
                                    </asp:GridView>
                                </div>
                                <div class="w-100"></div>
                                <div class="col">
                                    <asp:HiddenField ID="HfdTransacID" runat="server" />
                                    <div class="form-group">
                                        <asp:Button ID="BtnNewTransac" runat="server" Text="New Transaction" CssClass="btn btn-primary"
                                            CausesValidation="false" data-toggle="modal" data-target="#NewTransacModal" />
                                    </div>

                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>

        <!-- Categorical Items Modal -->
        <div class="modal fade" id="CategoricalMenuModal" tabindex="-1" role="dialog" aria-labelledby="CategoricalMenuModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="CategoricalMenuModalLongTitle"><strong>Add Item</strong></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                            <ContentTemplate>
                                <asp:CheckBoxList ID="CheckBoxList1" runat="server" DataSourceID="SourceFoods"
                                    DataTextField="productName" DataValueField="itemID"
                                    CssClass="lead">
                                </asp:CheckBoxList>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="modal-footer">
                                <button id="BtnAddOrder" runat="server" type="button" class="btn btn-secondary"
                                    onserverclick="BtnAddOrder_ServerClick">
                                    Add</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>

        <!-- Start Transaction modal -->
        <div class="modal fade" id="NewTransacModal" tabindex="-1" role="dialog" aria-labelledby="NewTransacLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="NewTransacLabel"><strong>Rental Request</strong></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row align-items-center">
                            <div class="col-sm-4 text-center">
                                <i class="fas fa-info-circle display-1" style="color: rgb(0, 172, 237) !important;"></i>
                            </div>
                            <div class="col-sm-8">
                                <p class="text-justify">
                                    Starting a new transaction will discard the current one. Are you sure you
                                    wish to continue with this process?
                                </p>
                            </div>
                        </div>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                        <ContentTemplate>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" id="BtnConfirmStart" runat="server"
                                    onserverclick="BtnConfirmStart_ServerClick">
                                    YES</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">NO</button>

                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SourceCategories" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" SelectCommand="SELECT * FROM [Menus]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SourceFoods" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" SelectCommand="SELECT * FROM [ItemMenu] where menuID = @id">
        <SelectParameters>
            <asp:SessionParameter Name="id" SessionField="foodKey" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SourceItems" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" ProviderName="<%$ ConnectionStrings:VelenicasRMSConnectionString.ProviderName %>" SelectCommand="SELECT * FROM SpecificOrder WHERE ID = @id">
        <SelectParameters>
            <asp:SessionParameter Name="id" SessionField="transacID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

