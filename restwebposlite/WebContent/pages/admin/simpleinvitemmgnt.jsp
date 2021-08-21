<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>:. POS :: Inventory Item Management :.</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
<!-- FONT AWESOME ICONS  -->
<link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/jquery-ui.css" rel="stylesheet" />
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
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="row">
				<jsp:include page="/pages/admin/admleftpanel.jsp"></jsp:include>

				<div class="col-md-10 col-sm-10">
					<div class="col-md-5 col-sm-5">
						<div style="color: #FFF; font-size: 16px; font-weight: bold;">SIMPLE INVENTORY ITEMS</div>
					</div>
					<div class="col-md-5 col-sm-5">
						<input type="text" id="invitemSearch" placeholder="SEARCH"> <a href="javascript:loadinvItems(document.getElementById('autocompleteinvItemId').value,1)" class="btn btn-success" style="background: #78B626; margin-bottom: 3px;">GO</a> <input type="hidden" value="" id="autocompleteinvItemId">
					</div>
					<div class="col-md-2 col-sm-2">
						<a href="javascript:showinvitemaddModal()" class="btn btn-success" style="width: 80px; background: #78B626; margin-bottom: 3px;">ADD</a>
					</div>
					<div class="col-md-12 col-sm-12">
						<!--   Kitchen Sink -->
						<div style="max-height: 400px; overflow-y: auto;">
							<div class="panel panel-default">

								<div class="panel-body">
									<div class="table-responsive" style="background: #404040;">
										<table class="table table-striped table-bordered table-hover">
											<thead style="background: #404040; color: #FFF;">

												<th style="text-align: center;">ID</th>
												<th style="text-align: center;">CODE</th>
												<th style="text-align: center;">NAME</th>
												<th style="text-align: center;">EDIT</th>
												<th style="text-align: center;">DELETE</th>
												<th style="text-align: center;">DETAILS</th>

											</thead>
											<tbody>
												<c:if test="${! empty invitemList }">
													<c:forEach items="${invitemList}" var="invitem">
														<tr style="background: #404040; color: #FFF;">
															<td align="center">${invitem.id}</td>
															<td align="center">${invitem.code}</td>
															<td>${invitem.name}</td>
															<td align="center"><a href="javascript:showinvitemeditModal(${invitem.id},&quot;${invitem.name}&quot;,&quot;${invitem.code}&quot;,${invitem.inventoryType.id},&quot;${invitem.inventoryType.name}&quot;,${invitem.quantity},${invitem.rate},'${invitem.metricUnitId}',${invitem.vendorId},${invitem.shippingCharge},${invitem.dailyRequirement},&quot;${invitem.tax}&quot;,&quot;${invitem.isTaxExclusive}&quot;,${invitem.taxRate})"> <input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_edit.png"></a></td>
															<td align="center"><a href="javascript:showConfirmdeleteInvItemModal(${invitem.id})"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_delete.png"></a></td>
															<td align="center"><a href="javascript:showDetailInvItemModal(${invitem.id},&quot;${invitem.name}&quot;,&quot;${invitem.code}&quot;,${invitem.inventoryType.id},&quot;${invitem.inventoryType.name}&quot;,${invitem.quantity},${invitem.rate},'${invitem.unit}',${invitem.vendorId},${invitem.shippingCharge},${invitem.dailyRequirement},&quot;${invitem.tax}&quot;,&quot;${invitem.isTaxExclusive}&quot;,${invitem.taxRate})"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a></td>
														</tr>
													</c:forEach>
												</c:if>
												<c:if test="${empty invitemList}">
													<tr style="background: #404040; color: #FFF;">
														<td colspan="6">No Data found!</td>
													</tr>
												</c:if>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						<!-- End  Kitchen Sink -->
					</div>
				</div>

			</div>
			
			<div class="modal fade" data-backdrop="static" id="invitemAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="admin.simpleinvitemmgnt.jsp.addSimpleInvItem" text="Add Simple Inventory Item" /></h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: left; font-size: 20px;">
								<input type="hidden" id="addinvitemqtyContId" value="1" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" /> 
								<!-- <input type="hidden" id="addinvitemunitContId" value="1" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" />   -->
								<!-- <input type="hidden" id="addinvitemrateContId" value="0" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" />  -->
								<input type="hidden" id="addinvitemshippingContId" value="0" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" />
								<input type="hidden" id="addinvitemdailyreqContId" value="1" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" />
								<input type="hidden" id="addcallsimpleinventory" value="1">
								<table>
									<tr>
										<td><spring:message code="admin.simpleinvitemmgnt.jsp.name" text="NAME" /></td>
										<td>:</td>
										<td style="margin-bottom: 3px;"><input type="text" id="addinvitemnameContId" style="text-align: left; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td><spring:message code="admin.simpleinvitemmgnt.jsp.code" text="CODE" /><span style="color: #ff0000;">*</span></td>
										<td>:</td>
										<td><input type="text" id="addinvitemcodeContId" style="text-align: left; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td><spring:message code="admin.simpleinvitemmgnt.jsp.type" text="TYPE" /></td>
										<td>:</td>
										<td><select id="addinvitemTypeId" style="margin-bottom: 5px; color: #222222;">
												<c:if test="${! empty invTYPEList}">
													<c:forEach items="${invTYPEList}" var="invType">
														<option value="${invType.id}">${invType.name}</option>
													</c:forEach>
												</c:if>
										</select></td>
									</tr>
									<!-- 									<tr> -->
									<!-- 										<td>ITEM QUANTITY</td> -->
									<!-- 										<td>:</td> -->
									<!-- 										<td><input type="hidden" id="addinvitemqtyContId" value="1" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" /></td> -->
									<!-- 									</tr> -->
																		<tr>
																			<td><spring:message code="admin.simpleinvitemmgnt.jsp.itemUnit" text="ITEM UNIT" /></td>
																			<td>:</td>
																			<td>
 																			<!-- <input type="text" id="addinvitemunitContId" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" />  -->
																			<select id="addinvitemunitContId" style="margin-bottom: 5px; color: #222222;">
																					<c:if test="${! empty metricUnitList}">
																						<c:forEach items="${metricUnitList}" var="metricunit">
																							<option value="${metricunit.id}">${metricunit.unit}</option>
																						</c:forEach>
																					</c:if>
																			</select>
																			</td>
																		</tr>
																		 <tr> <!-- opened 19th April 2018 -->
																			<td><spring:message code="admin.simpleinvitemmgnt.jsp.rate" text="RATE" /><span style="color: #ff0000;">*</span></td> 
																			<td>:</td> 
 																			<td><input type="text" id="addinvitemrateContId" style="text-align: left; color: #222222; margin-bottom: 5px;" /></td>
																		</tr>  

									<tr>
										<td><spring:message code="admin.simpleinvitemmgnt.jsp.vendor" text="VENDOR" /></td>
										<td>:</td>
										<td><select id="addinvitemvendorTypeId" style="margin-bottom: 5px; color: #222222;">
												<c:if test="${! empty invVENDORList}">
													<c:forEach items="${invVENDORList}" var="vendor">
														<option value="${vendor.id}">${vendor.name}</option>
													</c:forEach>
												</c:if>
										</select></td>
									</tr>
									<!-- 									<tr> -->
									<!-- 										<td>SHIPPING CHARGE</td> -->
									<!-- 										<td>:</td> -->
									<!-- 										<td><input type="text" id="addinvitemshippingContId" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" /></td> -->
									<!-- 									</tr> -->
									<!-- 									<tr> -->
									<!-- 										<td>DAILY REQUIREMENT</td> -->
									<!-- 										<td>:</td> -->
									<!-- 										<td><input type="text" id="addinvitemdailyreqContId" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" /></td> -->
									<!-- 									</tr> -->

									<tr>
										<td><spring:message code="admin.simpleinvitemmgnt.jsp.tax" text="TAX" /></td>
										<td>:</td>
										<td><select id="addtax" style="margin-bottom: 5px; color: #222222;" onchange="managetaxdiv(this.value);">
										        <option value="SELECT"><spring:message code="admin.simpleinvitemmgnt.jsp.select" text="SELECT" /></option>
												<option value="Y"><spring:message code="admin.simpleinvitemmgnt.jsp.yes" text="YES" /></option>
												<option value="N"><spring:message code="admin.simpleinvitemmgnt.jsp.no" text="NO" /></option>
										</select></td>
									</tr>
									
									<tr id="taxexclusivetr" style="display:none;">
										<td><spring:message code="admin.simpleinvitemmgnt.jsp.taxexclusive" text="TAX EXCLUSIVE"/></td>
										<td>:</td>
										<td><select id="addinvitemttaxexclusive" style="margin-bottom: 5px; color: #222222;">
												<option value="Y"><spring:message code="admin.simpleinvitemmgnt.jsp.yes" text="YES" /></option>
												<option value="N"><spring:message code="admin.simpleinvitemmgnt.jsp.no" text="NO" /></option>
										</select></td>
									</tr>
									 <tr id="taxperctr" style="display:none;"> 
										<td><spring:message code="admin.simpleinvitemmgnt.jsp.taxperc" text="TAX(%)"/></td> 
										<td>:</td> 
 									    <td><input type="text" id="addinvitemtaxpercentage" style="text-align: left; width: 50%; color: #222222; margin-bottom: 5px;" /></td>
									</tr> 
								</table>
								<div style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;" id="addinvitemalertMsg"></div>
							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #F60; font-weight: bold; width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.simpleinvitemmgnt.jsp.cancel" text="CANCEL" /></button>
							<button type="button" onclick="javascript:addInventoryItem()" style="background: #72BB4F; font-weight: bold; width: 25%" class="btn btn-success"><spring:message code="admin.simpleinvitemmgnt.jsp.create" text="CREATE" /></button>
						</div>
					</div>
				</div>
			</div>

			
 
 <div class="modal fade" data-backdrop="static" id="invitemEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="admin.simpleinvitemmgnt.jsp.editSimpleInvItem" text="Edit Simple Inventory Item" /></h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: left; font-size: 20px;">
								<input type="hidden" id="editinvitemidContId" value="">
								<input type="hidden" id="editcallsimpleinventory" value="1">
								<table>
									<tr>
										<td><spring:message code="admin.simpleinvitemmgnt.jsp.name" text="NAME" /></td>
										<td>:</td>
										<td style="margin-bottom: 3px;"><input type="text" id="editinvitemnameContId" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td><spring:message code="admin.simpleinvitemmgnt.jsp.code" text="CODE" /></td>
										<td>:</td>
										<td><input type="text" id="editinvitemcodeContId" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td><spring:message code="admin.simpleinvitemmgnt.jsp.type" text="TYPE" /></td>
										<td>:</td>
										<td><select id="editinvitemTypeId" style="margin-bottom: 5px; color: #222222;">

										</select></td>
									</tr>
									<!-- 									<tr> -->
									<!-- 										<td>ITEM QUANTITY</td> -->
									<!-- 										<td>:</td> -->
									<!-- 										<td><input type="text" id="editinvitemqtyContId" disabled="disabled" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" /></td> -->
									<!-- 									</tr> -->
									 <input type="hidden" id="editinvitemqtyContId" disabled="disabled" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" />
																		<tr>
																			<td><spring:message code="admin.simpleinvitemmgnt.jsp.itemUnit" text="ITEM UNIT" /></td>
																			<td>:</td>
																			<td>
                                   <!--  <input type="text" id="editinvitemunitContId" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" />  --> <!-- off in 19th april 2018 -->
																			<select id="editinvitemunitContId" style="margin-bottom: 5px; color: #222222;">
																					<c:if test="${! empty metricUnitList}">
																						<c:forEach items="${metricUnitList}" var="metricunit">
																							<option value="${metricunit.id}">${metricunit.unit}</option>
																						</c:forEach>
																					</c:if>
																			</select>
																			</td>
																		</tr>
									 <!-- <input type="hidden" id="editinvitemunitContId" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" /> --> <!-- off in 19th april 2018 -->
																		 <tr> <!-- opened in 19th April 2018 -->
																			<td><spring:message code="admin.simpleinvitemmgnt.jsp.rate" text="RATE" /></td>
																			<td>:</td>
 																			<td><input type="text" id="editinvitemrateContId" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" /></td>
																		</tr>
									 <!-- <input type="hidden" id="editinvitemrateContId" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" />  --> <!-- off in 19th april 2018 -->
									<tr>
										<td><spring:message code="admin.simpleinvitemmgnt.jsp.vendor" text="VENDOR" /></td>
										<td>:</td>
										<td><select id="editinvitemvendorTypeId" style="margin-bottom: 5px; color: #222222;">

										</select></td>
									</tr>
									<!-- 									<tr> -->
									<!-- 										<td>SHIPPING CHARGE</td> -->
									<!-- 										<td>:</td> -->
									<!-- 										<td><input type="text" id="editinvitemshippingContId" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" /></td> -->
									<!-- 									</tr> -->
									 <input type="hidden" id="editinvitemshippingContId" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" /> 
									<!-- 									<tr> -->
									<!-- 										<td>DAILY REQUIREMENT</td> -->
									<!-- 										<td>:</td> -->
									<!-- 										<td><input type="text" id="editinvitemdailyreqContId" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" /></td> -->
									<!-- 									</tr> -->
									 <input type="hidden" id="editinvitemdailyreqContId" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" /> 
									<tr>
										<td><spring:message code="admin.simpleinvitemmgnt.jsp.tax" text="TAX" /></td>
										<td>:</td>
										<td><select id="edittax" style="margin-bottom: 5px; color: #222222;" onchange="manageedittaxdiv(this.value);">
										          <option value="SELECT"><spring:message code="admin.simpleinvitemmgnt.jsp.select" text="SELECT" /></option>
												<option value="Y" ><spring:message code="admin.simpleinvitemmgnt.jsp.yes" text="YES" /></option>
													<option value="N"><spring:message code="admin.simpleinvitemmgnt.jsp.no" text="NO" /></option>
										</select></td>
									</tr>
                                    <!--  <tr id="edittaxperctr"> 
																			<td>TAX %</td> 
																			<td>:</td> 
 																			<td><input type="text" id="editinvitemtaxpercentage" style="text-align: left; width: 50%; color: #222222; margin-bottom: 5px;" /></td>
																		</tr> -->
																		
										<tr id="edittaxisexclusivetr" style="display:none;">
										<td><spring:message code="admin.simpleinvitemmgnt.jsp.taxexclusive" text="TAX EXCLUSIVE"/></td>
										<td>:</td>
										<td><select id="editinvitemttaxexclusive" style="margin-bottom: 5px; color: #222222;">
												<option value="Y"><spring:message code="admin.simpleinvitemmgnt.jsp.yes" text="YES" /></option>
												<option value="N"><spring:message code="admin.simpleinvitemmgnt.jsp.no" text="NO" /></option>
										</select></td>
									</tr>
									 <tr id="edittaxperctr" style="display:none;"> 
										<td><spring:message code="admin.simpleinvitemmgnt.jsp.taxperc" text="TAX(%)"/></td> 
										<td>:</td> 
 									    <td><input type="text" id="editinvitemtaxpercentage" style="text-align: left; width: 50%; color: #222222; margin-bottom: 5px;" /></td>
									</tr> 								
																		
																		
																		
																		
																		
																		
																		  
								</table>
								<div style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;" id="editinvitemalertMsg"></div>
							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" onclick="javascript:cancelInventoryItem() style="background: #F60; font-weight: bold; width: 25%;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.simpleinvitemmgnt.jsp.cancel" text="CANCEL" /></button>
							<button type="button" onclick="javascript:editInventoryItem()" style="background: #72BB4F; font-weight: bold; width: 25%" class="btn btn-success"><spring:message code="admin.simpleinvitemmgnt.jsp.edit" text="EDIT" /></button>
						</div>
					</div>
				</div>
			</div>
 
 
 
 
 
 
 
			<div class="modal fade" data-backdrop="static" id="confirmdeleteInvItemModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Confirmation!</h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<input type="hidden" id="deletecallsimpleinventory" value="1">
							<div style="text-align: center; font-size: 20px;">
								Are you sure? <input type="hidden" id="moddeleteconfirminvitemContId" value="">
							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #F60; font-weight: bold; width: 25%;" class="btn btn-warning" data-dismiss="modal">CANCEL</button>
							<button type="button" onclick="javascript:deleteInventoryItem()" style="background: #72BB4F; font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="invitemDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Simple Inventory Item Details</h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div align="center" style="font-size: 20px;">
								<table>
									<tr>
										<td style="padding: 5px 0px;">ITEM ID</td>
										<td width="5%">:</td>
										<td id="moddetailinvitemidTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;">ITEM NAME</td>
										<td width="5%">:</td>
										<td id="moddetailinvitemnameTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;">ITEM CODE</td>
										<td width="5%">:</td>
										<td id="moddetailinvitemcodeTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;">ITEM TYPE</td>
										<td width="5%">:</td>
										<td id="moddetailinvitemtypeTd"></td>
									</tr>
									<tr style="display: none;">
										<td style="padding: 5px 0px;">QUANTITY</td>
										<td width="5%">:</td>
										<td id="moddetailinvitemqtyTd"></td>
									</tr>
									<tr >
										<td style="padding: 5px 0px;">UNIT</td>
										<td width="5%">:</td>
										<td id="moddetailinvitemunitTd"></td>
									</tr>
									<tr style="display: none;">
										<td style="padding: 5px 0px;">RATE</td>
										<td width="5%">:</td>
										<td id="moddetailinvitemrateTd"></td>
									</tr>

									<tr>
										<td style="padding: 5px 0px;">VENDOR NAME</td>
										<td width="5%">:</td>
										<td id="moddetailinvitemvendornameTd"></td>
									</tr>
									<tr style="display: none;">
										<td style="padding: 5px 0px;">SHIPPING CHARGE</td>
										<td width="5%">:</td>
										<td id="moddetailinvitemshippingTd"></td>
									</tr>
									<tr style="display: none;">
										<td style="padding: 5px 0px;">DAILY REQUIREMENT</td>
										<td width="5%">:</td>
										<td id="moddetailinvitemdailyreqTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;">Tax</td>
										<td width="5%">:</td>
										<td id="moddetailinvitemtax"></td>
									</tr>
								</table>

							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #72BB4F; font-weight: bold; width: 25%" class="btn btn-success" data-dismiss="modal">OK</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="alertnoInvItemFoundModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert!</h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">No inventory item found!</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #72BB4F; font-weight: bold;" data-dismiss="modal" class="btn btn-success">OK</button>
						</div>
					</div>
				</div>
			</div>
			<div class="modal fade" data-backdrop="static" id="alertsimpleinvitemdataopModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.simpleinvitemmgnt.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <div id="simpleinvitemdataopmassagecont"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="location.href='${pageContext.request.contextPath}/inventorymgnt/loadsimpleinvitemmgnt.htm'" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.simpleinvitemmgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
			
			<!-- modal ends -->

		</div>
	</div>
	<!-- CONTENT-WRAPPER SECTION END-->

	<!-- FOOTER SECTION END-->
	<!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
	<script src="${pageContext.request.contextPath}/assets/js/adminScript.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
	<!-- CORE JQUERY SCRIPTS -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
	<!-- BOOTSTRAP SCRIPTS  -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>

	<script type="text/javascript">
		var BASE_URL = "${pageContext.request.contextPath}";

		function showinvitemaddModal() {
			$('#invitemAddModal').modal('show');
		}
		function closeinvitemaddModal() {
			$('#invitemAddModal').modal('hide');
		}
		
