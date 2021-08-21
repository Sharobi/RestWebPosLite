<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.sharobi.webpos.util.CommonResource"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1" />
<meta name="description" content="" />
<meta name="author" content="" />
<!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
<title>:. POS :: Top Customers Report :.</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link
	href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css"
	rel="stylesheet" />
<!-- FONT AWESOME ICONS  -->
<link
	href="${pageContext.request.contextPath}/assets/css/font-awesome.css"
	rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/style.css"
	rel="stylesheet" />
<link rel="icon" id="favicon"
	href="${pageContext.request.contextPath}/assets/images/title/fb.png">
<link href="${pageContext.request.contextPath}/assets/css/jquery-ui.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css"
	rel="stylesheet" />

<!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
	<c:set var="today" value="<%=new java.util.Date()%>" />
	<jsp:include page="/pages/common/header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="row">
				<jsp:include page="/pages/report/rptleftpanel.jsp"></jsp:include>

				<div class="col-md-10 col-sm-10">
					<div class="col-md-12 col-sm-12" align="center">
						<span style="color: #FFF; font-size: 16px; font-weight: bold;"><spring:message
								code="admin.rpt_customer_list.jsp.cont_one"	text="Top Five Customers Details" /></span>&nbsp;&nbsp; 
							
						 <span style="color: #FFF; font-size: 16px; font-weight: bold;">Report Type:</span>&nbsp;&nbsp; 
							<select id="rptType">
								<option value="1">PDF</option>
								<option value="2">Excel</option>
							</select> 	
						<a href="javascript:showpdfrpttopcustomerlist(${sessionScope.loggedinUser.storeId},document.getElementById('rptType').value)"
							class="btn btn-success"
							style="background: #FF8576; margin-bottom: 3px;"><spring:message
								code="admin.rpt_customer_list.jsp.go" text="GO" /></a>
					</div>
					<div class="col-md-12 col-sm-12">
						<div id="topcustomerListReportContainer"></div>
					</div>
				</div>
			
			</div>
		</div>
	</div>
	<!-- CONTENT-WRAPPER SECTION END-->

	<!-- FOOTER SECTION END-->
	<!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
	<script
		src="${pageContext.request.contextPath}/assets/js/reportScript.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
	<!-- CORE JQUERY SCRIPTS -->
	<script
		src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
	<!-- BOOTSTRAP SCRIPTS  -->
	<script
		src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>
	<script type="text/javascript">
   var BASE_URL="${pageContext.request.contextPath}";
   
   var pdf_url_top_customer_list='<%=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+ CommonResource.getProperty(CommonResource.WEBSERVICE_REPORT_TOP_CUSTOMER)%>'; 

	</script>
</body>
</html>