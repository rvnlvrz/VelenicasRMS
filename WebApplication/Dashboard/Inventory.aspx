<%@ Page Title="Inventory" Language="C#" MasterPageFile="~/Dashboard/Dashboard.Master" AutoEventWireup="true" CodeBehind="Inventory.aspx.cs" Inherits="WebApplication.Dashboard.Inventory" MaintainScrollPositionOnPostback="true"%>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Top Panel --%>
    <asp:Panel ID="HeaderPanel" runat="server" >
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

    <asp:Panel ID="EditPanel" runat="server" CssClass="modal fade" role="dialog" TabIndex="-1">
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
                            <asp:FormView ID="EditFormView" runat="server" DefaultMode="Edit" CssClass="w-100" OnItemUpdating="EditFormView_OnItemUpdating" OnItemInserting="EditFormView_OnItemInserting" DataSourceID="" DataKeyNames="ID">
                                
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

    <asp:GridView ID="GridView1" runat="server"></asp:GridView>

    <asp:SqlDataSource ID="InventorySqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:VelenicasRMSConnectionString %>" SelectCommand="SELECT * FROM [Inventory]"></asp:SqlDataSource>
</asp:Content>
