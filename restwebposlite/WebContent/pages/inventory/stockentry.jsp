<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
<title>:. POS :: FGStockIn :.</title>
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
<style type="text/css">
.selected {
	background-color: #77C5EB !important;
}
</style>
<!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->



</head>
<body style="background-color: #e9e9e9;">
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
								<a href="#">FG STOCK IN</a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
							<a href="javascript:location.href='${pageContext.request.contextPath}/itemreturn/loaditemreturn.htm'">FG RETURN</a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:location.href='${pageContext.request.contextPath}/itemstockin/stockinfo.htm'">FG STOCK DISPLAY</a>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-10 col-sm-10" style="background-color: #999;">
					<input type="hidden" id="selectedpoid" value="0"> <input type="hidden" id="invCrtBy" value="${sessionScope.loggedinUser.contactNo}"><input type="hidden" id="hidstoreid" value="${sessionScope.loggedinStore.id}">
					<div class="col-md-12 col-sm-12" style="background-color: #999;">
						<div class="col-md-2 col-sm-2">
							<div class="inv-requisition-0" style="font-size: 18px;"><spring:message code="rm.fgstockin.jsp.fgStockIn" text="FG Stock In" /></div>
							   <input type="hidden" id="hidstoreid" value="${sessionScope.loggedinStore.id}">
							</div>
					    <div class="col-md-1 col-sm-1" style="text-align: left">
					       <input type="button" value="<spring:message code="stockinnew.jsp.NEW" text="NEW" />" class="btn btn-success" style="width:60%;" onclick="newStockIn();">
						</div>
                        <div class="col-md-9 col-sm-9">
							<div class="inv-requisition-0">
								<spring:message code="rm.fgstockin.jsp.date" text="DATE" /> 
								<input type="text" disabled="disabled" id="" size="8" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
								 &nbsp;&nbsp; <%-- <spring:message code="rm.fgstockin.jsp.edpId" text="EDP ID" />  --%>
								 <!-- <input type="text" id="clickededpid" disabled="disabled" size="5" value="0"> &nbsp;&nbsp; --> 
								 <spring:message code="rm.fgstockin.jsp.fgId" text="FG ID" /> 
								 <input type="text" id="clickedfgid" disabled="disabled" size="5" value="0">
								  <spring:message code="base.inventory.jsp.fgstockin" text="INVOICE NO." /> 
								  <input type="text" id="clickedFgInvNo"  size="10" value="">
								  <spring:message code="base.inventory.jsp.fgstockin.invdate" text="INVOICE DATE" /> 
								  <input type="text" id="clickedFgInvDate"  size="10" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
								  <spring:message code="admin.showdailyexpenditure.jsp.edit.vendor" text="VENDOR" /> 
								  <select id="clickedFgSelectedVendorId" name="vendorId">
									<c:forEach items="${vendorList}" var="vendor">
										<option value="${vendor.id}">${vendor.name}</option>
									</c:forEach>
								</select>
							</div>
							
						</div>
					</div>
					<div class="col-md-12 col-sm-12" style="background: #CCCCCC;">
						<div class="col-md-3 col-sm-3">
							<div>
								<form modelAttribute="estimateDailyProd" action="${pageContext.request.contextPath }/itemstockin/getsimplefgstockinbydateandstoreid.htm" method="post">
									<div class="col-md-12 col-sm-12">
										<div class="col-md-2 col-sm-2" style="padding: 3px; font-weight: bold;"><spring:message code="rm.fgstockin.jsp.date" text="DATE:" /></div>
										<div class="col-md-5 col-sm-5" style="padding: 3px; font-weight: bold;">
											<input type="text" id="selecteddate" name="date" size="8" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
										</div>
										<div class="col-md-4 col-sm-4" style="padding: 4px; font-weight: bold;">
											<input type="submit" value="<spring:message code="rm.fgstockin.jsp.go" text="GO" />" class="btn btn-success" style="width: 100%;">
										</div>
										
									</div>
								</form>
							</div>
							<div>
							<input type="text" class="text-input"  id="itmName" placeholder="<spring:message code="rm.fgstockin.jsp.srchByItemNameAndAdd" text="Search And Select Item By Name....." />" value="" style="width: 100%; " />
							</div>

							<div class="col-md-12 col-sm-12" style="margin-top: 5%">
								<div style="height: 320px; overflow-y: auto;">
									<table id="recipeingredientlist" class="table table-bordered" cellspacing="0" width="100%">
										<thead>
											<tr style="background-color: #77C5EB">
												<th><spring:message code="rm.fgstockin.jsp.id" text="ID" /></th>
												<th><spring:message code="rmleftpanel.jsp.displayDate" text="CREATE DATE" /></th>
												<th><spring:message code="itemstockin.jsp.approve" text="APPROVE" /></th>
												
											</tr>
										</thead>
										<tbody style="background-color: success">
										    <c:if test="${!empty itemLists}">
												<c:forEach items="${itemLists}" var="itemList" varStatus="status">
													 <c:if test="${itemList.approved =='Y'}">
													     <tr style="cursor: pointer; background-color: #c8e6f0;" class="selected-stockin-row" onclick="rowClicked(${itemList.id})">
															<td>${itemList.id}</td>
				                                            <td>${itemList.createdDate}</td>
															<td>${itemList.approved}</td>
														</tr>
													  </c:if> 
													 <c:if test="${itemList.approved !='Y'}">
													<tr style="cursor: pointer; background-color: #ffffcc;" class="selected-stockin-row" onclick="rowClicked(${itemList.id})">
															<td>${itemList.id}</td>
				                                            <td>${itemList.createdDate}</td>
															<td>${itemList.approved}</td>
														</tr>
													</c:if> 
														
												 <input type="hidden" value="${itemList.id}" id="hidfgstockinId">	
												</c:forEach>
											</c:if> 
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="col-md-9 col-sm-9">
							<div class="col-md-2 col-sm-2">
								<div style="width: 90%; margin-top: 8%;">
								<%-- <spring:message code="rm.fgstockin.jsp.cat" text="Category :" />  	 --%>
								<select name="selectedmenucategoryName" id="selectedmenucategoryName" class="selectedmenucategory" onChange="getSubCategory(this.value)">
										<option value="" disabled selected><spring:message code="rawclose.jsp.SelectCategory" text="Select Category" /></option>
										<option value="0"><spring:message code="rm.fgstockin.jsp.slctAll" text="Select All" /></option>
										<c:forEach items="${menucategoryList}" var="menucategory">
											<c:if test="${menucategory.menuCategoryName !='SPECIAL NOTE'}">
												<option value="${menucategory.id}">${menucategory.menuCategoryName}</option>
											</c:if>
										</c:forEach>
									</select> 
								</div>
							   </div>
							   <div class="col-md-3 col-sm-3">
								<div style="width: 90%; margin-top: 6%;">
								<%-- <spring:message code="admin.subcategory.jsp.subCategor" text="SUB CATEGORY:" />   --%>
									<select name="selectedmenusubcategoryName" id="selectedmenusubcategoryName" class="selectedmenucategory" onChange="getItems(this.value)">
										<option value=""  disabled selected><spring:message code="recipeingredients.jsp.SelectSubCategory" text="Select Sub Category" /></option>
										<option value="0"><spring:message code="rm.fgstockin.jsp.slctAll" text="Select All" /></option>
										<c:forEach items="${menusubcategoryList}" var="menusubcategory">
											<c:if test="${menusubcategory.menuCategoryName !='SPECIAL NOTE'}">
												<option value="${menusubcategory.id}">${menusubcategory.menuCategoryName}</option>
											</c:if>
										</c:forEach>
									</select> 
								</div>
							</div>
							 <%-- <div class="col-md-3 col-sm-3">
								</div> --%> 
							<%-- <div class="col-md-1 col-sm-1">
							 <input type="submit" value="<spring:message code="order.jsp.ADD" text="ADD" />" class="btn btn-success" style="width: 100%;">
							 </div> --%>
							<div class="col-md-5 col-sm-5" id="approvediv" >
								<div class="inv-requisition">
									<spring:message code="rm.fgstockin.jsp.approved" text="Approved" />&nbsp;&nbsp; <select name="select1" id="select1" onchange="getApprovedBy(this.value)">
										<option value="N">N</option>
										<option value="Y">Y</option>
									</select><spring:message code="rm.fgstockin.jsp.by" text="By" />&nbsp;&nbsp;<input type="text" id="appvId" size="4" readonly> <a href="javascript:approveCall()" class="btn btn-success" id="fgstockinapprovedbuttion" style="background: #78B626"><spring:message code="rm.fgstockin.jsp.approve" text="APPROVE" /></a>
								</div>
							</div>
						</div>
						<div class="col-md-9 col-sm-9">
							<div style="height: 365px; overflow-y: auto; background-color: #fff;">
								<table class='table table-bordered header-fixed' id="itemNewStock" style='border: 1px solid #fff;'>
									<thead style="background-color: #999;">
										<th style='text-align: center;'><spring:message code="rm.fgstockin.jsp.id" text="ID" /></th>
										<th style='text-align: center;'><spring:message code="rm.fgstockin.jsp.fdItem" text="FOOD ITM" /></th>
										<th style='text-align: center;'><spring:message code="itemstockin.jsp.CALLCURRENTQTY" text="CURRENT QTY" /></th>
										<th style='text-align: center;'><spring:message code="inventorynew.jsp.UNIT" text="UNIT" /></th>
										<th style='text-align: center;'><spring:message code="inventorynew.jsp.RATE" text="RATE" /></th>
									   <%-- 	<th style='text-align: center;'><spring:message code="rm.fgstockin.jsp.stkQty" text="STOCKED IN" /></th>  --%>
										<th style='text-align: center;'><spring:message code="rm.fgstockin.jsp.stkInQty" text="STOCK IN QTY" /></th>
										<th style='text-align: center;'><spring:message code="rm.fgstockin.jsp.itemdisc" text="DISCOUNT" /></th>
										<th style='text-align: center;'>${sessionScope.loggedinStore.vatTaxText}</th>
										<th style='text-align: center;'>${sessionScope.loggedinStore.serviceTaxText}</th>
										<th style='text-align: center;'><spring:message code="rm.fgstockin.jsp.total" text="TOTAL" /></th>
                                        <th style='text-align: center;'>ACTION</th> 
									    <tbody style='padding: 1px;' id="itemdetails">
									   </tbody>
								    </table>
								     <div style="background-color: black;" class="hide" id="waitimage" align="center" >
											<img alt=""  src="${pageContext.request.contextPath}/assets/images/wait/wait.gif" height="150" width="150">
								    </div>
							    </div>
							<div align="center" id="savefgstockin">
							   <div class="col-md-4 col-sm-4"></div> 
							    <div class="col-md-8 col-sm-8">
							         Discount(%):<input type="text" size="5" id="discountId" onkeyup="javascript:calculateDiscount()" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;" onkeydown="numcheck(event);">
							         Discount Amt:<input type="text" readonly size="8" id="discountAmtId"  value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;">
							         ${sessionScope.loggedinStore.vatTaxText}:<input type="text" readonly size="8" id="totalVatTaxId"  value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;">
						             ${sessionScope.loggedinStore.serviceTaxText}:<input type="text" readonly size="8" id="totalServiceTaxId"  value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;">
						             <input type="text" readonly size="8" id="totalItemAmt"  value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;display:none;">
						        </div>
								<div class="col-md-4 col-sm-4"></div>
								<div class="col-md-8">
									<font style="font-weight: bold;">GRAND TOTAL:</font><input type="text" id="grandtotalId" name="totalId" size="10" value='<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="0.00"/>' style="text-align: right;" readonly="readonly"> &nbsp; 
									<font style="font-weight: bold;">Round Off:</font><input type="text" id="roundOffAmtId" name="RoundOffAmtId" size="5" value='<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="0.00"/>' style="text-align: right;" readonly="readonly"> &nbsp; 
									<span id="operationbtnspan"></span>
							    </div>
								<!-- <div class="col-md-4 col-sm-4">
									<span id="operationbtnspan"></span>
						       </div> -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- CONTENT-WRAPPER SECTION END-->
    <div class="modal fade" data-backdrop="static" id="savepurchaseorder" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.fgstockin.jsp.alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rm.fgstockin.jsp.plsSveFGStkFst" text="Please save the FG Stockin first." /></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rm.fgstockin.jsp.ok" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" data-backdrop="static" id="poapprovedmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.fgstockin.jsp.success" text="Success" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rm.fgstockin.jsp.fgStkSucApprvd" text="FG stockin successfully approved." /></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:approveFGStockin()"  style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rm.fgstockin.jsp.ok" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" data-backdrop="static" id="fgsuccessdmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.fgstockin.jsp.success" text="Success" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rm.fgstockin.jsp.fgStkSucSave" text="FG stockin successfully saved Or Updated." /></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="dataInsertPositiveStatus()" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rm.fgstockin.jsp.ok" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="fgerrormodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.fgstockin.jsp.success" text="Success" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="itemstockin.jsp.errorinsave" text="Error!!!FG stockin is not saved." /></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="dataInsertNegetiveStatus()" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rm.fgstockin.jsp.ok" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" data-backdrop="static" id="itemquantity" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.fgstockin.jsp.alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rm.fgstockin.jsp.stkQtyCnt" text="Stock in quantity cannot be greater than estimated quantity." /></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"  style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rm.fgstockin.jsp.ok" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="itemNotFoundModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.fgstockin.jsp.alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="itemstockin.jsp.ITEMNOTFOUND" text="Item Not Found.." /></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rm.fgstockin.jsp.ok" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="itemStockInDeleteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockinnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="stockinnew.jsp.Areyousure" text="Are you sure" />?</div>
					<input type="hidden" id="hdnItemId" value="">
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal"><spring:message code="stockinnew.jsp.Cancel" text="Cancel" /></button>
					<button type="button" onclick="javascript:deleteStockinItem()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="stockinnew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="itemAlreadyExistModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.fgstockin.jsp.alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="rawstockin.jsp.Itemalreadyexistspleaseselectanother" text="Item already exists please select another" /></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rm.fgstockin.jsp.ok" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="itemCanNotAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="rm.fgstockin.jsp.alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="itemstockin.jsp.DATNOTADD" text="Already Approved.Can't Add Item." /></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="rm.fgstockin.jsp.ok" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="simplestockindeletemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockinnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="stockinnew.jsp.Areyousure" text="Are you sure" />?</div>
					<input type="hidden" id="hdnSimpleStockinId" value="">
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal"><spring:message code="stockinnew.jsp.Cancel" text="Cancel" /></button>
					<button type="button" onclick="javascript:itemStockInDelete()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="stockinnew.jsp.OK" text="OK" /></button>
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
	<script src="${pageContext.request.contextPath}/assets/js/stockEntryScript.js"></script>
	<script type="text/javascript">
	var BASE_URL="${pageContext.request.contextPath}";
	var munitlists="${metricUnit}";
	var storeID="${sessionScope.loggedinStore.id}";
	var roundoffflag = "${sessionScope.loggedinStore.roundOffTotalAmtStatus}";
	var vatTaxText="${sessionScope.loggedinStore.vatTaxText}";
	var serviceTaxText="${sessionScope.loggedinStore.serviceTaxText}";
	
		$(document).ready(function() {
			 var hidfgstockinId=$("#hidfgstockinId").val();
			  if( hidfgstockinId != undefined){
				  rowClicked(hidfgstockinId);
	 		  }else {
	 			 var activebutton ="<a href='javascript:itemStockInSave()' id='stockInSave' class='btn btn-success' style='background: #78B626; margin-top: 3px;'>Save</a>";
	 			 document.getElementById("operationbtnspan").innerHTML = activebutton;  
	 			}
			
			
			
			$('#selecteddate').datepicker({
 				format : "yyyy-mm-dd",
  			   //startDate: '-0d',
 				endDate: '+0d',
 				autoclose : true
 			});
			$('#clickedFgInvDate').datepicker({
 				format : "yyyy-mm-dd",
  			   //startDate: '-0d',
 				endDate: '+0d',
 				autoclose : true
 			});
			
			
			
			 
		});
		
		$('.selected-stockin-row').on('click',function(){
	 		   $(this).parent().find('.selected-stockin-row').removeClass('selected');
	 		  $(this).addClass('selected');
	 		  });
	</script>
	
	<script>
	$(function() {
		$("#itmName") .autocomplete({
		    source : function(request, response) {
		          $.ajax({
		                      url : "${pageContext.request.contextPath}/order/autocompleteitemcode.htm",
		                      type : "GET",
		                      data : {
		                          tagName : request.term
		                      },

		                      dataType : "json",

		                      success : function(data) {
		                          response($
		                                  .map( data,function(v) {
		                                       	     return {
		                                               	      label : v.name,
		                                                      itemCode : v.id,
		                                                      items:v,
		                                                  };
		                                       	   
                                                   }));
		                      },
		                      error : function(error) {
		                          alert('error: ' + error);
		                      }
		                  });
		      },
		      select : function(e, ui) {
		    	   additemtoStocinTable(ui);
		       },
		      close: function(el) {
		          el.target.value = '';
		      }
		   });
		});
	</script>

</html>