<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="image-holder">
        <section id="home-banner" class="d-flex align-items-center">
            <div class="container">
                <div class="row justify-content-center align-items-center">
                    <p class="header-white-persist">VELENICA'S KITCHEN</p>
                </div>
                <hr class="style11" />
            </div>
        </section>
    </div>
    <%--header--%>
    <section style="margin-top: 120px;">
        <div class="container">
            <div class="row justify-content-center align-items-center">
                <div class="container">
                    <div>
                        <p class="display-2" style="line-height: 0.4rem; text-align: center; opacity: 0.5;">A FANTASTIC MEAL</p>
                        <p class="display-4" style="text-align: center;">with us</p>
                    </div>
                    <div class="container">
                        <div class="m-3 text-center header-text-ikaros-black">
                            <p>
                                Duis luctus nunc justo, id eleifend neque luctus vel. Maecenas mollis neque vel nunc dignissim venenatis. Mauris iaculis ut elit a molestie. 
                        Mauris at libero non ex tempor molestie. Suspendisse eu tellus fermentum, lacinia nisl sed, maximus nisl. 
                        Sed turpis tortor, dictum non mi vitae, porttitor pellentesque elit. Pellentesque convallis vestibulum velit, 
                        nec ultricies augue viverra non. Vestibulum tempor leo ipsum, et vehicula dolor iaculis quis. Quisque vitae bibendum 
                        sem. In hac habitasse platea dictumst. Nullam pharetra ante ut lacus bibendum porttitor.  
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container p-5">
            <div class="row justify-content-center align-items-center">
                <img src="Content/Images/flourish.png" />
            </div>
        </div>
    </section>
    <%--first banner--%>
    <section>
        <div class="container">
            <div class="row justify-content-center align-items-center">
                <div class="container">
                    <p class="display-2 text-center" style="opacity: 0.5; line-height: 0.4rem;">YOUR FOOD</p>
                    <p class="display-4 text-center">a work of art</p>
                </div>
            </div>
            <div class="row justify-content-center align-items-center">
                <div class="col-sm-6">
                    <div class="row align-items-end justify-content-between">
                        <div class="col-sm-4 ml-4">
                            <img src="Content/Images/Scenery/presentation1.jpg" class="crop" />
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="container">
                        <div class="m-4 right-align header-text-ikaros-black">
                            <p class="display-4">
                                <strong>Praesent elementum.</strong>
                            </p>
                            <p>
                                Ut ut mauris non metus rhoncus tristique id id odio. Praesent malesuada risus in eros eleifend, accumsan fringilla odio blandit. 
                                Cras felis justo, mattis a porttitor mattis, condimentum in velit. Sed finibus eu metus a viverra. Aliquam et urna augue. 
                                Sed orci lacus, pharetra ut elit sed, gravida tempor tellus. Nulla facilisi. Pellentesque ultrices neque dignissim turpis interdum gravida. 
                                Vestibulum fermentum nisi augue, ultricies pulvinar purus imperdiet sed. Vestibulum auctor ante quis dolor iaculis, eu accumsan lectus pretium. 
                                Nulla vel neque pretium, egestas ante non, fringilla sapien. Nullam ultricies efficitur leo, quis convallis ligula tempor at. Pellentesque sapien lorem, 
                                sollicitudin eget augue ut, auctor consequat massa. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec ultricies tincidunt risus at dignissim.
                            </p>
                            <br />
                            <p>
                                Morbi magna orci, venenatis id nisl eu, interdum ornare ligula. Donec eget eros imperdiet, pretium risus vitae, sagittis velit. 
                                Nullam consectetur et arcu a auctor. Praesent magna odio, consectetur sit amet dapibus id, lacinia ut tortor. 
                                Ut ullamcorper mollis nisi sit amet rhoncus. Duis leo lacus, efficitur in enim sed, cursus pellentesque lacus. 
                                Cras viverra arcu eget aliquet tristique. Vestibulum nibh est, porttitor vitae eros ac, tempus congue metus. 
                                Duis condimentum luctus lobortis.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container p-5">
            <div class="row justify-content-center align-items-center">
                <img src="Content/Images/flourish.png" />
            </div>
        </div>
    </section>
    <%--second banner--%>
    <section>
        <div class="container">
            <div class="row justify-content-center align-items-center">
                <div class="container">
                    <p class="display-2 text-center" style="opacity: 0.5; line-height: 0.4rem;">YOUR MEALS</p>
                    <p class="display-4 text-center">made with love</p>
                </div>
            </div>
            <div class="row justify-content-center align-items-center">
                <div class="col-sm-6">
                    <div class="container">
                        <div class="m-3 right-align header-text-ikaros-black">
                            <p class="display-4">
                                <strong>Vivamus vitae.</strong>
                            </p>
                            <p>
                               Vivamus cursus enim id maximus consectetur. Nulla eros enim, porta sed venenatis posuere, viverra nec felis. 
                                Integer risus dolor, accumsan et rutrum quis, hendrerit at leo. Vestibulum non nisl vitae quam ultrices cursus. 
                                Etiam eleifend viverra mi, eget congue erat euismod vel. Donec ullamcorper mi ipsum, eu lacinia tortor elementum et.
                                Phasellus ac sapien ornare, pretium purus in, efficitur ipsum. Integer at purus libero. Nullam pharetra ex ac enim vulputate tincidunt.
                                Nulla vitae ex quis arcu scelerisque viverra in placerat velit. Ut volutpat pulvinar quam ac sagittis. 
                                Phasellus dictum orci sit amet enim congue aliquam. Morbi est enim, tincidunt sed dolor ut, ornare maximus lorem.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="row align-items-end justify-content-between">
                        <div class="col-sm-4 ml-4">
                            <img src="Content/Images/Scenery/presentation4.jpg" class="crop" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container p-5">
            <div class="row justify-content-center align-items-center">
                <img src="Content/Images/flourish.png" />
            </div>
        </div>
    </section>
    <%--third banner--%>
    <section class="p-2">
        <div class="container">
            <div class="row justify-content-center align-items-center">
                <div class="container">
                    <p class="display-2 text-center" style="opacity: 0.5; line-height: 0.4rem;">DINE WITH US</p>
                    <p class="display-4 text-center">feel fantastic</p>
                </div>
            </div>
            <div class="row justify-content-center align-items-center">
                <div class="col-sm-6">
                    <div class="row align-items-end justify-content-between">
                        <div class="col-sm-4 ml-4">
                            <img src="Content/Images/Scenery/presentation6.jpg" class="crop" />
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="container">
                        <div class="m-4 right-align header-text-ikaros-black">
                            <p class="display-4">
                                <strong>Curabitur aliquet.</strong>
                            </p>
                            <p>
                                Sed blandit tincidunt ultrices. Duis rutrum justo felis, at venenatis ante consequat laoreet. 
                                Ut eu sapien dui. In suscipit consectetur venenatis. Class aptent taciti sociosqu ad litora torquent 
                                per conubia nostra, per inceptos himenaeos. Nulla congue feugiat laoreet. Maecenas faucibus rutrum interdum. 
                                Etiam rhoncus, nibh a auctor sollicitudin, nisl mi euismod elit, eu dapibus eros sapien at odio. In a erat 
                                malesuada, rutrum nisi vitae, feugiat orci. Mauris vel tortor enim. Donec ornare bibendum ex, vel vehicula enim 
                                vulputate sit amet.
                            </p>
                            <br />
                            <p>
                                Nulla finibus leo et libero ornare tincidunt. Ut laoreet varius mi. Etiam blandit lacus et erat laoreet, et maximus mauris feugiat. 
                                Suspendisse sed justo sit amet magna imperdiet pharetra. Mauris hendrerit ultricies augue nec vulputate. 
                                Duis eleifend commodo purus, non consequat eros tristique non. Suspendisse auctor at ipsum feugiat semper. 
                                Donec quis feugiat odio. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. 
                                Sed vulputate convallis vehicula.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <%--fourth banner--%>
</asp:Content>
