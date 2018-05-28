<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="POS.aspx.cs" Inherits="WebApplication.POS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="wrap">
        <div class="container">
            <div class="row">
                <div class="col">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="row no-gutters">
                                <div class="col mb-1 mr-1">
                                    <asp:Button ID="Button1" runat="server" Text="Button" CssClass="btn btn-block btn-lg btn-primary" Style="padding: 55px;" />
                                </div>
                                <div class="col mb-1 mr-1">
                                    <asp:Button ID="Button2" runat="server" Text="Button" CssClass="btn btn-block btn-lg btn-primary" Style="padding: 55px;" />
                                </div>
                                <div class="col mb-1 mr-1">
                                    <asp:Button ID="Button3" runat="server" Text="Button" CssClass="btn btn-block btn-lg btn-primary" Style="padding: 55px;" />
                                </div>
                            </div>
                            <div class="row no-gutters">
                                <div class="col mb-1 mr-1">
                                    <asp:Button ID="Button4" runat="server" Text="Button" CssClass="btn btn-block btn-lg btn-primary" Style="padding: 55px;" />
                                </div>
                                <div class="col mb-1 mr-1">
                                    <asp:Button ID="Button5" runat="server" Text="Button" CssClass="btn btn-block btn-lg btn-primary" Style="padding: 55px;" />
                                </div>
                                <div class="col mb-1 mr-1">
                                    <asp:Button ID="Button6" runat="server" Text="Button" CssClass="btn btn-block btn-lg btn-primary" Style="padding: 55px;" />
                                </div>
                            </div>
                            <div class="row no-gutters">
                                <div class="col mb-1 mr-1">
                                    <asp:Button ID="Button7" runat="server" Text="Button" CssClass="btn btn-block btn-lg btn-primary" Style="padding: 55px;" />
                                </div>
                                <div class="col mb-1 mr-1">
                                    <asp:Button ID="Button8" runat="server" Text="Button" CssClass="btn btn-block btn-lg btn-primary" Style="padding: 55px;" />
                                </div>
                                <div class="col mb-1 mr-1">
                                    <asp:Button ID="Button9" runat="server" Text="Button" CssClass="btn btn-block btn-lg btn-primary" Style="padding: 55px;" />
                                </div>
                            </div>
                            <div class="row no-gutters">
                                <div class="col mb-1 mr-1">
                                    <asp:Button ID="Button10" runat="server" Text="Button" CssClass="btn btn-block btn-lg btn-primary" Style="padding: 55px;" />
                                </div>
                                <div class="col mb-1 mr-1">
                                    <asp:Button ID="Button11" runat="server" Text="Button" CssClass="btn btn-block btn-lg btn-primary" Style="padding: 55px;" />
                                </div>
                                <div class="col mb-1 mr-1">
                                    <asp:Button ID="Button12" runat="server" Text="Button" CssClass="btn btn-block btn-lg btn-primary" Style="padding: 55px;"
                                        data-toggle="modal" data-target="#CategoricalMenuModal" />
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="col">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="GridView1" runat="server" ShowHeaderWhenEmpty="True" CssClass="table" AutoGenerateColumns="False" DataKeyNames="commentID" DataSourceID="SqlDataSource1" BorderStyle="None" GridLines="Horizontal">
                                <Columns>
                                    <asp:BoundField DataField="commentID" HeaderText="commentID" InsertVisible="False" ReadOnly="True" SortExpression="commentID" />
                                    <asp:BoundField DataField="productID" HeaderText="productID" SortExpression="productID" />
                                    <asp:BoundField DataField="commenter" HeaderText="commenter" SortExpression="commenter" />
                                    <asp:BoundField DataField="comment" HeaderText="comment" SortExpression="comment" />
                                    <asp:TemplateField HeaderText="Actions" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Button ID="GrdBtnDeletePub" runat="server" Text="Remove" CssClass="btn btn-danger"
                                                CommandArgument="" CausesValidation="false" data-toggle="modal"
                                                data-target="#EditLibIndexModal" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle BorderStyle="Solid" VerticalAlign="Middle" />
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>

        <!-- Breakfast and Plates Modal -->
        <div class="modal fade" id="CategoricalMenuModal" tabindex="-1" role="dialog" aria-labelledby="CategoricalMenuModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="CategoricalMenuModalLongTitle">Category Title</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        ...
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FANTASTICConnectionString %>" SelectCommand="SELECT * FROM [ProductComments]"></asp:SqlDataSource>
</asp:Content>
