<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddProductControl.ascx.cs" Inherits="WebApplication.UserControl.AddItemControl" %>

<asp:UpdatePanel ID="AddProductEditPanel" runat="server">
    <ContentTemplate>
        <div class="card mx-auto mb-3" style="width: 36rem;">
            <div class="card-body">
                <h5 class="card-title text-center">Add Product</h5>
                <asp:FormView ID="FormAddItem" runat="server"></asp:FormView>
                <div class="row">
                    <div class="form-group col">
                        <asp:Label ID="LabelType" runat="server" Text="Product Type"></asp:Label>
                        <asp:DropDownList ID="DropDownListType" runat="server" CssClass="form-control" OnSelectedIndexChanged="DropDownListType_SelectedIndexChanged" AutoPostBack="True">
                            <asp:ListItem Value="0" Text="Food"></asp:ListItem>
                            <asp:ListItem Value="1" Text="Beverage"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col">
                        <asp:Label ID="LabelName" runat="server" Text="Product Name"></asp:Label>
                        <asp:TextBox ID="TextBoxName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col">
                        <asp:Label ID="LabelPrice4" runat="server" Text="Price"></asp:Label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text">₱</span>
                            </div>
                            <asp:TextBox ID="TextBoxPrice" runat="server" CssClass="form-control text-center nospinner" TextMode="Number"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group col">
                        <asp:Label ID="Label1" runat="server" Text="Good for"></asp:Label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <asp:LinkButton ID="SubPersonButton" runat="server" CssClass="btn btn-outline-secondary">
                                <i class="fa fa-minus"></i>
                                </asp:LinkButton>
                            </div>
                            <asp:TextBox ID="TextBoxPeople" runat="server" CssClass="form-control text-center nospinner" TextMode="Number" Text="1"></asp:TextBox>
                            <div class="input-group-append">
                                <asp:LinkButton ID="AddPersonButton" runat="server" CssClass="btn btn-outline-secondary">
                                <i class="fa fa-plus"></i>
                                </asp:LinkButton>
                                <span class="input-group-text">Person(s)</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="d-flex flex-row text-right">
                    <asp:Button ID="ButtonAdd" runat="server" Text="Save" CssClass="btn btn-primary ml-auto mr-1" />
                    <asp:Button ID="ButtonCancel" runat="server" Text="Cancel" CssClass="btn btn-danger" />
                </div>
            </div>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>
