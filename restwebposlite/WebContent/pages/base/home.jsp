<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="com.sharobi.webpos.util.Constants"%>
	<%@page import="com.sharobi.webpos.base.model.Store"%>
	<%@page import="com.sharobi.webpos.vfd.Display"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    <title>:. POS :: Home :.</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME ICONS  -->
    <link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
      <link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
     <!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    
</head>
<body>
   <jsp:include page="/pages/common/header.jsp"></jsp:include>
   <input type="hidden" id="expdate" value='${expdate}' />
   <c:set var="homebgImg" value="yewpos-home.jpg"></c:set>
   <c:set var="storebgImg" value="blue-panel-store.png"></c:set>
  	<c:if test="${store.id==37 ||store.id==38}">
  		<c:set var="homebgImg" value="pos-saravanaa-home.jpg"></c:set>
  		<c:set var="storebgImg" value="black-panel-store.png"></c:set>
  	</c:if>  
    <div class="content-wrapper">
    	<!-- <div class="container-fluid"> -->
        <div class="container-fluid" id="containerId" style="background-image:url('${pageContext.request.contextPath }/assets/images/base/home/${homebgImg}');margin-top:-12px;background-position:center;background-size:cover; ">
         	<div class="col-md-4 col-sm-4">
            </div>
            <div class="col-md-4 col-sm-4">
            	<!-- <div class="container-store-details"> -->
                 <div class="container-store-details">
             			<div class="header" style="background-color: #119b4f;">${store.storeName}</div>
             			<!-- div class="content"> -->
                         <div class="content" style="background-image: url('${pageContext.request.contextPath }/assets/images/login/login_trnsprnt_panel.png');color:#fff;">
                        	<c:if test="${store.id==35}">
                        	<span style="font-weight: bold;">An Unit of Shah Trading Corporation</span>
                        	<br>
                        	</c:if>
                        	${store.address}<br>Tel: ${store.phoneNo}<br><%-- Home Phone: ${store.mobileNo} --%>
                        </div> 
                 </div>
            </div>
            <div class="col-md-4 col-sm-4">
            </div>
        </div>
    </div>
    <!-- CONTENT-WRAPPER SECTION END-->
    
    


<div class="modal fade" data-backdrop="static"
		id="licenseexpalertmodal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						Licence Information:
						
					</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div align="center" style="font-size: 20px;">
						<table>
							<tr>
								<td>Expiry Date:</td>
								<td>&nbsp;&nbsp;</td>
								<td><span id="licenceexpdate" style="color:white"></span></td>
							</tr>
						</table><br>
						<span>Your license will expire soon.Please contact with
							provider.Thanks.</span>
						
					</div>
				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;"
						data-dismiss="modal" class="btn btn-warning">Close</button>

				</div>
			</div>
		</div>
	</div>


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    <!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
      
    <!-- CORE JQUERY SCRIPTS -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
  <script type="text/javascript">
    window.onload = function() {
    	setScreenHeight();
    };
    function setScreenHeight() {
		var screenHeight = window.innerHeight || document.body.clientHeight;
		//alert(screenHeight);
		var newheight=screenHeight-133;
		document.getElementById('containerId').style.height=newheight+'px';
	}
    <%
	Store store=(Store)session.getAttribute(Constants.LOGGED_IN_STORE);
    if(store!=null)
    {
	if(store.getCustomerDisplay().startsWith("COM")){%>
 	 <% Display display=new Display(store.getCustomerDisplay());
		display.vfdWelcome(store.getCustomerDisplay());
	}
	}%>
    </script>
    


<script type="text/javascript">
     var count = "<%=session.getAttribute("count")%>" ;
     var expdate=$('#expdate').val();
       if(count == 0 && expdate != "null"){
    	   $('#licenceexpdate').html(expdate)
    	   $('#licenseexpalertmodal').modal('show');
       }
       <%session.setAttribute("count", 1);%>
     
     </script>
    
</body>
</html>