function showinvitemeditModal( id,
				name,
				code,
				typeid,
				typename,
				qty,
				rate,
				unit,
				vendorid,
				shipping,
				dailyreq,
				tax,
				isexclusive,
				taxrate) {
document.getElementById('editinvitemidContId').value = id;
document.getElementById('editinvitemnameContId').value = name;
document.getElementById('editinvitemcodeContId').value = code;
document.getElementById('editinvitemqtyContId').value = qty;
document.getElementById('editinvitemrateContId').value = rate;
document.getElementById('editinvitemunitContId').value = unit;
document.getElementById('editinvitemshippingContId').value = shipping;
document.getElementById('editinvitemdailyreqContId').value = dailyreq;
document.getElementById('edittax').value = tax;
if(tax == 'Y'){
document.getElementById("edittaxperctr").style.display = "table-row";
document.getElementById("edittaxisexclusivetr").style.display = "table-row";
document.getElementById('editinvitemtaxpercentage').value = taxrate;
document.getElementById('editinvitemttaxexclusive').value = isexclusive;
}
else{
document.getElementById("edittaxperctr").style.display = "none";
document.getElementById("edittaxisexclusivetr").style.display = "none";
document.getElementById('editinvitemtaxpercentage').value = "0.0";
document.getElementById('editinvitemttaxexclusive').value = "Y";

} 
//document.getElementById('editvendorcreateddateContId').value=crdate;
var typeoption = "";
var typeoption1 = "";
var typeidarray = [];
var typenamearray = [];
var vendoroption = "";
var vendoroption1 = "";
var vendoridarray = [];
var vendornamearray = [];
var vendorname = "";
<c:forEach items="${invTYPEList}" var="invtype" varStatus="loop">
typeidarray.push('${invtype.id}');
typenamearray.push('${invtype.name}');
</c:forEach>
//alert(typearray);  
typeoption = "<option value='"+typeid+"'>" + typename + "</option>";
for ( var i = 0; i < typeidarray.length; i++) {
if (typeidarray[i] != typeid) {
typeoption1 += "<option value='"+typeidarray[i]+"'>" + typenamearray[i] + "</option>";
}
}
var typeoptionfinal = typeoption + typeoption1;
document.getElementById('editinvitemTypeId').innerHTML = typeoptionfinal;

<c:forEach items="${invVENDORList}" var="vendor" varStatus="loop">
vendoridarray.push('${vendor.id}');
vendornamearray.push('${vendor.name}');
</c:forEach>
for ( var i = 0; i < vendoridarray.length; i++) {
if (vendoridarray[i] == vendorid) {
vendorname = vendornamearray[i];
}
}
vendoroption = "<option value='"+vendorid+"'>" + vendorname + "</option>";
for ( var i = 0; i < vendoridarray.length; i++) {
if (vendoridarray[i] != vendorid) {
vendoroption1 += "<option value='"+vendoridarray[i]+"'>" + vendornamearray[i] + "</option>";
}
}
var vendoroptionfinal = vendoroption + vendoroption1;
document.getElementById('editinvitemvendorTypeId').innerHTML = vendoroptionfinal;
$('#invitemEditModal').modal('show');
}


