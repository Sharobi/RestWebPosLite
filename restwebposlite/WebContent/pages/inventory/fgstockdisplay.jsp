<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<title>:. POS :: FgStockDisplay :.</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css" rel="stylesheet" />
<!-- FONT AWESOME ICONS  -->
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/datepicker.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/jquery-ui.css" rel="stylesheet" />
<link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
<!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->



</head>
<body style="background-color: #e9e9e9;">
	<c:set var="today" value="<%=new java.util.Date()%>" />
	<input type="hidden" value="${sessionScope.itemAddFlag}" id="hdnAddItemFlag">
	<jsp:include page="/pages/common/header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-2 col-sm-2">
					<div class="menu-category">
						<div style="padding: 8px; background-color: #fff;">
							<div class="item" style="margin-bottom: 10px;"></div>
							<div class="item item-sub-child" style="background: #72bb4f;">
								<a href="javascript:viewPurchaseOrder()">SIMPLE PURCHASE ORDER</a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:viewStockIn()">SIMPLE STOCK IN</a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:viewStockOut()">SIMPLE STOCK OUT</a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:location.href='${pageContext.request.contextPath}/purchasereturn/loadpurchasereturn.htm'">SIMPLE PURCHASE RETURN</a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:location.href='${pageContext.request.contextPath}/itemstockin/loaditemstockin.htm'">FG STOCK IN</a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
							<a href="javascript:location.href='${pageContext.request.contextPath}/itemreturn/loaditemreturn.htm'">FG RETURN</a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="#">FG STOCK DISPLAY</a>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-10 col-sm-10" style="background-color: #999;">
					<div class="col-md-12 col-sm-12">
						<div class="col-md-5 col-sm-5">
							<div class="inv-requisition-0">
								STOCK DISPLAY 
							</div>
						</div>
					</div>
					<div class="col-md-12 col-sm-12" style="background: #CCCCCC;">
						<input type="text" class="text-input" id="filter" placeholder="Item Search by Name..." value="" style="width: 100%; margin-top: 10px;margin-bottom: 3px" />
					</div>
					<div class="col-md-12 col-sm-12" style="background: #CCCCCC;">
						<!-- <div class="col-md-3 col-sm-4"> -->
							<div style="background: #CCCCCC; overflow-y: auto; padding: 2px;">
								<div class="panel panel-default">
									<div class="panel-body" style="height: 400px;">
										<div class="table-responsive">
											<table class='table table-bordered header-fixed' id="itemNewStockDisplay" style='border: 1px solid #fff;'>
												 <thead style="background-color: #999;">
													<th style='text-align: center;'>ID</th>
													<th style='text-align: center;'>FOOD ITM</th>
													<th style='text-align: center;'>UNIT</th>
													<th style='text-align: center;'>RATE</th>
													<th style='text-align: center;'>CURRENT QTY</th>
												    </thead>
												    <tbody style="background-color: success;style='padding: 1px;' ">
													    <c:if test="${!empty itemLists}">
															<c:forEach items="${itemLists}" var="itemList" varStatus="status">
																<tr style="cursor: pointer; background-color: #ffffcc;" class="selected-stockin-row">
																		<td>${status.index+1}</td>
							                                            <td>${itemList.name}</td>
																		<td>${itemList.unit}</td>
																		<td>${itemList.rate}</td>
																		<td>${itemList.curStock}</td>
																</tr>
															</c:forEach>
														</c:if> 
													</tbody>
											    </table>
										</div>
									</div>
									
								
								</div>
							</div>
						<!-- </div> -->
						<div align="center">
								<div class="col-md-4 col-sm-4"></div>
								<div class="col-md-4 col-sm-4">
								<span id="operationbtnspan"></span>
									 <a href="javascript:" id="fgstockinExport" class="btn btn-success" style="background: #78B626; margin-top: 3px;">EXPORT</a>
								</div>
							</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
<div class="modal fade" data-backdrop="static" id="msgmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockinnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;" id="msgspace"></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="stockinnew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- CONTENT-WRAPPER SECTION END-->

	<!-- FOOTER SECTION END-->
	<!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
	<!-- CORE JQUERY SCRIPTS -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js">
		
	</script>
	<!-- BOOTSTRAP SCRIPTS  -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/stockDisplayScript.js"></script> 
	<script src="${pageContext.request.contextPath}/assets/js/table2excel.js"></script> 
	

	<script type="text/javascript">
    var BASE_URL="${pageContext.request.contextPath}";
    var storeID="${sessionScope.loggedinStore.id}";
    $("#filter").keyup(function(){
		   var filter = $(this).val().toLowerCase(), count = 0;
        $("#itemNewStockDisplay tbody tr").each(function(index){
           $row = $(this);
           var id = $row.find("td").eq(1).text().toLowerCase();
             if (id.indexOf(filter) != 0) {
						$row.hide();
					}
					else {
						$row.show();
					}
         });

 });

    </script>
</body>
</html>
