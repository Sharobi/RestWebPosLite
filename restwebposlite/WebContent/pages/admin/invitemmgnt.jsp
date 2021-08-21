<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
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
						<div style="color: #FFF; font-size: 16px; font-weight: bold;"><spring:message code="admin.invitemmgnt.jsp.invItem" text="INVENTORY ITEMS" /></div>
					</div>
					<div class="col-md-5 col-sm-5">
						<input type="text" id="invitemSearch" placeholder="SEARCH"> <a href="javascript:loadinvItems(document.getElementById('autocompleteinvItemId').value,0)" class="btn btn-success" style="background: #78B626; margin-bottom: 3px;"><spring:message code="admin.invitemmgnt.jsp.go" text="GO" /></a> <input type="hidden" value="" id="autocompleteinvItemId">
					</div>
					<div class="col-md-2 col-sm-2">
						<a href="javascript:showinvitemaddModal()" class="btn btn-success" style="width: 80px; background: #78B626; margin-bottom: 3px;"><spring:message code="admin.invitemmgnt.jsp.add" text="ADD" /></a>
					</div>
					<div class="col-md-12 col-sm-12">
						<!--   Kitchen Sink -->
						<div style="max-height: 400px; overflow-y: auto;">
							<div class="panel panel-default">

								<div class="panel-body">
									<div class="table-responsive" style="background: #404040;">
										<table class="table table-striped table-bordered table-hover">
											<thead style="background: #404040; color: #FFF;">

												<th style="text-align: center;"><spring:message code="admin.invitemmgnt.jsp.id" text="ID"/></th>
												<th style="text-align: center;"><spring:message code="admin.invitemmgnt.jsp.code" text="CODE" /></th>
												<th style="text-align: center;"><spring:message code="admin.invitemmgnt.jsp.name" text="NAME" /></th>
												<th style="text-align: center;"><spring:message code="admin.invitemmgnt.jsp.edit" text="EDIT" /></th>
												<th style="text-align: center;"><spring:message code="admin.invitemmgnt.jsp.delete" text="DELETE" /></th>
												<th style="text-align: center;"><spring:message code="admin.invitemmgnt.jsp.details" text="DETAILS" /></th>

											</thead>
											<tbody>
												<c:if test="${! empty invitemList }">
													<c:forEach items="${invitemList}" var="invitem">
														<tr style="background: #404040; color: #FFF;">
															<td align="center">${invitem.id}</td>
															<td align="center">${invitem.code}</td>
															<td>${invitem.name}</td>
															<td align="center"><a href="javascript:showinvitemeditModal(${invitem.id},&quot;${invitem.name}&quot;,&quot;${invitem.code}&quot;,${invitem.inventoryType.id},&quot;${invitem.inventoryType.name}&quot;,${invitem.quantity},${invitem.rate},'${invitem.metricUnitId}',${invitem.vendorId},${invitem.shippingCharge},${invitem.dailyRequirement})"> <input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_edit.png"></a></td>
															<td align="center"><a href="javascript:showConfirmdeleteInvItemModal(${invitem.id})"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_delete.png"></a></td>
															<td align="center"><a href="javascript:showDetailInvItemModal(${invitem.id},&quot;${invitem.name}&quot;,&quot;${invitem.code}&quot;,${invitem.inventoryType.id},&quot;${invitem.inventoryType.name}&quot;,${invitem.quantity},${invitem.rate},'${invitem.unit}',${invitem.vendorId},${invitem.shippingCharge},${invitem.dailyRequirement})"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a></td>
														</tr>
													</c:forEach>
												</c:if>
												<c:if test="${empty invitemList}">
													<tr style="background: #404040; color: #FFF;">
														<td colspan="6"><spring:message code="admin.invitemmgnt.jsp.noDataFound" text="No Data found!"/></td>
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
			<!-- modal starts -->
			<div class="modal fade" data-backdrop="static" id="invitemAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="admin.invitemmgnt.jsp.addInvItem" text="Add Inventory Item" /></h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: left; font-size: 20px;">
							<input type="hidden" id="addtax" value="N" />
							<input type="hidden" id="addcallsimpleinventory" value="0">
								<table>
									<tr>
										<td><spring:message code="admin.invitemmgnt.jsp.itemName" text="ITEM NAME" /></td>
										<td>:</td>
										<td style="margin-bottom: 3px;"><input type="text" id="addinvitemnameContId" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td><spring:message code="admin.invitemmgnt.jsp.itemCode" text="ITEM CODE" /><span style="color: #ff0000;">*</span></td>
										<td>:</td>
										<td><input type="text" id="addinvitemcodeContId" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td><spring:message code="admin.invitemmgnt.jsp.all_fields_resuired" text="ITEM TYPE" /></td>
										<td>:</td>
										<td><select id="addinvitemTypeId" style="margin-bottom: 5px; color: #222222;">
												<c:if test="${! empty invTYPEList}">
													<c:forEach items="${invTYPEList}" var="invType">
														<option value="${invType.id}">${invType.name}</option>
													</c:forEach>
												</c:if>
										</select></td>
									</tr>
									<tr>
										<td><spring:message code="admin.invitemmgnt.jsp.itemQty" text="ITEM QUANTITY" /></td>
										<td>:</td>
										<td><input type="text" id="addinvitemqtyContId" value="1" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" disabled="disabled"/></td>
									</tr>
									<tr>
										<td><spring:message code="admin.invitemmgnt.jsp.itemUnit" text="ITEM UNIT" /></td>
										<td>:</td>
										<td>
											<!--                                             			<input type="text" id="addinvitemunitContId" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" /> --> 
											<select id="addinvitemunitContId" style="margin-bottom: 5px; color: #222222;">
												<c:if test="${! empty metricUnitList}">
													<c:forEach items="${metricUnitList}" var="metricunit">
														<option value="${metricunit.id}">${metricunit.unit}</option>
													</c:forEach>
												</c:if>
										   </select>
										</td>
									</tr>
									<tr>
										<td><spring:message code="admin.invitemmgnt.jsp.all_fields_resuired" text="All" /><spring:message code="admin.invitemmgnt.jsp.rate" text="RATE" /><span style="color: #ff0000;">*</span></td>
										<td>:</td>
										<td><input type="text" id="addinvitemrateContId" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>

									<tr>
										<td><spring:message code="admin.invitemmgnt.jsp.all_fields_resuired" text="All" /><spring:message code="admin.invitemmgnt.jsp.vndrType" text="VENDOR TYPE" /></td>
										<td>:</td>
										<td><select id="addinvitemvendorTypeId" style="margin-bottom: 5px; color: #222222;">
												<c:if test="${! empty invVENDORList}">
													<c:forEach items="${invVENDORList}" var="vendor">
														<option value="${vendor.id}">${vendor.name}</option>
													</c:forEach>
												</c:if>
										</select></td>
									</tr>
									<tr>
										<td><spring:message code="admin.invitemmgnt.jsp.all_fields_resuired" text="All" /><spring:message code="admin.invitemmgnt.jsp.shipCharge" text="SHIPPING CHARGE" /></td>
										<td>:</td>
										<td><input type="text" id="addinvitemshippingContId" value="0" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td><spring:message code="admin.invitemmgnt.jsp.all_fields_resuired" text="All" /><spring:message code="admin.invitemmgnt.jsp.dailyReq" text="DAILY REQUIREMENT" /></td>
										<td>:</td>
										<td><input type="text" id="addinvitemdailyreqContId" value="0" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
								</table>
								<div style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;" id="addinvitemalertMsg"></div>
							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #F60; font-weight: bold; width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.invitemmgnt.jsp.cancel" text="CANCEL" /></button>
							<button type="button" onclick="javascript:addInventoryItem()" style="background: #72BB4F; font-weight: bold; width: 25%" class="btn btn-success"><spring:message code="admin.invitemmgnt.jsp.create" text="CREATE" /></button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="invitemEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="admin.invitemmgnt.jsp.editInvItem" text="Edit Inventory Item" /></h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: left; font-size: 20px;">
								<input type="hidden" id="editinvitemidContId" value="">
								<input type="hidden" id="edittax" value="N" />
								<input type="hidden" id="editcallsimpleinventory" value="0">
								<table>
									<tr>
										<td><spring:message code="admin.invitemmgnt.jsp.itemName" text="ITEM NAME" /></td>
										<td>:</td>
										<td style="margin-bottom: 3px;"><input type="text" id="editinvitemnameContId" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td><spring:message code="admin.invitemmgnt.jsp.itemCode" text="ITEM CODE" /></td>
										<td>:</td>
										<td><input type="text" id="editinvitemcodeContId" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td><spring:message code="admin.invitemmgnt.jsp.itemType" text="ITEM TYPE" /></td>
										<td>:</td>
										<td><select id="editinvitemTypeId" style="margin-bottom: 5px; color: #222222;">

										</select></td>
									</tr>
									<tr>
										<td><spring:message code="admin.invitemmgnt.jsp.itemQty" text="ITEM QUANTITY" /></td>
										<td>:</td>
										<td><input type="text" id="editinvitemqtyContId" disabled="disabled" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td><spring:message code="admin.invitemmgnt.jsp.itemUnit" text="ITEM UNIT" /></td>
										<td>:</td>
										<td>
											<!--                                             			<input type="text" id="editinvitemunitContId" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" /> --> <select id="editinvitemunitContId" style="margin-bottom: 5px; color: #222222;">
												<c:if test="${! empty metricUnitList}">
													<c:forEach items="${metricUnitList}" var="metricunit">
														<option value="${metricunit.id}">${metricunit.unit}</option>
													</c:forEach>
												</c:if>
										</select>
										</td>
									</tr>
									<tr>
										<td><spring:message code="admin.invitemmgnt.jsp.all_fields_resuired" text="All" /><spring:message code="admin.invitemmgnt.jsp.rate" text="RATE" /></td>
										<td>:</td>
										<td><input type="text" id="editinvitemrateContId" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>

									<tr>
										<td><spring:message code="admin.invitemmgnt.jsp.all_fields_resuired" text="All" /><spring:message code="admin.invitemmgnt.jsp.vndrType" text="VENDOR TYPE" /></td>
										<td>:</td>
										<td><select id="editinvitemvendorTypeId" style="margin-bottom: 5px; color: #222222;">

										</select></td>
									</tr>
									<tr>
										<td><spring:message code="admin.invitemmgnt.jsp.all_fields_resuired" text="All" /><spring:message code="admin.invitemmgnt.jsp.shipCharge" text="SHIPPING CHARGE" /></td>
										<td>:</td>
										<td><input type="text" id="editinvitemshippingContId" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td><spring:message code="admin.invitemmgnt.jsp.all_fields_resuired" text="All" /><spring:message code="admin.invitemmgnt.jsp.dailyReq" text="DAILY REQUIREMENT" /></td>
										<td>:</td>
										<td><input type="text" id="editinvitemdailyreqContId" style="text-align: left; width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
								</table>
								<div style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;" id="editinvitemalertMsg"></div>
							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" onclick="javascript:cancelInventoryItem()" style="background: #F60; font-weight: bold; width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.invitemmgnt.jsp.cancel" text="CANCEL" /></button>
							<button type="button" onclick="javascript:editInventoryItem()" style="background: #72BB4F; font-weight: bold; width: 25%" class="btn btn-success"><spring:message code="admin.invitemmgnt.jsp.edit" text="EDIT" /></button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="confirmdeleteInvItemModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="admin.invitemmgnt.jsp.confirmation" text="Confirmation!" /></h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<input type="hidden" id="deletecallsimpleinventory" value="0">
							<div style="text-align: center; font-size: 20px;">
								<spring:message code="admin.invitemmgnt.jsp.areYouSure" text="Are you sure?" /> <input type="hidden" id="moddeleteconfirminvitemContId" value="">
							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #F60; font-weight: bold; width: 25%;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.invitemmgnt.jsp.cancel" text="CANCEL" /></button>
							<button type="button" onclick="javascript:deleteInventoryItem()" style="background: #72BB4F; font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.invitemmgnt.jsp.ok" text="OK" /></button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="invitemDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="admin.invitemmgnt.jsp.invItemDetails" text="Inventory Item Details" /></h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div align="center" style="font-size: 20px;">
								<table>
									<tr>
										<td style="padding: 5px 0px;"><spring:message code="admin.invitemmgnt.jsp.itemId" text="ITEM ID" /></td>
										<td width="5%">:</td>
										<td id="moddetailinvitemidTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;"><spring:message code="admin.invitemmgnt.jsp.itemName" text="ITEM NAME" /></td>
										<td width="5%">:</td>
										<td id="moddetailinvitemnameTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;"><spring:message code="admin.invitemmgnt.jsp.itemCode" text="ITEM CODE" /><span style="color: #ff0000;">*</span></td>
										<td width="5%">:</td>
										<td id="moddetailinvitemcodeTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;"><spring:message code="admin.invitemmgnt.jsp.itemType" text="ITEM TYPE" /></td>
										<td width="5%">:</td>
										<td id="moddetailinvitemtypeTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;"><spring:message code="admin.invitemmgnt.jsp.itemQty" text="QUANTITY" /></td>
										<td width="5%">:</td>
										<td id="moddetailinvitemqtyTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;"><spring:message code="admin.invitemmgnt.jsp.itemUnit" text="UNIT" /></td>
										<td width="5%">:</td>
										<td id="moddetailinvitemunitTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;"><spring:message code="admin.invitemmgnt.jsp.rate" text="RATE" /><span style="color: #ff0000;">*</span></td>
										<td width="5%">:</td>
										<td id="moddetailinvitemrateTd"></td>
									</tr>

									<tr>
										<td style="padding: 5px 0px;"><spring:message code="admin.invitemmgnt.jsp.vndrName" text="VENDOR NAME" /></td>
										<td width="5%">:</td>
										<td id="moddetailinvitemvendornameTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;"><spring:message code="admin.invitemmgnt.jsp.shipCharge" text="SHIPPING CHARGE" /></td>
										<td width="5%">:</td>
										<td id="moddetailinvitemshippingTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;"><spring:message code="admin.invitemmgnt.jsp.dailyReq" text="DAILY REQUIREMENT" /></td>
										<td width="5%">:</td>
										<td id="moddetailinvitemdailyreqTd"></td>
									</tr>
								</table>

							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #72BB4F; font-weight: bold; width: 25%" class="btn btn-success" data-dismiss="modal"><spring:message code="admin.invitemmgnt.jsp.ok" text="OK" /></button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="alertnoInvItemFoundModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="admin.invitemmgnt.jsp.alert" text="Alert!" /></h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;"><spring:message code="admin.invitemmgnt.jsp.noInvItemFound" text="No inventory item found!" /></div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #72BB4F; font-weight: bold;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.invitemmgnt.jsp.ok" text="OK" /></button>
						</div>
					</div>
				</div>
			</div>
			
			<div class="modal fade" data-backdrop="static" id="alertinvitemdataopModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.invitemmgnt.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <div id="invitemdataopmassagecont"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="location.href='${pageContext.request.contextPath}/inventorymgnt/loadinvitemmgnt.htm'" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.invitemmgnt.jsp.ok" text="OK" /></button>
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
			$('#invitemAddModal').on('shown.bs.modal', function () {
			$('#addinvitemnameContId').focus();});
		}
		function closeinvitemaddModal() {
			$('#invitemAddModal').modal('hide');
		}
		function showinvitemeditModal(	id,
										name,
										code,
										typeid,
										typename,
										qty,
										rate,
										unit,
										vendorid,
										shipping,
										dailyreq) {
			document.getElementById('editinvitemidContId').value = id;
			document.getElementById('editinvitemnameContId').value = name;
			document.getElementById('editinvitemcodeContId').value = code;
			document.getElementById('editinvitemqtyContId').value = qty;
			document.getElementById('editinvitemrateContId').value = rate;
			document.getElementById('editinvitemunitContId').value = unit;
			document.getElementById('editinvitemshippingContId').value = shipping;
			document.getElementById('editinvitemdailyreqContId').value = dailyreq;
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
										dailyreq) {
			document.getElementById('moddetailinvitemidTd').innerHTML = id;
			document.getElementById('moddetailinvitemnameTd').innerHTML = name;
			document.getElementById('moddetailinvitemcodeTd').innerHTML = code;
			document.getElementById('moddetailinvitemtypeTd').innerHTML = typename;
			document.getElementById('moddetailinvitemqtyTd').innerHTML = qty;
			document.getElementById('moddetailinvitemrateTd').innerHTML = rate;
			document.getElementById('moddetailinvitemunitTd').innerHTML = unit;
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
		function showalertinvitemdataopModal()
		{
			$('#alertinvitemdataopModal').modal('show');
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
	
	<c:choose>
    <c:when test="${pageContext.response.locale == 'ar'}">
       <script src="${pageContext.request.contextPath}/assets/js/lang/adminScript_AR.js"></script>
    </c:when>    
    
    <c:otherwise>
     <script src="${pageContext.request.contextPath}/assets/js/lang/adminScript_EN.js"></script> 
    </c:otherwise>
    </c:choose>
    
    
</body>
</html>
