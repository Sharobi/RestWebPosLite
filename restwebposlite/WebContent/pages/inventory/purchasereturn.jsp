<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
<title>:. POS :: PurchaseReturn :.</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css" rel="stylesheet" />
<!-- FONT AWESOME ICONS  -->
<link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/datepicker.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/jquery-ui.css" rel="stylesheet" />
<link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
</head>
<body style="background-color: #e9e9e9;">
	<jsp:include page="/pages/common/header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">
			 <div class="row">
				<div class="col-md-2 col-sm-2">
					<div class="menu-category">
						<div style="padding: 8px;background-color: #fff;" >
							<div class="item" style="margin-bottom: 10px;"></div>
							<div class="item item-sub-child" style="background: #72bb4f;">
								<a href="javascript:viewPurchaseOrder()"><spring:message code="stockinnew.jsp.SIMPLEPURCHASEORDER" text="SIMPLE PURCHASE ORDER" /></a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:viewStockIn()"><spring:message code="stockinnew.jsp.SIMPLESTOCKIN" text="SIMPLE STOCK IN" /></a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:viewStockOut()"><spring:message code="stockinnew.jsp.SIMPLESTOCKOUT" text="SIMPLE STOCK OUT" /></a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="#"><spring:message code="inventorynew.jsp.SIMPLEPURCHASERETURN" text="SIMPLE PURCHASE RETURN" /></a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:viewItemStockInsertPage()"><spring:message code="rmleftpanel.jsp.FGSimpleStockIn" text="FG STOCK IN"/></a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
							<a href="javascript:location.href='${pageContext.request.contextPath}/itemreturn/loaditemreturn.htm'">FG RETURN</a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:location.href='${pageContext.request.contextPath}/itemstockin/stockinfo.htm'"><spring:message code="rmleftpanel.jsp.FGSimpleStockInDispaly" text="FG STOCK DISPLAY"/></a>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-10 col-sm-10" style="background-color: #999;">
					<div class="col-md-12 col-sm-12">
						<div class="col-md-5 col-sm-5">
							<div class="inv-requisition-0">
								<spring:message code="purchasereturn.jsp.header" text="PURCHASE RETURN" /> <a href="javascript:openNewPurchaseReturn()" class="btn btn-success" style="background: #78B626"><spring:message code="stockinnew.jsp.NEW" text="NEW" /></a>
							</div>
						</div>
						<div class="col-md-7 col-sm-7">
							<div class="inv-requisition">
								<spring:message code="stockinnew.jsp.Date" text="Date" />&nbsp;&nbsp;<input type="text" id="purchasereturncreatedate" size="8" readonly value='<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>' style="text-align: center;"> <spring:message code="stockinnew.jsp.CreatedBy" text="Created By" />&nbsp;&nbsp;<input type="text" size="2" readonly value="${sessionScope.loggedinUser.contactNo}" style="text-align: center;"> <spring:message code="purchasereturn.jsp.purchasereturnId" text="Return Id" />&nbsp;&nbsp;<input type="text" size="2" id="createdpurchasereturnid" readonly value="0" style="text-align: center;">
							<input type="hidden" id="hiduserid" value="${sessionScope.loggedinUser.contactNo}">
							</div>
						</div>
					</div>

					<div class="col-md-12 col-sm-12" style="background: #CCCCCC;">
						<div class="col-md-3 ">
							<div class="inv-requisition">
								<spring:message code="stockinnew.jsp.Date" text="Date" />&nbsp;&nbsp;<input type="text" name="selecteddate" id="purchaseReturnDate" size="8" readonly value='<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>'>&nbsp;&nbsp; <a href="javascript:getPurchaseReturnByDate()" class="btn btn-success" style="background: #78B626"><spring:message code="stockinnew.jsp.GO" text="GO" /></a>
							</div>
						</div>
						<div class="col-md-6 col-sm-6">
							<div class="inv-requisition">
								<spring:message code="stockinnew.jsp.BillDate" text="Bill Date" />&nbsp;&nbsp;<input type="text" id="billDate" name="billDate" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>' size="8" readonly><spring:message code="stockinnew.jsp.BillNo" text="Bill No" />&nbsp;&nbsp;<input type="text" id="billNo" name="billNo" value="0" size="6" readonly> <spring:message code="stockinnew.jsp.Vendor" text="Vendor" />&nbsp;&nbsp; <select id="selectedvendorId" name="vendorId">
									<c:forEach items="${vendorList}" var="vendor">
										<option value="${vendor.id}">${vendor.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="col-md-3 col-sm-6">
							<div class="inv-requisition">
								<spring:message code="stockinnew.jsp.Close" text="Close" /> &nbsp;&nbsp;<select id="closepurchasereturn" name="selectPO" onchange="getSelectedStatus(this.value)"><option value="N">N</option>
									<option value="Y">Y</option></select><spring:message code="stockinnew.jsp.By" text="By" /> &nbsp;&nbsp;<input type="text" size="4" id="purchaseReturnUserId" value=""> <a href="javascript:closeStatusUpdated()" id="closepurchasereturnButton" class="btn btn-success" style="background: #78B626"><spring:message code="stockinnew.jsp.DONE" text="DONE" /></a>
							</div>
						</div>

					</div>
					<div class="col-md-12 col-sm-12" style="background: #CCCCCC;">
					<%-- <div class="col-md-4" id="serachDiv">
							<div class="inv-requisition">
								<input type="text" size="16" placeholder="SEARCH" id="search" name="search" value=""> <input type="text" readonly size="4" id="searchCode" value="">&nbsp;&nbsp; <a href="javascript:addNewStockInItem()" class="btn btn-success" style="background: #78B626"><spring:message code="stockinnew.jsp.ADD" text="ADD" /></a>
							</div>
						</div> --%>

						<div class="col-md-3" id="billSearchDiv">
							<div class="inv-requisition">
								<input type="text" size="16" placeholder="STOCKIN NUMBER" id="stkinNo" name="StkinNo" value="" onkeydown="numcheck(event);"> &nbsp;&nbsp; <a href="javascript:bringBillDetails()" id="billcallbtn" class="btn btn-success" style="background: #78B626"><spring:message code="stockinnew.jsp.ADD" text="ADD" /></a>
							</div>
						</div>
						<div class="col-md-3" id="reasonDiv">
						   <div class="inv-requisition">
						      <spring:message code="purchasereturn.jsp.returnreason" text="Return Reason" />&nbsp;&nbsp;
						      <select id="selectedreturnreasonId" name="returnreasonId" onchange="selectReason(this.value);">
									<option value="0">Select Return Type</option>
									<c:forEach items="${reasons}" var="returnreason">
										<option value="${returnreason.id}">${returnreason.remark}</option>
									</c:forEach>
								</select>
						   </div>
						</div>
						<div class="col-md-6" id="remarksDiv">
						   <div class="inv-requisition">
						      <spring:message code="purchasereturn.jsp.returnremarks" text="Remarks" />&nbsp;&nbsp;
						      <input type="text" size="52"  id="returnRemarks"  value="">
						   </div>
						</div>

					</div>
					<div class="col-md-12 col-sm-12" style="background: #CCCCCC;">
						<input type="hidden" id="hidvatTaxVal" value="${sessionScope.loggedinStore.vatAmt}"> <input type="hidden" id="hidstoreid" value="${sessionScope.loggedinStore.id}"> <input type="hidden" id="hidcurrCode" value="${sessionScope.loggedinStore.currency}">
						<input type="hidden" id="selectedpurchasereturnid" value="0">
						<div class="col-md-3 col-sm-4">
							<div style="background: #CCCCCC; overflow-y: auto; padding: 2px;">
								<div class="panel panel-default">
									<div class="panel-body" style="height: 200px;">
										<div class="table-responsive">
											<table class="table table-striped table-bordered" id="inventoryPurchaseReturnListTbl">
												<thead>
													<tr style="background: #77C5EB;">
														<th> <spring:message code="stockinnew.jsp.ID" text="ID" /></th>
														<th><spring:message code="stockinnew.jsp.VENDOR" text="VENDOR" /></th>
													    <th><spring:message code="stockinnew.jsp.CLOSED" text="CLOSED" /></th>
													</tr>
												</thead>
												<c:if test="${! empty inventoryPurchaseReturnList}">
													<c:forEach items="${inventoryPurchaseReturnList}" var="inventoryPurchaseReturn" varStatus="odrStatus">
													    <c:if test="${inventoryPurchaseReturn.edpId ==0}">
														<tr style="background-color: #C8E6F0; cursor: pointer;" onclick="rowClicked(${inventoryPurchaseReturn.id})">
															<td>${inventoryPurchaseReturn.id}</td>
															<td>${inventoryPurchaseReturn.vendorName}</td>
															<td id="purchasereturnstatus_${inventoryPurchaseReturn.id}">${inventoryPurchaseReturn.approved}</td>
														</tr>
														<input type="hidden" value="${inventoryPurchaseReturn.id}" id="hidpurchasereturnsId">
														 </c:if>

													</c:forEach>
												</c:if>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-9 col-sm-8">
							<div style="background: #FFF; overflow-y: auto; padding: 2px;">
								<div class="panel panel-default">
									<div class="panel-body" style="height: 260px;">
										<div class="table-responsive" id="purchaseReturnItemTableDiv">
											<table class="table table-striped table-bordered table-hover" style="" id="purchaseReturnItemTable">
												<thead style="background: #999999;">
													<th><spring:message code="stockinnew.jsp.ID" text="ID" /></th>
													<th><spring:message code="stockinnew.jsp.ITEM" text="ITEM" /></th>
													<th><spring:message code="purchasereturn.jsp.INVQUANTITY" text="INV QTY" /></th>
													<th><spring:message code="purchasereturn.jsp.RETURNQUANTITY" text="RETURN QTY" /></th>
													<th><spring:message code="stockinnew.jsp.UNIT" text="UNIT" /></th>
													<th><spring:message code="purchasereturn.jsp.INVRATE" text="INV RATE" /></th>
													<th><spring:message code="purchasereturn.jsp.RETURNRATE" text="RETURN RATE" /></th>
													<th><spring:message code="stockinnew.jsp.TAX" text="TAX(%)" /></th>
													<th style="display:none;"><spring:message code="purchasereturn.jsp.TAXAMOUNT" text="TAX AMT" /></th>
													<th><spring:message code="purchasereturn.jsp.DISCOUNT" text="DISC(%)" /></th>
													<th><spring:message code="purchasereturn.jsp.DISCOUNTAMOUNT" text="DISC AMT" /></th>

													<th style="display:none;"><spring:message code="stockinnew.jsp.ITEMAMOUNT" text="ITEM AMOUNT" /></th>
													<th><spring:message code="stockinnew.jsp.TOTAL" text="TOTAL" /></th>
													<th><spring:message code="purchasereturn.jsp.REASON" text="REASON" /></th>
													<th style="display:none;"><spring:message code="stockinnew.jsp.PONO" text="PO NO" /></th>
													<th><spring:message code="stockinnew.jsp.ACTION" text="ACTION" /></th>
												</thead>
												<tbody id="returnitemdetails"></tbody>
											</table>
										</div>
										<div style="background-color: black;" class="hide" id="waitimage" align="center">
											<img alt="" src="${pageContext.request.contextPath}/assets/images/wait/wait.gif" height="150" width="150">
									   </div>
										
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-4 col-sm-4"></div>
						<div class="col-md-8 col-sm-8">
							<spring:message code="stockinnew.jsp.MiscCharges" text="Misc Charges" />:<input type="text" readonly size="10" id="misChargeId" onkeyup="javascript:calculateGrandTotal()" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;" onkeydown='numcheck(event);'>
							<spring:message code="stockinnew.jsp.DiscountPerc" text="Discount(%)" />:<input type="text" readonly size="5" id="discountId" onkeyup="javascript:calculateDiscount()" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;" onkeydown='numcheck(event);'>
							<spring:message code="stockinnew.jsp.DiscountAmt" text="Discount Amt" />:<input type="text"  readonly size="8" id="discountAmtId"  value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;">
							<spring:message code="stockinnew.jsp.TotalTax" text="Tax Amt" />:<input type="text" readonly size="8" id="totalTaxId"  value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;">
						    <input type="text"  size="8" id="itemtotal"  value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;display:none;">
						</div>
						<div class="col-md-4 col-sm-4"></div>
						<div class="col-md-7">
							<font style="font-weight: bold;"><spring:message code="stockinnew.jsp.GRANDTOTAL" text="GRAND TOTAL" />:</font><input type="text" id="grandtotalId" name="totalId" size="10" value='<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="0.00"/>' style="text-align: right;" readonly="readonly"> &nbsp;
							<font style="font-weight: bold;"><spring:message code="stockinnew.jsp.ROUNDOFFAMT" text="Round Off" />:</font><input type="text" id="roundOffAmtId" name="RoundOffAmtId" size="5" value='<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="0.00"/>' style="text-align: right;" readonly="readonly"> &nbsp;
							<span id="operationbtnspan"></span>

						    <a href="javascript:PurchaseReturnDeleteConfirmation()" id="PurchaseReturnDelete" class="btn btn-success" style="background: #78B626; margin-top: 3px;"><spring:message code="inventorynew.jsp.Delete" text="Delete" /></a>
						   <%--  <a href="javascript:PurchaseReturnPrintData()" id="PurchaseReturnPrint" class="btn btn-success" style="background: #78B626; margin-top: 3px;"><spring:message code="inventorynew.jsp.Print" text="Print" /></a> --%>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--modal-->
	<div class="modal fade" data-backdrop="static" id="alreadyexistitem" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockinnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="stockinnew.jsp.Itemalreadyexistspleaseselectanother" text="Item already exists, please select another" />.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="stockinnew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="validitemquantityorrate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockinnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="stockinnew.jsp.PleaseenteravalidItemQuantityOrItemRate" text="Please enter a valid Item Quantity Or Item Rate" />.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="stockinnew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="positiveitemquantityorrate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockinnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="purchasereturn.jsp.PleaseenterapositiveItemQuantityOrItemRateOrSelecrReturnType" text="Please enter a positive Item Quantity Or Item Rate Or Return Type" />.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="stockinnew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="purchasereturnitemdeletemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockinnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="stockinnew.jsp.Areyousure" text="Are you sure" />?</div>
					<input type="hidden" id="hdnPurchaseReturnItemId" value="">
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal"><spring:message code="stockinnew.jsp.Cancel" text="Cancel" /></button>
					<button type="button" onclick="javascript:deletePurchaseReturnItem()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="stockinnew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="existingstockinitemdeletemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockinnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="stockinnew.jsp.Areyousure" text="Are you sure" />?</div>
					<input type="hidden" id="hdnitemstockinid" value=""> <input type="hidden" id="hdnstockinid" value=""> <input type="hidden" id="hdnstockininvitemid" value="">
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal"><spring:message code="stockinnew.jsp.Cancel" text="Cancel" /></button>
					<button type="button" onclick="javascript:deleteExistingStockInItem()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="stockinnew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="itemupdatedmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockinnew.jsp.Success" text="Success" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="stockinnew.jsp.Itemsuccessfullyupdated" text="Item successfully updated" />.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="stockinnew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="billnodmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockinnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="stockinnew.jsp.Pleaseenterthebillnumber" text="Please enter the bill number" />.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="stockinnew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="tabledatadmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockinnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="stockinnew.jsp.Pleaseenteratleast1itembeforecreatestockin" text="Please enter atleast 1 item before create stockin" />.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="stockinnew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="displayPOPage" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockinnew.jsp.Warning" text="Warning" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="stockinnew.jsp.Savetheunsaveditemsfirst" text="Save the unsaved items first" />.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:viewPurchaseOrderPage()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning"><spring:message code="stockinnew.jsp.CANCEL" text="CANCEL" /></button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="stockinnew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="billdateGreaterdmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockinnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="stockinnew.jsp.BillDateshouldnotbegreaterthanpurchaseReturnDate" text="Bill Date should not be greater than Stock In date" />.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="stockinnew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>

	<!-- new added -->

	<div class="modal fade" data-backdrop="static" id="stockindeletemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockinnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="stockinnew.jsp.Areyousure" text="Are you sure" />?</div>
					<input type="hidden" id="hdnStockinId" value="">
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal"><spring:message code="stockinnew.jsp.Cancel" text="Cancel" /></button>
					<button type="button" onclick="javascript:stockInDelete()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="stockinnew.jsp.OK" text="OK" /></button>
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
	<script src="${pageContext.request.contextPath}/assets/js/purchasereturnScript.js"></script>

	<c:choose>
    <c:when test="${pageContext.response.locale == 'ar'}">
       <script src="${pageContext.request.contextPath}/assets/js/lang/invNewScript_AR.js"></script>
    </c:when>

    <c:otherwise>
     <script src="${pageContext.request.contextPath}/assets/js/lang/invNewScript_EN.js"></script>
    </c:otherwise>
    </c:choose>


	<script type="text/javascript">
	var BASE_URL="${pageContext.request.contextPath}";
	var roundoffflag = "${sessionScope.loggedinStore.roundOffTotalAmtStatus}";
	var returnTypes =[];
	    returnTypes = '<%= session.getAttribute("returnTypesList") %>';
		$(document).ready(function() {
			var hidpurchasereturnsId=$("#hidpurchasereturnsId").val();
 			console.log("hidpurchasereturnsId="+hidpurchasereturnsId);
 			var selectedpurchasereturnid = $("#selectedpurchasereturnid").val();
 			console.log("selectedpurchasereturnid=" + selectedpurchasereturnid);
 			if(undefined!=hidpurchasereturnsId){
 				rowClicked(hidpurchasereturnsId);
 			}else {
 				if(undefined!=selectedpurchasereturnid && selectedpurchasereturnid!=0){
 					rowClicked(selectedpurchasereturnid);
 				}
 				else{
 					$("#PurchaseReturnDelete").addClass('disabled'); // new
 					$("#PurchaseReturnPrint").addClass('disabled'); // new 7.3.2018
 					 setButton();//new
 				}
 			}
			$('#purchaseReturnDate').datepicker({
				format : "yyyy-mm-dd",
				endDate: '+0d',
				autoclose : true
			});

			$('#billDate').datepicker({
				format : "yyyy-mm-dd",
				endDate: '+0d',
				autoclose : true
			});

		});
	</script>
</body>
</html>