function closeinvitemeditModal() {
$('#invitemEditModal').modal('hide');
}
function showConfirmdeleteInvItemModal(id) {
document.getElementById('moddeleteconfirminvitemContId').value = id;
$('#confirmdeleteInvItemModal').modal('show');
}
		
		
function closeinvitemeditModal() {
			$('#invitemEditModal').modal('hide');
		}
function showConfirmdeleteInvItemModal(id) {
			document.getElementById('moddeleteconfirminvitemContId').value = id;
			$('#confirmdeleteInvItemModal').modal('show');
		}
		function showDetailInvItemModal(id,
										name,
										code,
										typeid,
										typename,
										qty,
										rate,
										unit,
										vendorid,
										shipping,
										dailyreq,
										tax) {
			document.getElementById('moddetailinvitemidTd').innerHTML = id;
			document.getElementById('moddetailinvitemnameTd').innerHTML = name;
			document.getElementById('moddetailinvitemcodeTd').innerHTML = code;
			document.getElementById('moddetailinvitemtypeTd').innerHTML = typename;
			document.getElementById('moddetailinvitemqtyTd').innerHTML = qty;
			document.getElementById('moddetailinvitemrateTd').innerHTML = rate;
			document.getElementById('moddetailinvitemunitTd').innerHTML = unit;
			document.getElementById('moddetailinvitemtax').innerHTML = tax;
			var vendoridarray = [];
			var vendornamearray = [];
			var vendorname = "";
			<c:forEach items="${invVENDORList}" var="vendor" varStatus="loop">
			vendoridarray.push('${vendor.id}');
			vendornamearray.push('${vendor.name}');
			</c:forEach>
			for ( var i = 0; i < vendoridarray.length; i++) {
				if (vendoridarray[i] == vendorid) {
					vendorname = vendornamearray[i];
				}
			}
			document.getElementById('moddetailinvitemvendornameTd').innerHTML = vendorname;
			document.getElementById('moddetailinvitemshippingTd').innerHTML = shipping;
			document.getElementById('moddetailinvitemdailyreqTd').innerHTML = dailyreq;
			$('#invitemDetailModal').modal('show');
		}
		function showalertnoInvItemFoundModal() {
			$('#alertnoInvItemFoundModal').modal('show');
		}
	</script>
	<script type="text/javascript">
		$(function() {
			$("#invitemSearch").autocomplete({
				source : function(	request,
									response) {
					$.ajax({
						url : "${pageContext.request.contextPath}/inventorymgnt/autocomplete.htm",
						type : "GET",
						data : {
							tagName : request.term
						},

						dataType : "json",

						success : function(data) {
							response($.map(data, function(v) {

								return {
									label : v.name,

									itemCode : v.id,
								//tagCode : v.tagCode
								};

							}));
						},
						error : function(error) {
							alert('error: ' + error);
						}
					});
				},
				select : function(	e,
									ui) {

					// $("#itemCode").val(ui.item.itemCode);
					$("#autocompleteinvItemId").val(ui.item.itemCode);

				}
			});
		});
	</script>
	<script>
	  function managetaxdiv(value){ //added new
		if(value == 'Y'){
			document.getElementById("taxperctr").style.display = "table-row";
			document.getElementById("taxexclusivetr").style.display = "table-row";
			
		}
		else{
			document.getElementById("taxperctr").style.display = "none";
			document.getElementById("taxexclusivetr").style.display = "none";
			document.getElementById("addinvitemtaxpercentage").value = "0.0";
		}
		
		
	}  
	
	function manageedittaxdiv(value){//added new
		if(value == 'Y'){
			document.getElementById("edittaxperctr").style.display = "table-row";
			document.getElementById("edittaxisexclusivetr").style.display = "table-row";
			
		}
		else{
			document.getElementById("edittaxperctr").style.display = "none";
			document.getElementById("edittaxisexclusivetr").style.display = "none";
			document.getElementById("editinvitemtaxpercentage").value = "0.0";
		}
		
		
		
	}
	function showalertsimpleinvitemdataopModal()
	{
		$('#alertsimpleinvitemdataopModal').modal('show');
	}
	</script>
</body>
</html>
