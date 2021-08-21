<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
    <title>:. POS :: Login :.</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="${pageContext.request.contextPath }/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME ICONS  -->
    <link href="${pageContext.request.contextPath }/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="${pageContext.request.contextPath }/assets/css/style.css" rel="stylesheet" />
    <link rel="icon" href="${pageContext.request.contextPath }/assets/images/title/fb.png">
     <!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body style="background: #119b4f;">
<c:set var="today" value="<%=new java.util.Date()%>" />
    <header>
        <div class="container-fluid">
            <div class="row">
	            <a style="float:left" href="${pageContext.request.contextPath }/authentication/login.htm">
					<img src="${pageContext.request.contextPath }/assets/images/header/yewpos_f&b_lite_logo.png" />
            	</a>
            </div>
        </div>
    </header>
    <!-- HEADER END-->
    <div class="navbar navbar-inverse set-radius-zero" style="background: #bebebe;">
        <div class="container-fluid">
            <div class="navbar-header">
               			<div class="row">
                			<div class="col-md-12">
                            	<div style="padding-top:10px;text-align:center;margin-left:15px;text-transform:uppercase;color: #fff;">
           						 <strong><fmt:formatDate pattern="dd MMMM yyyy, EEEE" value="${today}" /></strong>
                                 </div>
                            </div>
						</div>
      		</div>
		</div>
    </div>
    <div class="content-wrapper" >
        <!-- <div class="container-fluid" style="background-color:#222222;"> -->
         <div class="container-fluid" id="containerId" style="background-image:url('${pageContext.request.contextPath }/assets/images/base/home/yewpos-home.jpg');margin-top:-12px;
      background-size:cover; padding-top:66px; background-position:center; ">
            <div class="col-md-4 col-sm-4">
            </div>
            <div class="col-md-4 col-sm-4">
                 <!-- <div style="background: #16a98d;margin: 80px auto; padding: 30px; text-align:center;width:100%"> -->
                 <div style="background-image:url('${pageContext.request.contextPath }/assets/images/login/login_trnsprnt_panel.png');margin: 50px auto; padding: 10px 30px; text-align:center;width:80%">
                 	<h1 style="color: #fff">LOGIN</h1>
                 		<form:form modelAttribute="user" action="${pageContext.request.contextPath }/authentication/dologin.htm" method="post" role="form">
                 		<form:errors path="*" cssClass="alert alert-danger"/>
                 		<c:if test="${msg == 'explicense'}">
							<button type="button" class="btn btn-info" data-toggle="modal" data-target="#explicensemodal">Get License</button>
						</c:if>
						<c:if test="${msg == 'nolicense'}">
							<button type="button" class="btn btn-info" data-toggle="modal" data-target="#nolicensemodal">Get License</button>
						</c:if>
                     		<div class="input-group">
             					<span class="input-group-addon">
                				<i class="fa fa-user"></i>
                				</span>
                				<form:input path="userName" class="form-control"/>
           					</div>
                			<br />
                			<div class="input-group">
             					<span class="input-group-addon">
                				<i class="fa fa-lock"></i>
            					</span>
            					<form:password path="password" class="form-control"/>
           					</div>
           					<br/>
           					<%-- <a href="${pageContext.request.contextPath }/home/welcome.htm" class="btn btn-info">&nbsp;LOGIN </a>&nbsp; --%>
           					<input type="submit" value="Login" class="btn btn-info">
           				</form:form>
                 </div>
            </div>
            <div class="col-md-4 col-sm-4">
            </div>
            <div class="col-md-12 col-sm-12">
            <div align="center" style="font-size: 24px;color: #535353;margin-top: 40px;padding: 2px;">
            ONE STOP SOLUTION FOR YOUR BUSINESS
            </div>
            </div>
         </div>
    </div>
    <!-- CONTENT-WRAPPER SECTION END-->
    
    <!-- Modal -->
	<div class="modal fade" data-backdrop="static" id="nolicensemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">You have no license!</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">
						Please contact customer support for licensing.<br /> or <br /> Do you have a License key.
					</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

					<button type="button" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">No</button>
					<button type="button" onclick="javascript:getLicense()" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">Yes</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="explicensemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">License Expired!</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Do you have new License key ?</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

					<button type="button" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">No</button>
					<button type="button" onclick="javascript:getLicense()" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">Yes</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="activatelicensemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Enter a product key</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">
						This product key looks similar to this:<br /> PRODUCT KEY :QWFhYUREemRtMDFQd2Fk <br /> <br />
					</div>
					<div style="text-align: center; font-size: 20px;">
						Enter Product Key :<br /> <font color="black"><input type="text" size="25" id="productkey"  /></font>
					</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

					<button type="button" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">Cancel</button>
					<button type="button" onclick="javascript:getLicenseKey()" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">Activate</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="licenseinfomodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Licence Information:</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div align="center" style="font-size: 20px;">
						<table>
							<tr>
								<td>Valid From</td>
								<td>: &nbsp;&nbsp;</td>
								<td><span id="licvalidfrom"></span></td>
							</tr>
							<tr>
								<td>Valid To</td>
								<td>: &nbsp;&nbsp;</td>
								<td><span id="licvalidto"></span></td>
							</tr>
							<tr>
								<td>Status</td>
								<td>: &nbsp;&nbsp;</td>
								<td><span id="licstatus"></span></td>
							</tr>
							<tr>
								<td>Number of Users</td>
								<td>: &nbsp;&nbsp;</td>
								<td><span id="licnoofuser"></span></td>
							</tr>
						</table>
					</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

					<!-- 					<button type="button"  style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">Cancel</button> -->
					<button type="button" onclick="javascript:reloadPage()" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
    
    <!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
    <!-- CORE JQUERY SCRIPTS -->
    <script src="${pageContext.request.contextPath }/assets/js/jquery-1.11.1.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
    <script src="${pageContext.request.contextPath }/assets/js/bootstrap/bootstrap.js"></script>
    <script type="text/javascript">
    var BASE_URL = "${pageContext.request.contextPath}";
    window.onload = function() {
    	setScreenHeight();
    };
    function setScreenHeight() {
		var screenHeight = window.innerHeight || document.body.clientHeight;
		//alert(screenHeight);
		var newheight=screenHeight-115;
		document.getElementById('containerId').style.height=newheight+'px';
	}
    function getLicense() {
		$('#nolicensemodal').modal('hide');
		$('#activatelicensemodal').modal('show');

	}
	function getLicenseKey() {
		var lickey = $('#productkey').val();
		$.ajax({
			url : BASE_URL + "/authentication/addlicensekey/" + lickey + ".htm",
			type : 'GET',
			// 				  contentType:'application/json;charset=utf-8',
			//				  data: JSON.stringify(SpliBill),
			success : function(response) {
				//called when successful
//					console.log(response);
				var responseObj = JSON.parse(response);
				$('#activatelicensemodal').modal('hide');
				$('#licenseinfomodal').modal('show');
				$('#licvalidfrom').text(responseObj.from_date);
				$('#licvalidto').text(responseObj.to_date);
				$('#licstatus').text(responseObj.status);
				$('#licnoofuser').text(responseObj.no_of_users);
			},
			error : function(e) {
				//called when there is an error
				//console.log(e.message);
			}
		});
	}
	function reloadPage(){
		location.href=BASE_URL;
	}
    </script>
</body>
</html>