<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddProductControl.ascx.cs" Inherits="WebApplication.UserControl.AddItemControl" %>

<div class="card mx-auto mb-3" style="width: 36rem;">
    <div class="card-body">
        <h5 class="card-title text-center">Add Product</h5>
        <asp:FormView ID="FormAddItem" runat="server"></asp:FormView>
        <div class="row">
            <div class="form-group col-12">
                <asp:Label ID="LabelType" runat="server" Text="Product Type"></asp:Label>
                <asp:DropDownList ID="DropDownListType" runat="server" CssClass="form-control" OnSelectedIndexChanged="DropDownListType_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:XmlDataSource ID="ProductTypeDataSource" runat="server"></asp:XmlDataSource>
            </div>
        </div>
        <div class="row">
            <div class="form-group col-12">
                <asp:Label ID="LabelName" runat="server" Text="Product Name"></asp:Label>
                <asp:TextBox ID="TextBoxName" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="form-group col-4">
                <asp:Label ID="LabelPrice4" runat="server" Text="Price"></asp:Label>
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text">₱</span>
                    </div>
                    <asp:TextBox ID="TextBoxPrice" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                </div>
            </div>
            <div class="form-group col-4">
                <asp:Label ID="LabelQuantity" runat="server" Text="Quantity (In Stock)"></asp:Label>
                <asp:TextBox ID="TextBoxQuantity" runat="server" CssClass="form-control" TextMode="Number" Text="1"></asp:TextBox>
            </div>
            <div class="form-group col-4">
                <asp:Label ID="Label1" runat="server" Text="Good for"></asp:Label>
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text fa fa-user py-2"></span>
                    </div>
                    <asp:TextBox ID="TextBoxPeople" runat="server" CssClass="form-control" TextMode="Number" Text="1"></asp:TextBox>
                </div>
            </div>
        </div>
        <div class="d-flex flex-row text-right">
            <asp:Button ID="ButtonAdd" runat="server" Text="Save" CssClass="btn btn-primary ml-auto mr-1"/>
            <asp:Button ID="ButtonCancel" runat="server" Text="Cancel" CssClass="btn btn-danger"/>
        </div>
    </div>
</div>