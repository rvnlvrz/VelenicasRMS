<%@ Page Title="POS" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="POS.aspx.cs" Inherits="WebApplication.POS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="backdrop">
        <div class="backdrop-tint d-flex align-items-center h-100 w-100">
            <div class="container-fluid">
                <div class="row justify-content-center align-items-center">
                    <div class="title-border" style="width: 1180px;">
                        <h4 style="font-size: 32px;" class="my-1">Velenica's Kitchen | POS</h4>
                    </div>
                </div>
                <div class="row justify-content-center align-items-center">
                    <div class="card" style="border-color: rebeccapurple;">
                        <div class="card-body">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ListView1" />
                                    <asp:AsyncPostBackTrigger ControlID="GridView1" />
                                    <asp:AsyncPostBackTrigger ControlID="BtnNewTransac" />
                                </Triggers>
                                <ContentTemplate>
                                    <div class="container">
                                        <div class="row no-gutters">
                                            <div class="col">
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
                                                            data-target="#CategoricalMenuModal" CommandArgument='<%# Eval("ID") %>'
                                                            Enabled='<%# IsInTransaction() %>' />
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
                                            </div>
                                            <div class="col">
                                                <div class="row">
                                                    <div class="col">
                                                        <asp:HiddenField ID="HfdItemID" runat="server" />
                                                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                                                            DataSourceID="SourceItems" CssClass="table" BorderStyle="None" GridLines="Horizontal"
                                                            ShowHeaderWhenEmpty="True" OnRowCommand="GridView1_RowCommand">
                                                            <Columns>
                                                                <%-- <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" />
                                            <asp:BoundField DataField="MenuItemID" HeaderText="MenuItemID" SortExpression="MenuItemID" />--%>
                                                                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                                                <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" DataFormatString="{0:c}" />
                                                                <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                                                                <asp:TemplateField HeaderText="Actions" ItemStyle-Wrap="false">
                                                                    <ItemTemplate>
                                                                        <div class="row no-gutters">
                                                                            <div class="col-sm mr-1">
                                                                                <asp:HiddenField ID="Hfdtran" runat="server" />
                                                                                <asp:HiddenField ID="HiddenField2" runat="server" />
                                                                                <asp:Button ID="GrdBtnUpdateProd" runat="server" Text="Edit" CssClass="btn btn-success btn-block"
                                                                                    CommandArgument='<%# Eval("menuItemID") %>' CausesValidation="false" data-toggle="modal"
                                                                                    data-target="#UpdateTransacModal" CommandName="upd" />
                                                                            </div>
                                                                            <div class="col-sm ml-1">
                                                                                <asp:Button ID="GrdBtnDeleteProd" runat="server" Text="Delete" CssClass="btn btn-danger btn-block"
                                                                                    CommandArgument='<%# Eval("menuItemID") %>' CausesValidation="false" data-toggle="modal"
                                                                                    data-target="#DeleteProdModal" />
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
                                                        <div class="jumbotron">
                                                            <asp:ListView ID="LvwTotals" runat="server" DataKeyNames="ID" DataSourceID="SourceTotals">
                                                                <EmptyDataTemplate>
                                                                    <span>No data was returned.</span>
                                                                </EmptyDataTemplate>
                                                                <ItemTemplate>
                                                                    <div class="row no-gutters">
                                                                        <div class="col-sm-3 text-center"
                                                                            style="border-right: solid; border-right-width: 1px;">
                                                                            <strong class="h6">ITEMS</strong>
                                                                        </div>
                                                                        <div class="col-sm-3 text-center"
                                                                            style="border-right: solid; border-right-width: 1px;">
                                                                            <asp:Label ID="ItemCountLabel" runat="server" Text='<%# Eval("ItemCount") %>'
                                                                                CssClass="h6" />
                                                                        </div>
                                                                        <div class="col-sm-3 text-center"
                                                                            style="border-right: solid; border-right-width: 1px;">
                                                                            <p class="h6">TOTAL</p>
                                                                        </div>
                                                                        <div class="col-sm-3 text-center">
                                                                            <asp:Label ID="TotalLabel" runat="server" Text='<%# Eval("Total","{0:c}") %>'
                                                                                CssClass="h6" />
                                                                        </div>
                                                                    </div>
                                                                </ItemTemplate>
                                                                <LayoutTemplate>
                                                                    <div id="itemPlaceholderContainer" runat="server" style="">
                                                                        <span runat="server" id="itemPlaceholder" />
                                                                    </div>
                                                                    <div style="">
                                                                    </div>
                                                                </LayoutTemplate>
                                                            </asp:ListView>
                                                        </div>

                                                    </div>
                                                    <div class="w-100"></div>
                                                    <div class="col text-center">
                                                        <asp:HiddenField ID="HfdTransacID" runat="server" />
                                                        <div class="form-group">
                                                            <asp:Button ID="BtnNewTransac" runat="server" Text="New Transaction" CssClass="btn btn-primary"
                                                                CausesValidation="false" data-toggle="modal" data-target="#NewTransacModal" />
                                                            <asp:Button ID="BtnCancelTransac" runat="server" Text="Cancel Transaction" CssClass="btn btn-danger"
                                                                CausesValidation="false" data-toggle="modal" data-target="#CancelTransacModal"
                                                                Enabled='<%# IsInTransaction() %>' />
                                                            <asp:Button ID="BtnPay" runat="server" Text="Checkout" CssClass="btn btn-info"
                                                                CausesValidation="false" data-toggle="modal" data-target="#EndTranModal"
                                                                OnClick="BtnPay_Click" Enabled='<%# IsInTransaction() %>' />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="wrap">
    </div>


    <!-- Categorical Items Modal -->
    <div class="modal fade" id="CategoricalMenuModal" tabindex="-1" role="dialog" aria-labelledby="CategoricalMenuModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="CategoricalMenuModalLongTitle">
                        <strong>
                            <i class="fas fa-list"></i>&nbsp;Add Item
                        </strong>
                    </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <asp:CheckBoxList ID="CheckBoxList1" runat="server" DataSourceID="SourceFoods"
                                DataTextField="productName" DataValueField="itemID"
                                CssClass="form-check">
                            </asp:CheckBoxList>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <div class="modal-footer">
                            <button id="BtnAddOrder" runat="server" type="button" class="btn btn-success"
                                onserverclick="BtnAddOrder_ServerClick">
                                Add</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
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
                    <h5 class="modal-title" id="NewTransacLabel"><strong>New Transaction</strong></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row align-items-center">
                        <div class="col-sm-4 text-center">
                            <i class="fa fa-question-circle display-1" style="color: rgb(0, 172, 237) !important;"></i>
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

    <!-- Cancel Transaction modal -->
    <div class="modal fade" id="CancelTransacModal" tabindex="-1" role="dialog" aria-labelledby="CancelTransacLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="CancelTransacLabel"><strong>Cancel Transaction</strong></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row align-items-center">
                        <div class="col-sm-4 text-center">
                            <i class="fa fa-question-circle display-1" style="color: rgb(0, 172, 237) !important;"></i>
                        </div>
                        <div class="col-sm-8">
                            <p class="text-justify">
                                Canceling a transaction will discard the current one. Are you sure you
                                    wish to continue with this process?
                            </p>
                        </div>
                    </div>
                </div>
                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                    <ContentTemplate>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" id="BtnConCancelTransac" runat="server"
                                onserverclick="BtnConCancelTransac_ServerClick">
                                YES</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">NO</button>

                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

    <!-- Delete from Transaction modal -->
    <div class="modal fade" id="DeleteProdModal" tabindex="-1" role="dialog" aria-labelledby="DeleteProdLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="DeleteProdLabel"><strong>Delete Item</strong></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row align-items-center">
                        <div class="col-sm-4 text-center">
                            <i class="fa fa-question-circle  display-1" style="color: rgb(0, 172, 237) !important;"></i>
                        </div>
                        <div class="col-sm-8">
                            <p class="text-justify">
                                Are you sure you wish to remove this item from the transaction?
                                    This action cannot be undone.
                            </p>
                        </div>
                    </div>
                </div>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" id="Button2" runat="server"
                                onserverclick="Button2_ServerClick">
                                YES</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">NO</button>

                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

    <!-- Update Transaction modal -->
    <div class="modal fade" id="UpdateTransacModal" tabindex="-1" role="dialog" aria-labelledby="UpdateTransacLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="UpdateTransacLabel"><strong>Update Transaction Item</strong></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <asp:UpdatePanel ID="UpdatePanel6" runat="server" ChildrenAsTriggers="true">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ChkDiscount" />
                    </Triggers>
                    <ContentTemplate>
                        <div class="modal-body">
                            <div class="justify-content-center align-items-center">
                                <asp:FormView ID="FvwTransacItem" runat="server" DataSourceID="SourceTransacItemEdit"
                                    CssClass="w-100" DefaultMode="Edit">
                                    <EditItemTemplate>
                                        <div class="form-group mb-1">
                                            <p class="h6">Item Name</p>
                                            <asp:TextBox ID="OrderIDTextBox" runat="server" Text='<%# Bind("ID") %>'
                                                CssClass="form-control" Enabled="false" Visible="false" />
                                            <asp:TextBox ID="MenuItemIDTextbox" runat="server" Text='<%# Bind("MenuItemID") %>'
                                                CssClass="form-control" Enabled="false" Visible="false" />
                                            <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>'
                                                CssClass="form-control" Enabled="false" />
                                        </div>
                                        <div class="form-group mb-1">
                                            <asp:TextBox ID="PriceTextBox" runat="server" Text='<%# Bind("Price") %>'
                                                CssClass="form-control" Visible="false" />
                                        </div>
                                        <div class="form-group mb-1">
                                            <p class="h6">Quantity</p>
                                            <asp:TextBox ID="QuantityTextBox" runat="server" Text='<%# Bind("Quantity") %>'
                                                CssClass="form-control" TextMode="Number" min="1" ValidationGroup="transacU" />
                                            <asp:RequiredFieldValidator ID="ReqValQuantityU" runat="server"
                                                ErrorMessage="This field is rquired" ForeColor="Red" Display="Dynamic"
                                                ControlToValidate="QuantityTextBox" ValidationGroup="transacU"></asp:RequiredFieldValidator>
                                        </div>
                                    </EditItemTemplate>
                                </asp:FormView>
                                <p class="h6">Price Discount</p>
                                <div class="form-group mb-1">
                                    <div class="form-group">
                                        <asp:CheckBox ID="ChkSenior" runat="server" OnCheckedChanged="ChkSenior_CheckedChanged"
                                            AutoPostBack="true" Text="Aplly Senior Discount" />
                                        <div class="input-group">
                                            <asp:TextBox ID="TbxSeniorDiscount" runat="server" CssClass="form-control"
                                                Enabled="false" TextMode="Number" ValidationGroup="transacU"></asp:TextBox>
                                            <div class="input-group-append">
                                                <div class="input-group-text">%</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <asp:CheckBox ID="ChkDiscount" runat="server" OnCheckedChanged="ChkDiscount_CheckedChanged"
                                            AutoPostBack="true" Text="Apply Discount" />
                                        <div class="input-group">
                                            <asp:TextBox ID="DiscountTextBox" runat="server" CssClass="form-control"
                                                Enabled="false" TextMode="Number" ValidationGroup="transacU"></asp:TextBox>
                                            <div class="input-group-append">
                                                <div class="input-group-text">%</div>
                                            </div>
                                        </div>
                                        <asp:RequiredFieldValidator ID="ReqValDiscount" runat="server"
                                            ErrorMessage="This field is rquired" ForeColor="Red" Display="Dynamic"
                                            ControlToValidate="DiscountTextBox" ValidationGroup="transacU"
                                            Enabled='<%# DiscountTextBox.Enabled %>'></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-success" id="BtnUpdateTransac" runat="server"
                                onserverclick="BtnUpdateTransac_ServerClick" validationgroup="transacU">
                                Update</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal"
                                id="CancelUpd" runat="server" onserverclick="CancelUpd_ServerClick">
                                Cancel</button>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

    <!-- End Transaction modal -->
    <div class="modal fade" id="EndTranModal" tabindex="-1" role="dialog" aria-labelledby="EndTranLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="EndTranLabel"><strong>Checkout</strong></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <asp:UpdatePanel ID="UpdatePanel7" runat="server" ChildrenAsTriggers="true">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="FvwTotal" />
                        <asp:AsyncPostBackTrigger ControlID="TbxTender" />
                        <asp:AsyncPostBackTrigger ControlID="TbxChange" />
                    </Triggers>
                    <ContentTemplate>
                        <div class="modal-body">
                            <div class="justify-content-center align-items-center">
                                <asp:FormView ID="FvwTotal" runat="server" DataKeyNames="ID" DataSourceID="SourceTotals">
                                    <ItemTemplate>
                                        <div class="form-group mb-1">
                                            <asp:Label ID="TotalLabel" runat="server" Text='<%# Bind("Total") %>'
                                                Visible="false" Enabled="false" />
                                        </div>
                                    </ItemTemplate>
                                </asp:FormView>
                                <div class="form-group mb-1">
                                    <p class="h6">Amount Due</p>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <div class="input-group-text">$</div>
                                        </div>
                                        <asp:TextBox ID="TbxPayable" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group mb-1">
                                    <p class="h6">Cash Tendered</p>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <div class="input-group-text">$</div>
                                        </div>
                                        <asp:TextBox ID="TbxTender" runat="server" CssClass="form-control" AutoPostBack="true"
                                            OnTextChanged="TbxTender_TextChanged" ValidationGroup="tender"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="ReqValTender" runat="server"
                                        ErrorMessage="This field is rquired" ForeColor="Red" Display="Dynamic"
                                        ControlToValidate="TbxTender" ValidationGroup="tender"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group mb-1">
                                    <p class="h6">Change</p>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <div class="input-group-text">$</div>
                                        </div>
                                        <asp:TextBox ID="TbxChange" runat="server" CssClass="form-control" Enabled="false" AutoPostBack="true"></asp:TextBox>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" id="BtnEndTran" runat="server"
                                onserverclick="BtnEndTran_ServerClick" validationgroup="tender">
                                CONFIRM CHECKOUT</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal"
                                id="BtnCancelCheckout" runat="server" onserverclick="BtnCancelCheckout_ServerClick">
                                CANCEL</button>

                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>


    <asp:SqlDataSource ID="SourceCategories" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" SelectCommand="SELECT * FROM [Menus]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SourceFoods" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" SelectCommand="SELECT * FROM [ItemMenu] where menuID = @id">
        <SelectParameters>
            <asp:SessionParameter Name="id" SessionField="foodKey" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SourceTransacItemEdit" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" ProviderName="<%$ ConnectionStrings:VelenicasRMSConnectionString.ProviderName %>" SelectCommand="SELECT * FROM SpecificOrder WHERE ID = @id AND MenuItemID = @itemID" UpdateCommand="EXEC UpdateTransaction @ID, @menuItemID, @Quantity, @Price" DeleteCommand="EXEC DeleteFromTransaction @tranID, @itemID">
        <DeleteParameters>
            <asp:SessionParameter Name="tranID" SessionField="transacID" Type="Int32" />
            <asp:ControlParameter ControlID="HfdTransacID" Name="itemID" PropertyName="Value" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter Name="id" SessionField="transacID" Type="Int32" />
            <asp:ControlParameter ControlID="HfdTransacID" Name="itemID" PropertyName="Value" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SourceItems" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" ProviderName="<%$ ConnectionStrings:VelenicasRMSConnectionString.ProviderName %>" SelectCommand="SELECT * FROM SpecificOrder WHERE ID = @id">
        <SelectParameters>
            <asp:SessionParameter Name="id" SessionField="transacID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SourceTotals" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" ProviderName="<%$ ConnectionStrings:VelenicasRMSConnectionString.ProviderName %>" SelectCommand="SELECT * FROM Orders WHERE ID = @id">
        <SelectParameters>
            <asp:SessionParameter Name="id" SessionField="transacID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

