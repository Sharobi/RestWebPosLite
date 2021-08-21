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
<body>
<c:set var="today" value="<%=new java.util.Date()%>" />
    <header>
        <div class="container-fluid">
            <div class="row">
	            <a style="float:left" href="${pageContext.request.contextPath }/authentication/login.htm">
					<img src="${pageContext.request.contextPath }/assets/images/header/yp_pos_topbarlogo.png" />
            	</a>
            </div>
        </div>
    </header>
    <!-- HEADER END-->
    <div class="navbar navbar-inverse set-radius-zero">
        <div class="container-fluid">
            <div class="navbar-header">
               			<div class="row">
                			<div class="col-md-12">
                            	<div style="padding-top:10px;text-align:center;margin-left:15px;text-transform:uppercase;">
           						 <strong><fmt:formatDate pattern="dd MMMM yyyy, EEEE" value="${today}" /></strong>
                                 </div>
                            </div>
						</div>
      		</div>
		</div>
    </div>
    <div class="content-wrapper" >
        <div class="container-fluid" style="background-image:url('/assets/images/login/pos-saravanaa-login.jpg'); ">
         
            <div class="col-md-4 col-sm-4">
            </div>
            <div class="col-md-4 col-sm-4">
                 <div style="background: #16a98d;margin: 80px auto; padding: 30px; text-align:center;width:100%">
                 	<h1>LOGIN</h1>
                 		<form:form modelAttribute="user" action="${pageContext.request.contextPath }/authentication/dologin.htm" method="post" role="form">
                 		<form:errors path="*" cssClass="alert alert-danger"/>
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
         </div>
    </div>
    <!-- CONTENT-WRAPPER SECTION END-->
    
    <!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
    <!-- CORE JQUERY SCRIPTS -->
    <script src="${pageContext.request.contextPath }/assets/js/jquery-1.11.1.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
    <script src="${pageContext.request.contextPath }/assets/js/bootstrap/bootstrap.js"></script>
</body>
</html>