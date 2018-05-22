<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="backdrop">
        <div class="backdrop-tint d-flex align-items-center h-100 w-100">
            <div class="text-center mx-auto">
                <div class="row justify-content-center align-items-center">
                    <div class="title-border">
                        <h4 class="my-1">Velenica's Kitchen</h4>
                    </div>
                </div>
                <div class="row justify-content-center align-items-center">
                    <div class="card" style="border-color: rebeccapurple;">
                        <div class="card-body" style="width: 360px;">
                            <h5 class="card-title lead text-center display-4">
                                <strong>Sign In</strong>
                            </h5>
                            <div class="form-group">
                                <asp:TextBox ID="tbx_username" runat="server" CssClass="form-control"
                                    placeholder="username">
                                </asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:TextBox ID="tbx_password" runat="server" CssClass="form-control"
                                    placeholder="password" TextMode="Password">
                                </asp:TextBox>
                            </div>

                            <asp:Button ID="btn_login" runat="server" Text="Login" CssClass="btn btn-success form-control form-control-lg"
                                Font-Size="14px" />
                            <div class="divider">
                                <hr class="left">
                                <span class="text-muted">Found any problems?</span>
                                <hr class="right">
                            </div>
                            <div class="form-group">
                                <asp:Button ID="btn_contact" runat="server" Text="Contact Administrator" CssClass="btn btn-info form-control form-control-lg"
                                    Font-Size="14px" />
                            </div>
                            <div class="form-group text-center">
                                <p>
                                    By signing in, you are agreeing to our
                                    <a href="#">Terms of Use</a>, <a href="#">Privacy Policy</a> and claiming to be an actual staff of
                                    Valenica's Kitchen.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
