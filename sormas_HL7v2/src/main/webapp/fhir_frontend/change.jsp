<%-- 
    Document   : auth
    Created on : Feb 8, 2021, 10:07:56 AM
    Author     : Augustus otu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mirabilia.org.hzi.Util.dhis.optionFiler"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.mirabilia.org.hzi.sormas.doa.DbConnector"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.PreparedStatement"%>

<!DOCTYPE html>
<html lang="en">
    <jsp:include page="template/head.jsp"></jsp:include>

        <body class="sidebar-mini layout-fixed layout-navbar-fixed layout-footer-fixed control-sidebar-slide-open accent-purple">
            <div class="wrapper">


                <!-- Navbar -->
            <jsp:include page="template/nav.jsp"></jsp:include>
                <!-- /.navbar -->

                <!-- Main Sidebar Container -->
            <jsp:include page="template/aside.jsp"></jsp:include> 


                <style>
                    .switch,.switch * {
                        -webkit-tap-highlight-color: transparent;
                        -webkit-user-select: none;
                        -moz-user-select: none;
                        -ms-user-select: none;
                        user-select: none
                    }

                    .switch label {
                        /* cursor:pointer; */
                    }

                    .switch label input[type=checkbox] {
                        opacity: 0;
                        width: 0;
                        height: 0
                    }

                    .switch label input[type=checkbox]:checked+.lever {
                        background-color: #84c7c1
                    }

                    .switch label input[type=checkbox]:checked+.lever:before,.switch label input[type=checkbox]:checked+.lever:after {
                        left: 18px
                    }

                    .switch label input[type=checkbox]:checked+.lever:after {
                        background-color: #26a69a
                    }

                    .switch label .lever {
                        /* content:""; */
                        display: inline-block;
                        position: relative;
                        width: 36px;
                        height: 14px;
                        background-color: rgba(0,0,0,0.38);
                        border-radius: 15px;
                        margin-right: 10px;
                        -webkit-transition: background 0.3s ease;
                        transition: background 0.3s ease;
                        vertical-align: middle;
                        margin: 0 16px;
                    }

                    .switch label .lever:before,.switch label .lever:after {
                        content: "";
                        position: absolute;
                        display: inline-block;
                        width: 20px;
                        height: 20px;
                        border-radius: 50%;
                        left: 0;
                        top: -3px;
                        -webkit-transition: left 0.3s ease, background .3s ease, -webkit-box-shadow 0.1s ease, -webkit-transform .1s ease;
                        transition: left 0.3s ease, background .3s ease, -webkit-box-shadow 0.1s ease, -webkit-transform .1s ease;
                        transition: left 0.3s ease, background .3s ease, box-shadow 0.1s ease, transform .1s ease;
                        transition: left 0.3s ease, background .3s ease, box-shadow 0.1s ease, transform .1s ease, -webkit-box-shadow 0.1s ease, -webkit-transform .1s ease
                    }

                    .switch label .lever:before {
                        background-color: rgba(38,166,154,0.15)
                    }

                    .switch label .lever:after {
                        background-color: #F1F1F1;
                        -webkit-box-shadow: 0px 3px 1px -2px rgba(0,0,0,0.2),0px 2px 2px 0px rgba(0,0,0,0.14),0px 1px 5px 0px rgba(0,0,0,0.12);
                        box-shadow: 0px 3px 1px -2px rgba(0,0,0,0.2),0px 2px 2px 0px rgba(0,0,0,0.14),0px 1px 5px 0px rgba(0,0,0,0.12)
                    }

                    input[type=checkbox]:checked:not(:disabled) ~ .lever:active::before,input[type=checkbox]:checked:not(:disabled).tabbed:focus ~ .lever::before {
                        -webkit-transform: scale(2.4);
                        transform: scale(2.4);
                        background-color: rgba(38,166,154,0.15)
                    }

                    input[type=checkbox]:not(:disabled) ~ .lever:active:before,input[type=checkbox]:not(:disabled).tabbed:focus ~ .lever::before {
                        -webkit-transform: scale(2.4);
                        transform: scale(2.4);
                        background-color: rgba(0,0,0,0.08)
                    }

                    .switch input[type=checkbox][disabled]+.lever {
                        cursor: default;
                        background-color: rgba(0,0,0,0.12)
                    }

                    .switch label input[type=checkbox][disabled]+.lever:after,.switch label input[type=checkbox][disabled]:checked+.lever:after {
                        background-color: #949494
                    }

                    .disabledbutton {
                        pointer-events: none;
                        opacity: 0.4;
                    }

                </style>
                <style>
                    #overlay {
                        position: fixed;
                        display: none;
                        width: 100%;
                        height: 100%;
                        top: 0;
                        left: 0;
                        right: 0;
                        bottom: 0;
                        background-color: rgba(0,0,0,0.5);
                        z-index: 2;
                        cursor: pointer;
                    }

                    #text{
                        position: absolute;
                        top: 50%;
                        left: 50%;
                        font-size: 50px;
                        color: white;
                        transform: translate(-50%,-50%);
                        -ms-transform: translate(-50%,-50%);
                    }


                </style>
                <style>
                    .lds-facebook {
                        display: inline-block;
                        position: relative;
                        width: 80px;
                        height: 80px;
                    }
                    .lds-facebook div {
                        display: inline-block;
                        position: absolute;
                        left: 8px;
                        width: 16px;
                        background: #28a745;
                        animation: lds-facebook 1.2s cubic-bezier(0, 0.5, 0.5, 1) infinite;
                    }
                    .lds-facebook div:nth-child(1) {
                        left: 8px;
                        animation-delay: -0.24s;
                    }
                    .lds-facebook div:nth-child(2) {
                        left: 32px;
                        animation-delay: -0.12s;
                    }
                    .lds-facebook div:nth-child(3) {
                        left: 56px;
                        animation-delay: 0;
                    }
                    @keyframes lds-facebook {
                        0% {
                            top: 8px;
                            height: 64px;
                        }
                        50%, 100% {
                            top: 24px;
                            height: 32px;
                        }
                    }

                    #tableData, #tableData tbody {
                        width: 100%;
                    }

                    #tableData td{
                        text-align: center;
                    }

                    #tableData th {
                        text-align: center;
                    }

                    #tableData tr{
                        border: solid 1px black;
                    }

                    .jsS span{
                        display: none;
                    }

                    .vb{
                        /*                        height: calc(2.25rem + 2px) !important;
                                                background-color: white !important;*/
                        background-color: white !important;
                    }

                    .ChangeP {
                        position: relative;
                        display: inline-block;
                    }

                    .ChangeP .tooltiptext {
                        visibility: hidden;
                        width: 140px;
                        background-color: #555;
                        color: #fff;
                        text-align: center;
                        border-radius: 6px;
                        padding: 5px;
                        position: absolute;
                        z-index: 1;
                        bottom: 150%;
                        left: 50%;
                        margin-left: -75px;
                        opacity: 0;
                        transition: opacity 0.3s;
                    }

                    .ChangeP .tooltiptext::after {
                        content: "";
                        position: absolute;
                        top: 100%;
                        left: 50%;
                        margin-left: -5px;
                        border-width: 5px;
                        border-style: solid;
                        border-color: #555 transparent transparent transparent;
                    }

                    .ChangeP:hover .tooltiptext {
                        visibility: visible;
                        opacity: 1;
                    }

                </style>
                <!-- Content Wrapper. Contains page content -->
                <div class="content-wrapper">
                    <!-- Content Header (Page header) -->
                    <section class="content-header">
                        <div class="container-fluid">
                            <div class="row mb-2">
                                <div class="col-sm-6">
                                    <h2>Authorizations</h2>
                                </div>
                                <div class="col-sm-6">
                                    <ol class="breadcrumb float-sm-right">
                                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                                        <li class="breadcrumb-item active">Authorizations</li>
                                    </ol>
                                </div>
                            </div>
                        </div><!-- /.container-fluid -->
                    </section>


                    <section class="col-lg-12 connectedSortable">
                        <div class="row">
                            <!-- Source creator -->
                            <section class="col-lg-12 connectedSortable">
                                <!-- TO DO List -->
                                <div class="card card-default">
                                    <div class="card-header">
                                        <h3 class="card-title">
                                            <i class="fas fa-file"></i>
                                            Change your password
                                        </h3>
                                    </div>
                                    <div class="row d-flex flex-column justify-content-center align-items-center">
                                        <form action="../ChangePassword" method="POST" class="row w-100">
                                            <div class="col-lg-4"></div>


                                            <div class="col-lg-4 d-flex flex-column  align-items-center p-5" >
                                                <div class="w-100 d-flex flex-column">
                                                    <div class="form-group w-100 d-flex flex-column">
                                                        <label for="oldPassword">Old Password</label>
                                                        <input required id="oldPassword" name="oldPassword"  type="password" class="form-control vb"/>
                                                    </div>
                                                    <div class="form-group w-100 d-flex flex-column">
                                                        <label for="newPassword">New Password</label>
                                                        <input required readonly="readonly" id="newPassword" name="newPassword" type="password" class="form-control vb"/>
                                                    </div>
                                                    <button type="button " class="btn btn-sm btn-primary" onclick="autoGen()">Click to auto generate password</button>

                                                    <div class="w-100 d-flex flex-row justify-content-center">
                                                        <div style="display:none;" class="lds-facebook"><div></div><div></div><div></div></div>
                                                    </div>

                                                    <div class="w-100 d-flex flex-column align-items-center justify-content-center" id="ChangeP">
                                                        <span class="tooltiptext m-3" id="myTooltip"></span>
                                                        <button id="generateBtn" type="submit" class="btn btn-success btn-flat">
                                                            Change Password
                                                        </button>


                                                    </div>

                                                </div>
                                            </div>


                                        </form>
                                    </div>
                                </div>
                            </section> 

                        </div>             

                    </section>




                </div>



                <!-- Modal -->
                <div class="modal fade" id="RespondX" role="dialog">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>

                            </div>
                            <div class="modal-body" style="overflow-x: auto;">
                                <p id="xdb"></p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            </div>
                        </div>

                    </div>
                </div>


                <div id="overlay" onclick="off()">
                    <div id="text"><h2>please wait...</h2></div></div>


            <jsp:include page="template/scripts_footer.jsp"></jsp:include>


            <script>

                function autoGen() {
                    let inp = document.getElementById("newPassword");
                    var randomstring = Math.random().toString(36).slice(-9);
                    inp.value = randomstring;
                    inp.select();
                    navigator.clipboard.writeText(randomstring)
                    .then(() => { alert(`Password copied to your clipboard, please keep it safe`) })
                    .catch((error) => { alert(`Copy failed! ${error}`) })
                    var tooltip = document.getElementById("myTooltip");
                    tooltip.innerHTML = "Password copied: "+inp.value;
                }
                function step(e) {
                    $("#" + e).addClass("disabledbutton");
                    $("#" + e).toggleClass("callout-success");
                    // alert("#2_" + e);
                    $("#2_" + e).show(500);
                    checker();
                }
                function checker() {
                    if ($("#only_").prop("checked") === true) {
                        $(".only_").prop("checked", false);
                        $('#non_app').show();
                        $('#non_app_').html('Please select the lowest level you will like the sync with DHIS2');
                        // alert("You have selected Aggregate only, hence, all other options are disabled");
                    } else {
                        //  alert("You have selected Aggregate only");
                        $('#non_app').hide();
                        $('#non_app_').html('Not applicable... please click on next');
                    }
                    ;

                    if ($("#maintenance").prop("checked") === true) {

                    } else {

                        $('#p_maintenance').show(100);
                        $('#2_stepx').remove();
                    }
                    ;

                }



                //maintenance

                function checkerX() {
                    if ($("#instll").prop("checked") === true) {
                        $("#instllx").show(1000);
                        $("#instllx_").hide(1000);


                    } else {
                        $("#instllx").hide(1000);
                        $("#instllx_").show(1000);
                    }

                }






                ;

                $('a.nope').click(function () {
                    return false;
                })


                function start_pushX_() {


                    document.getElementById("overlay").style.display = "block";
                    $('#text').html("Pushing all available matched data to sormas...");
                    var xhr = new XMLHttpRequest();
                    xhr.open('GET', '../iopujlksrefdxcersdfxcedrtyuilkmnbvsdfghoiuytrdcvbnmkiuytrewsazsedfcd345678?aggregatToDHIS=true', true);
                    xhr.responseType = 'text';
                    xhr.onload = function () {

                        if (xhr.readyState === xhr.DONE) {
                            if (xhr.status === 200) {

                                document.getElementById("overlay").style.display = "none";

                                alert('response from server  : ' + xhr.responseText);

                            }
                        }
                    };
                    xhr.send(null);

                }
                ;






                function get() {
                    $('#fomX').submit();
                    req = new XMLHttpRequest();
                    req.open("GET", '../iopujlksrefdxcersdfxcedrtyuilkmnbvsdfghoiuytrdcvbnmkiuytrewsazsedfcd345678?PUSHRESULTS=true', true);
                    req.send();
                    req.onload = function () {

                        json = JSON.parse(req.responseText);
                        var jsonViewer = new JSONViewer();
                        document.querySelector("#xdb").appendChild(jsonViewer.getContainer());


                        jsonViewer.showJSON(json, -1, -1);

                    };


                    $('#RespondX').modal('show');
                }



            </script>
    </body>
</html>
