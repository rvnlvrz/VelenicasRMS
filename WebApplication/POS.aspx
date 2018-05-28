<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="POS.aspx.cs" Inherits="WebApplication.POS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="wrap">

        <div class="container">
            <div class="row">
                <div class="col">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:ListView ID="ListView1" runat="server" DataKeyNames="categoryID" DataSourceID="SqlDataSource1"
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
                                    <asp:Button ID="Button1" runat="server" Text='<%# Eval("categoryName") %>'
                                        CssClass="btn btn-block btn-lg btn-primary" data-toggle="modal"
                                        data-target="#CategoricalMenuModal" CommandArgument='<%# Eval("categoryID") %>' />
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
                        <ContentTemplate>
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="commentID" DataSourceID="Sourceitems" CssClass="table" BorderStyle="None" GridLines="Horizontal">
                                <Columns>
                                    <asp:BoundField DataField="commentID" HeaderText="commentID" InsertVisible="False" ReadOnly="True" SortExpression="commentID" />
                                    <asp:BoundField DataField="productID" HeaderText="productID" SortExpression="productID" />
                                    <asp:BoundField DataField="comment" HeaderText="comment" SortExpression="comment" />
                                    <asp:TemplateField HeaderText="Actions">
                                        <ItemTemplate>
                                            <asp:Button ID="Button2" runat="server" Text="Remove" CssClass="btn btn-danger btn-block" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle BorderStyle="Solid" />
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
                        <h5 class="modal-title" id="CategoricalMenuModalLongTitle"><strong>Add Item</strong></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                            <ContentTemplate>
                                <asp:CheckBoxList ID="CheckBoxList1" runat="server" DataSourceID="SourceFoods" 
                                    DataTextField="foodName" DataValueField="foodID" 
                                    CssClass="lead"></asp:CheckBoxList>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:RestoTempConnectionString %>" SelectCommand="SELECT * FROM [Categories]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SourceFoods" runat="server" ConnectionString="<%$ ConnectionStrings:RestoTempConnectionString %>" ProviderName="<%$ ConnectionStrings:RestoTempConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [Foods] WHERE categoryID = @id">
        <SelectParameters>
            <asp:SessionParameter Name="id" SessionField="foodKey" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Sourceitems" runat="server" ConnectionString="<%$ ConnectionStrings:FANTASTICConnectionString %>" SelectCommand="SELECT * FROM [ProductComments]"></asp:SqlDataSource>
</asp:Content>

