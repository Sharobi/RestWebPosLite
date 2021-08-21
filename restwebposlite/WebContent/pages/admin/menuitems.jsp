<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<title>:. POS :: Menu Items :.</title>
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

				<div class="col-md-10 col-sm-10" id="menumgntContainerId">
					<div class="col-md-5 col-sm-5">
						<div style="color: #FFF; font-size: 16px; font-weight: bold;">MENU ITEMS</div>
					</div>
					<div class="col-md-5 col-sm-5">
						<input type="text" id="itemSearch" placeholder="SEARCH"> <a href="javascript:loadmenuItems(document.getElementById('autocompleteItemId').value)" class="btn btn-success" style="background: #78B626; margin-bottom: 3px;">GO</a> <input type="hidden" value="" id="autocompleteItemId">
					</div>
					<div class="col-md-2 col-sm-2">
						<a href="javascript:shownmenuitemsaddModal()" class="btn btn-success" style="width: 80px; background: #78B626; margin-bottom: 3px;">ADD</a>
					</div>
					<div class="col-md-12 col-sm-12">
						<!--   Kitchen Sink -->
						<div style="max-height: 450px; overflow-y: auto;">
							<div class="panel panel-default">

								<div class="panel-body">
									<div class="table-responsive" style="background: #404040;">
										<table class="table table-striped table-bordered table-hover">
											<thead style="background: #404040; color: #FFF;">

												<th style="text-align: center;">ID</th>
												<th style="text-align: center;">NAME</th>
												<th style="text-align: center;">RATE</th>
												<th style="text-align: center;">SPL NOTE</th>
												<th style="text-align: center;">EDIT</th>
												<th style="text-align: center;">DELETE</th>
												<th style="text-align: center;">DETAILS</th>
												<!-- <th style="text-align:center;">ACTION</th> -->
												<th style="text-align: center;">MENU CATEGORY</th>
												<th style="text-align: center;">SUB CATEGORY</th>
												<th style="text-align: center;">IMAGE</th>
												<c:if test="${sessionScope.loggedinStore.kotPrintType=='item'}">
													<th style="text-align: center;">KOT PRINTER</th>
												</c:if>
											</thead>
											<!-- </table>
                                    <div style="max-height: 400px;overflow-y:auto;"> 
                                    <table class="table table-striped table-bordered table-hover" style="table-layout: fixed;">-->
											<tbody>
												<c:if test="${! empty allmenuTree }">
													<c:forEach items="${allmenuTree.menucategory}" var="menucategory">
														<c:forEach items="${menucategory.menucategory}" var="menusubcategory">
															<c:forEach items="${menusubcategory.items}" var="menuitems">
																<tr style="background: #404040; color: #FFF;">
																	<td align="center">${menuitems.id}</td>
																	<td>${menuitems.name}</td>
																	<td align="center"><fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${menuitems.price}"></fmt:formatNumber></td>
																	<td align="center"><c:if test="${! fn:containsIgnoreCase(menucategory.menuCategoryName, 'SPECIAL NOTE') }">
																			<a href="javascript:clickonmenuItems(${menuitems.id},&quot;${menuitems.name}&quot;)" class="btn btn-success">SPL NOTE</a>
																		</c:if></td>
																	<%-- <td align="center"><a href="javascript:shownmenuitemseditModal(${menucategory.id},&quot;${menucategory.menuCategoryName}&quot;,${menusubcategory.id},&quot;${menusubcategory.menuCategoryName}&quot;,${menuitems.id},&quot;${menuitems.name}&quot;,&quot;${menuitems.description}&quot;,${menuitems.price},${menuitems.vat},${menuitems.serviceTax},'${menuitems.veg}','${menuitems.spicy}','${menuitems.promotionFlag}',&quot;${menuitems.promotionDesc}&quot;,${menuitems.promotionValue},${menuitems.cookingTimeInMins},'${menuitems.production}','${menuitems.unit}')"> <input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_edit.png"></a></td>
																	<td align="center"><a href="javascript:showConfirmdeleteMenuItemsModal(${menusubcategory.id},${menuitems.id})"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_delete.png"></a></td>
																	<td align="center"><a href="javascript:shownmenuitemsdetailModal(${menucategory.id},&quot;${menucategory.menuCategoryName}&quot;,${menusubcategory.id},&quot;${menusubcategory.menuCategoryName}&quot;,${menuitems.id},&quot;${menuitems.name}&quot;,&quot;${menuitems.description}&quot;,${menuitems.price},${menuitems.vat},${menuitems.serviceTax},'${menuitems.veg}','${menuitems.spicy}','${menuitems.promotionFlag}',&quot;${menuitems.promotionDesc}&quot;,${menuitems.promotionValue},${menuitems.cookingTimeInMins},'${menuitems.production}','${menuitems.unit}')"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a></td> --%>
																	<td align="center"><a href="javascript:shownmenuitemseditModal(${menucategory.id},&quot;${menucategory.menuCategoryName}&quot;,${menusubcategory.id},&quot;${menusubcategory.menuCategoryName}&quot;,${menuitems.id},&quot;${menuitems.name}&quot;,&quot;${menuitems.description}&quot;,${menuitems.price},${menuitems.vat},${menuitems.serviceTax},'${menuitems.veg}','${menuitems.spicy}','${menuitems.promotionFlag}',&quot;${menuitems.promotionDesc}&quot;,${menuitems.promotionValue},${menuitems.cookingTimeInMins},'${menuitems.production}','${menuitems.unit}','${menuitems.spotDiscount}',&quot;${menuitems.code}&quot;)"> <input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_edit.png"></a></td>
                                           					        <td align="center"><a href="javascript:showConfirmdeleteMenuItemsModal(${menusubcategory.id},${menuitems.id})"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_delete.png"></a></td>
                                            				        <td align="center"><a href="javascript:shownmenuitemsdetailModal(${menucategory.id},&quot;${menucategory.menuCategoryName}&quot;,${menusubcategory.id},&quot;${menusubcategory.menuCategoryName}&quot;,${menuitems.id},&quot;${menuitems.name}&quot;,&quot;${menuitems.description}&quot;,${menuitems.price},${menuitems.vat},${menuitems.serviceTax},'${menuitems.veg}','${menuitems.spicy}','${menuitems.promotionFlag}',&quot;${menuitems.promotionDesc}&quot;,${menuitems.promotionValue},${menuitems.cookingTimeInMins},'${menuitems.production}','${menuitems.unit}','${menuitems.spotDiscount}',&quot;${menuitems.code}&quot;)"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a></td>
                                            				
																	<%-- <td align="center">
                                            				<c:if test="${fn:containsIgnoreCase(menuitems.production, 'Y') }">
                                            					<a href="javascript:disableMenuItems(${menucategory.id},'${menucategory.menuCategoryName}',${menusubcategory.id},'${menusubcategory.menuCategoryName}',${menuitems.id},'${menuitems.name}','${menuitems.description}',${menuitems.price},${menuitems.vat},${menuitems.serviceTax},'${menuitems.veg}','${menuitems.spicy}','${menuitems.promotionFlag}','${menuitems.promotionDesc}',${menuitems.promotionValue},'N')" id="updatemenuitemsbut${menuitems.id}" class="btn-unpaid-order" style="background: #E0B12F;">DISABLE</a>
                                            				</c:if>
                                            				<c:if test="${fn:containsIgnoreCase(menuitems.production, 'N') }">
                                            					<a href="javascript:enableMenuItems(${menucategory.id},'${menucategory.menuCategoryName}',${menusubcategory.id},'${menusubcategory.menuCategoryName}',${menuitems.id},'${menuitems.name}','${menuitems.description}',${menuitems.price},${menuitems.vat},${menuitems.serviceTax},'${menuitems.veg}','${menuitems.spicy}','${menuitems.promotionFlag}','${menuitems.promotionDesc}',${menuitems.promotionValue},'Y')" id="updatemenuitemsbut${menuitems.id}" class="btn-unpaid-order">ENABLE</a>
                                            				</c:if>
                                            				</td> --%>
																	<td align="center">${menucategory.menuCategoryName}</td>
																	<td align="center">${menusubcategory.menuCategoryName}</td>
																	<td align="center"><a href="javascript:openUploadImageModal(${menuitems.id},&quot;${menuitems.name}&quot;)" class="btn btn-success">Upload Image</a></td>
																	<c:if test="${sessionScope.loggedinStore.kotPrintType=='item'}">
																		<td align="center"><c:if test="${! fn:containsIgnoreCase(menucategory.menuCategoryName, 'SPECIAL NOTE') }">
																				<a href="javascript:showItemKOTPrinterModal(${menuitems.id},&quot;${menuitems.name}&quot;)"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_tprinter.png"></a>
																				<input type="hidden" id="hidprevprinterlist_${menuitems.id}" value="${menuitems.printerList}" />
																			</c:if></td>
																	</c:if>
																</tr>
															</c:forEach>
														</c:forEach>
													</c:forEach>
												</c:if>
												<c:if test="${!empty singleMenuItem}">
													<tr style="background: #404040; color: #FFF;">
														<td align="center">${singleMenuItem.id}</td>
														<td>${singleMenuItem.name}</td>
														<td align="center"><fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${singleMenuItem.price}"></fmt:formatNumber></td>
														<td align="center"><c:if test="${! fn:containsIgnoreCase(singleMenuItem.menucatName, 'SPECIAL NOTE') }">
																<a href="javascript:clickonmenuItems(${singleMenuItem.id},&quot;${singleMenuItem.name}&quot;)" class="btn btn-success">SPL NOTE</a>
															</c:if></td>
														<td align="center"><a href="javascript:shownmenuitemseditModal(${singleMenuItem.menucatId},&quot;${singleMenuItem.menucatName}&quot;,${singleMenuItem.submenucatId},&quot;${singleMenuItem.submenucatName}&quot;,${singleMenuItem.id},&quot;${singleMenuItem.name}&quot;,&quot;${singleMenuItem.description}&quot;,${singleMenuItem.price},${singleMenuItem.vat},${singleMenuItem.serviceTax},'${singleMenuItem.veg}','${singleMenuItem.spicy}','${singleMenuItem.promotionFlag}',&quot;${singleMenuItem.promotionDesc}&quot;,${singleMenuItem.promotionValue},${singleMenuItem.cookingTimeInMins},'${singleMenuItem.production}','${singleMenuItem.unit}','${singleMenuItem.spotDiscount}',&quot;${singleMenuItem.code}&quot;,${singleMenuItem.purchasePrice},&quot;${singleMenuItem.packaged}&quot;)"> <input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_edit.png"></a></td>
														<td align="center"><a href="javascript:showConfirmdeleteMenuItemsModal(${singleMenuItem.submenucatId},${singleMenuItem.id})"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_delete.png"></a></td>
														<td align="center"><a href="javascript:shownmenuitemsdetailModal(${singleMenuItem.menucatId},&quot;${singleMenuItem.menucatName}&quot;,${singleMenuItem.submenucatId},&quot;${singleMenuItem.submenucatName}&quot;,${singleMenuItem.id},&quot;${singleMenuItem.name}&quot;,&quot;${singleMenuItem.description}&quot;,${singleMenuItem.price},${singleMenuItem.vat},${singleMenuItem.serviceTax},'${singleMenuItem.veg}','${singleMenuItem.spicy}','${singleMenuItem.promotionFlag}',&quot;${singleMenuItem.promotionDesc}&quot;,${singleMenuItem.promotionValue},${singleMenuItem.cookingTimeInMins},'${singleMenuItem.production}','${singleMenuItem.unit}','${singleMenuItem.spotDiscount}',&quot;${singleMenuItem.code}&quot;,${singleMenuItem.purchasePrice})"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a></td>
														<td align="center">${singleMenuItem.menucatName}</td>
														<td align="center">${singleMenuItem.submenucatName}</td>
														<td></td>
														<c:if test="${sessionScope.loggedinStore.kotPrintType=='item'}">
															<td align="center"><c:if test="${! fn:containsIgnoreCase(singleMenuItem.menucatName, 'SPECIAL NOTE') }">
																	<a href="javascript:showItemKOTPrinterModal(${singleMenuItem.id},&quot;${singleMenuItem.name}&quot;,&quot;${singleMenuItem.printerList}&quot;)"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_tprinter.png"></a>
																	<input type="hidden" id="hidprevprinterlist_${singleMenuItem.id}" value="${singleMenuItem.printerList}" />
																</c:if></td>
														
														</c:if>
													</tr>
												</c:if>
											</tbody>
										</table>
										<!-- </div> -->
									</div>
								</div>
							</div>
						</div>
						<!-- End  Kitchen Sink -->
					</div>
				</div>

			</div>
			<div id="specialnoteContainerId"></div>
			<!-- modal starts -->
			<div class="modal fade" data-backdrop="static" id="menuitemAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Add Menu Item</h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: left; font-size: 18px;">

								<table>
									<tr>
										<td>CATEGORY NAME</td>
										<td>:</td>
										<td><select id="menucategoryId" onchange="javascript:selectCatValue(this.value)" style="margin-bottom: 2px; color: #222222;">
												<c:if test="${! empty menucatList}">
													<c:forEach items="${menucatList}" var="menucat">
														<option value="${menucat.id}~${menucat.menuCategoryName}">${menucat.menuCategoryName}</option>
													</c:forEach>
												</c:if>
												<%-- <c:if test="${! empty allmenuTreeforSingle}">
                                            						<c:forEach items="${allmenuTreeforSingle.menucategory}" var="menucat">
                                            						<option value="${menucat.id}">${menucat.menuCategoryName}</option>
                                            						</c:forEach> 
                                            						
                                            					</c:if>  --%>
										</select></td>
									</tr>
									<tr>
										<td>SUB CATEGORY NAME</td>
										<td>:</td>
										<td><select id="menusubcategoryId" style="margin-bottom: 2px; color: #222222;">
												<c:if test="${! empty menusubcatList}">
													<c:forEach items="${menusubcatList}" var="menusubcat">

														<option value="${menusubcat.id}">${menusubcat.menuCategoryName}</option>


													</c:forEach>
												</c:if>
												<%-- <c:if test="${! empty allmenuTreeforSingle}">
                                            					<c:forEach items="${allmenuTreeforSingle.menucategory}" var="menucat" end="0">
                                            						<c:forEach items="${menucat.menucategory}" var="menusubcat">
                                            							<option value="${menusubcat.id}">${menusubcat.menuCategoryName}</option>
                                            						</c:forEach>
                                            						
                                            					</c:forEach>
                                            					</c:if>  --%>
										</select></td>
									</tr>
									<tr>
										<td>ITEM NAME</td>
										<td>:</td>
										<td><input type="text" id="modaddmenuitemsName" value="" style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
									</tr>
									<tr>
										<td>ITEM DESC</td>
										<td>:</td>
										<td><textarea id="modaddmenuitemsDesc" rows="2" style="margin-bottom: 2px; color: #222222; width: 95%;"></textarea> <!-- <input type="text" id="modaddmenuitemsDesc" value="" style="margin-bottom: 3px;color: #222222;width: 95%;"/> --></td>
									</tr>
									<tr>
										<td>ITEM CODE</td>
										<td>:</td>
										<td><input type="text" id="modaddmenuitemsCode" value="" style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
									</tr>
									<tr>
										<td>PRICE</td>
										<td>:</td>
										<td><input type="text" id="modaddmenuitemsPrice" value="" style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
									</tr>
									<tr>
										<td>VAT(%)</td>
										<td>:</td>
										<td><input type="text" id="modaddmenuitemsVat" value="${sessionScope.loggedinStore.vatAmt}" style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
									</tr>
									<tr>
										<td>SERVICE TAX(%)</td>
										<td>:</td>
										<td><input type="text" id="modaddmenuitemsStax" value="${sessionScope.loggedinStore.serviceTaxAmt}" style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
									</tr>
									<tr>
										<td>ITEM TYPE</td>
										<td>:</td>
										<td><input type="radio" id="modaddmenuitemsVeg" name="modaddmenuitemsType" checked="checked" value="Y">&nbsp;&nbsp;VEG&nbsp; <input type="radio" id="modaddmenuitemsNonVeg" name="modaddmenuitemsType" value="N">&nbsp;&nbsp;NON VEG</td>
									</tr>
									<tr>
										<td>SPICY</td>
										<td>:</td>
										<td><input type="radio" id="modaddmenuitemsspicyYes" name="modaddmenuitemsSpicy" value="Y">&nbsp;&nbsp;YES&nbsp;&nbsp; <input type="radio" id="modaddmenuitemsspicyNo" name="modaddmenuitemsSpicy" checked="checked" value="N">&nbsp;&nbsp;NO</td>
									</tr>
									<tr>
										<td>PROMOTION</td>
										<td>:</td>
										<td><input type="radio" id="modaddmenuitemspromoYes" onchange="enablePromoFields()" name="modaddmenuitemsPromo" value="Y">&nbsp;&nbsp;YES&nbsp;&nbsp; <input type="radio" id="modaddmenuitemspromoNo" onchange="disablePromoFields()" name="modaddmenuitemsPromo" checked="checked" value="N">&nbsp;&nbsp;NO</td>
									</tr>
									<tr>
										<td>PROMOTION DESC</td>
										<td>:</td>
										<td><input type="text" id="modaddmenuitemsPromoDesc" disabled="disabled" value="" style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
									</tr>
									<tr>
										<td>PROMOTION VALUE</td>
										<td>:</td>
										<td><input type="text" id="modaddmenuitemsPromoValue" disabled="disabled" value="" style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
									</tr>
									<tr>
										<td>COOKING TIME(MIN.)</td>
										<td>:</td>
										<td><input type="text" id="modaddmenuitemsCookingTime" value="10" style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
									</tr>
									<tr>
										<td>ITEM UNIT</td>
										<td>:</td>
										<td><select id="modaddmenuitemsUnit" style="margin-bottom: 2px; color: #222222;">
												<c:if test="${! empty fmcgList}">
													<c:forEach items="${fmcgList}" var="fmcg">
														<option value="${fmcg.name}">${fmcg.name}</option>
													</c:forEach>
												</c:if>
										</select></td>
									</tr>
									<tr>
										<td>Purchase Price</td>
										<td>:</td>
										<td><input type="text" id="modaddmenuitemsPurchasePrice"  style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
									</tr>
									<c:if test="${sessionScope.loggedinStore.id==120}">
									<tr>
										<td>Packaging Item</td>
										<td>:</td>
										<td><select id="modaddmenuitemsPackaging" style="margin-bottom: 2px; color: #222222;">
														<option value="N">NO</option>
														<option value="Y">YES</option>
										</select></td>
									</tr>
									</c:if>
									<c:if test="${sessionScope.loggedinStore.id!=120}">
									<tr class="hide">
										<td>Packaging Item</td>
										<td>:</td>
										<td><select id="modaddmenuitemsPackaging" style="margin-bottom: 2px; color: #222222;">
														<option value="N">NO</option>
														<option value="Y">YES</option>
										</select></td>
									</tr>
									</c:if>
								</table>

								<div style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;" id="addmenuitemsalertMsg"></div>
							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #F60; font-weight: bold; width: 25%" class="btn btn-warning" data-dismiss="modal">CANCEL</button>
							<button type="button" onclick="javascript:addMenuItems()" style="background: #72BB4F; font-weight: bold; width: 25%" class="btn btn-success">CREATE</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="menuitemEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Edit Menu Item</h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: left; font-size: 18px;">
								<input type="hidden" id="modeditmenuitemsId" value="">

								<table>
									<tr>
										<td>CATEGORY NAME</td>
										<td>:</td>
										<td><select id="modeditmenucategoryId" disabled="disabled" style="margin-bottom: 2px; color: #222222;"></select></td>
									</tr>
									<tr>
										<td>SUB CATEGORY NAME</td>
										<td>:</td>
										<td><select id="modeditmenusubcategoryId" disabled="disabled" style="margin-bottom: 2px; color: #222222;"></select></td>
									</tr>
									<tr>
										<td>ITEM NAME</td>
										<td>:</td>
										<td><input type="text" id="modeditmenuitemsName" value="" style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
									</tr>
									<tr>
										<td>ITEM DESC</td>
										<td>:</td>
										<td><textarea id="modeditmenuitemsDesc" rows="2" style="margin-bottom: 2px; color: #222222; width: 95%;"></textarea> <!-- <input type="text" id="modeditmenuitemsDesc" value="" style="margin-bottom: 3px;color: #222222;width: 95%;"/> --></td>
									</tr>
									<tr>
										<td>ITEM CODE</td>
										<td>:</td>
										<td><input type="text" id="modeditmenuitemsCode" value="" style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
									</tr>
									<tr>
										<td>PRICE</td>
										<td>:</td>
										<td><input type="text" id="modeditmenuitemsPrice" value="" style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
									</tr>
									<tr>
										<td>CGST</td>
										<td>:</td>
										<td><input type="text" id="modeditmenuitemsVat" value="" style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
									</tr>
									<tr>
										<td>SGST</td>
										<td>:</td>
										<td><input type="text" id="modeditmenuitemsStax" value="" style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
									</tr>
									<tr>
										<td>ITEM TYPE</td>
										<td>:</td>
										<td><input type="radio" id="modeditmenuitemsVeg" name="modeditmenuitemsType" value="Y">&nbsp;&nbsp;VEG&nbsp; <input type="radio" id="modeditmenuitemsNonVeg" name="modeditmenuitemsType" value="N">&nbsp;&nbsp;NON VEG</td>
									</tr>
									<tr>
										<td>SPICY</td>
										<td>:</td>
										<td><input type="radio" id="modeditmenuitemsspicyYes" name="modeditmenuitemsSpicy" value="Y">&nbsp;&nbsp;YES&nbsp;&nbsp; <input type="radio" id="modeditmenuitemsspicyNo" name="modeditmenuitemsSpicy" value="N">&nbsp;&nbsp;NO</td>
									</tr>
									<tr>
										<td>PROMOTION</td>
										<td>:</td>
										<td><input type="radio" id="modeditmenuitemspromoYes" onchange="enablePromoFields()" name="modeditmenuitemsPromo" value="Y">&nbsp;&nbsp;YES&nbsp;&nbsp; <input type="radio" id="modeditmenuitemspromoNo" onchange="disablePromoFields()" name="modeditmenuitemsPromo" value="N">&nbsp;&nbsp;NO</td>
									</tr>
									<tr>
										<td>PROMOTION DESC</td>
										<td>:</td>
										<td><input type="text" id="modeditmenuitemsPromoDesc" value="" style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
									</tr>
									<tr>
										<td>PROMOTION VALUE</td>
										<td>:</td>
										<td><input type="text" id="modeditmenuitemsPromoValue" value="" style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
									</tr>
									<tr>
										<td>COOKING TIME(MIN.)</td>
										<td>:</td>
										<td><input type="text" id="modeditmenuitemsCookingTime" value="" style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
									</tr>
									<tr>
										<td>ITEM UNIT</td>
										<td>:</td>
										<td><select id="modeditmenuitemsUnit" style="margin-bottom: 2px; color: #222222;">

										</select></td>
									</tr>
									<tr>
										<td>ITEM STATUS</td>
										<td>:</td>
										<td><select id="modeditmenuitemsProductionId" style="margin-bottom: 2px; color: #222222;">

										</select></td>
									</tr>
									
									<tr>
										<td>ALL SPOT DISCOUNT</td>
										<td>:</td>
										<td><select id="modeditmenuitemsspotDiscId" style="margin-bottom: 2px; color: #222222;">

										</select></td>
									</tr>
									
									<tr>
										<td>Purchase Price</td>
										<td>:</td>
										<td><input type="text" id="modeditmenuitemsPurchasePrice"  style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
									</tr>
									<c:if test="${sessionScope.loggedinStore.id==120}">
									<tr>
										<td>Packaging Item</td>
										<td>:</td>
										<td><select id="modeditmenuitemsPackaging" style="margin-bottom: 2px; color: #222222;">
														
										</select></td>
									</tr>
									</c:if>
									<c:if test="${sessionScope.loggedinStore.id!=120}">
									<tr class="hide">
										<td>Packaging Item</td>
										<td>:</td>
										<td><select id="modeditmenuitemsPackaging" style="margin-bottom: 2px; color: #222222;">
														
										</select></td>
									</tr>
									</c:if>
									
									
									
									
								</table>

								<div style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;" id="editmenuitemsalertMsg"></div>
							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #F60; font-weight: bold; width: 25%" class="btn btn-warning" data-dismiss="modal">CANCEL</button>
							<button type="button" onclick="javascript:editMenuItems()" style="background: #72BB4F; font-weight: bold; width: 25%" class="btn btn-success">EDIT</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="confirmdeleteMenuItemsModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Confirmation!</h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								Are you sure? <input type="hidden" id="deletemodmenuitemssubcatId" value=""> <input type="hidden" id="deletemodmenuitemsId" value="">

							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #F60; font-weight: bold; width: 25%;" class="btn btn-warning" data-dismiss="modal">CANCEL</button>
							<button type="button" onclick="javacsript:deleteMenuItems()" style="background: #72BB4F; font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="menuitemsDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Menu Item Details</h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div align="center" style="font-size: 18px;">
								<table>
									<tr>
										<td style="padding: 0px 0px;">CATEGORY NAME</td>
										<td width="5%">:</td>
										<td id="moddetailmenuitemscatnameTd"></td>
									</tr>
									<tr>
										<td style="padding: 2px 0px;">SUB CATEGORY NAME</td>
										<td width="5%">:</td>
										<td id="moddetailmenuitemssubcatnameTd"></td>
									</tr>
									<tr>
										<td style="padding: 2px 0px;">ID</td>
										<td width="5%">:</td>
										<td id="moddetailmenuitemsidTd"></td>
									</tr>
									<tr>
										<td style="padding: 2px 0px;">NAME</td>
										<td width="5%">:</td>
										<td id="moddetailmenuitemsnameTd"></td>
									</tr>
									<tr>
										<td style="padding: 2px 0px;">DESC</td>
										<td width="5%">:</td>
										<td id="moddetailmenuitemsdescTd"></td>
									</tr>
									<tr>
										<td style="padding: 2px 0px;">CODE</td>
										<td width="5%">:</td>
										<td id="moddetailmenuitemscodeTd"></td>
									</tr>
									<tr>
										<td style="padding: 2px 0px;">PRICE</td>
										<td width="5%">:</td>
										<td id="moddetailmenuitemspriceTd"></td>
									</tr>
									<tr>
										<td style="padding: 2px 0px;">VAT</td>
										<td width="5%">:</td>
										<td id="moddetailmenuitemsvatTd"></td>
									</tr>
									<tr>
										<td style="padding: 2px 0px;">SERVICE TAX</td>
										<td width="5%">:</td>
										<td id="moddetailmenuitemsstaxTd"></td>
									</tr>
									<tr>
										<td style="padding: 2px 0px;">TYPE</td>
										<td width="5%">:</td>
										<td id="moddetailmenuitemstypeTd"></td>
									</tr>
									<tr>
										<td style="padding: 2px 0px;">SPICY</td>
										<td width="5%">:</td>
										<td id="moddetailmenuitemsspicyTd"></td>
									</tr>
									<tr>
										<td style="padding: 2px 0px;">PROMOTION</td>
										<td width="5%">:</td>
										<td id="moddetailmenuitemspromoTd"></td>
									</tr>
									<tr>
										<td style="padding: 2px 0px;">PROMOTION DESC</td>
										<td width="5%">:</td>
										<td id="moddetailmenuitemspromodescTd"></td>
									</tr>
									<tr>
										<td style="padding: 2px 0px;">PROMOTION VALUE</td>
										<td width="5%">:</td>
										<td id="moddetailmenuitemspromovalueTd"></td>
									</tr>
									<tr>
										<td style="padding: 2px 0px;">COOKING TIME(MIN.)</td>
										<td width="5%">:</td>
										<td id="moddetailmenuitemscookingtimeTd"></td>
									</tr>
									<tr>
										<td style="padding: 2px 0px;">UNIT</td>
										<td width="5%">:</td>
										<td id="moddetailmenuitemsunitTd"></td>
									</tr>
									<tr>
										<td style="padding: 2px 0px;">ITEM STATUS</td>
										<td width="5%">:</td>
										<td id="moddetailmenuitemsproductionTd"></td>
									</tr>
									<tr>
										<td style="padding: 2px 0px;">SPOT DISCOUNT</td>
										<td width="5%">:</td>
										<td id="moddetailmenuitemsspotDiscTd"></td>
									</tr>
									<tr>
										<td style="padding: 2px 0px;">PURCHASE PRICE</td>
										<td width="5%">:</td>
										<td id="moddetailmenuitemsPurchasePriceTd"></td>
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

			<div class="modal fade" data-backdrop="static" id="alertnoItemFoundModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert!</h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">No item found!</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #72BB4F; font-weight: bold;" data-dismiss="modal" class="btn btn-success">OK</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="menuitemaddkotPrinterModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Add KOT Printer</h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div align="center" style="font-size: 20px;">
								<table>
									<tr>
										<td style="padding: 5px 0px;">ITEM ID</td>
										<td width="5%">:</td>
										<td id="moditemkotitemidTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;">ITEM NAME</td>
										<td width="5%">:</td>
										<td id="moditemkotitemnameTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;">PRINTER 1</td>
										<td width="5%">:</td>
										<td><select id="moditemkotprinterloc1" style="color: #222222;"></select></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;">PRINTER 2</td>
										<td width="5%">:</td>
										<td><select id="moditemkotprinterloc2" style="color: #222222;"></select></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;">PRINTER 3</td>
										<td width="5%">:</td>
										<td><select id="moditemkotprinterloc3" style="color: #222222;"></select></td>
									</tr>

								</table>
								<div style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;" id="additemkotalertMsg"></div>
							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #F60; font-weight: bold; width: 25%;" class="btn btn-warning" data-dismiss="modal">CANCEL</button>
							<button type="button" onclick="javacsript:AddItemKOTPrinter()" style="background: #72BB4F; font-weight: bold; width: 25%;" class="btn btn-success">ADD</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static" id="uploadImageModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Upload Menu Item Image</h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<form action="${pageContext.request.contextPath }/menumgnt/uploadmenuitemimage.htm" method="post" enctype="multipart/form-data">
								<div class="row" style="font-size: 16px;">
									<div class="col-sm-1"></div>
									<div class="col-sm-5 ">
										<div class="form-group">
										<label for="email">Upload PNG File:</label>
										 <input type="file" name="fileUpload" class="form-control" id="fileUpload" />
										</div>
										<div style="margin-top: 12px;" class="form-group">
										<label for="email">Name:</label>
											 <input type="text" name="imageName" class="form-control" readonly id="imageName" style="color: black;" /><input type="hidden" name="imageitemid" id="imageitemid" />
										</div>

										<div style="margin-top: 12px;">
											<input type="submit" value="Upload" class="btn btn-success" style="background: #41A1E3; margin-top: 15px;">
										</div>
									</div>
									<div class="col-sm-5" style="margin-left: 12px;">
										<div style="margin-top: 12px;">
											<img id="Mitemimg" src="" class="img-thumbnail" width="304" height="236">
										</div>
									</div>
									<div class="col-sm-1"></div>
								</div>
							</form>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #F60; font-weight: bold;" class="btn btn-warning" data-dismiss="modal">CANCEL</button>
							<!--                                             <button type="button"  style="background: #72BB4F;font-weight: bold;" data-dismiss="modal" class="btn btn-success">OK</button> -->
						</div>
					</div>
				</div>
			</div>
			<div class="modal fade" data-backdrop="static" id="alertmenuitemdataopModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menuitems.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                               
                                            <div id="menuitemdataopmassagecont"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" onclick="location.href='${pageContext.request.contextPath}/menumgnt/loadmenuitems.htm'" style="background: #72BB4F;font-weight: bold;width: 25%"  data-dismiss="modal" class="btn btn-success">OK</button>
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
		var vatses = '${sessionScope.loggedinStore.vatAmt}';
		var staxses = '${sessionScope.loggedinStore.serviceTaxAmt}';
		var selectedspnoteRows = [];
		/* for menu items*/
		function shownmenuitemsaddModal() {
			$('#menuitemAddModal').modal('show');
		}
		function closenmenuitemsaddModal() {
			$('#menuitemAddModal').modal('hide');
		}
		function openUploadImageModal(	itemid,
										menuname) {
			console.log("menuname=" + menuname);
			$('#imageitemid').val(itemid);
			$('#imageName').val(menuname);

			$.ajax({
				url : "${pageContext.request.contextPath}/menumgnt/getimagebyitemid.htm",
				type : "GET",
				data : {
					itemId : itemid
				},

				// 				dataType : "json",

				success : function(data) {
					console.log("data=" + data);
					if(data=='failure'){
						$('#Mitemimg').attr('src', "${pageContext.request.contextPath}/assets/images/menu/a/noimage.png");
					}else{
						$('#Mitemimg').attr('src', data);
					}
				},
				error : function(error) {
					alert('error: ' + error);
				}
			});
			$('#uploadImageModal').modal('show');
		}
		function shownmenuitemseditModal(	catid,
											catname,
											subcatid,
											subcatname,
											id,
											name,
											desc,
											rate,
											vat,
											stax,
											type,
											spicy,
											promo,
											promodesc,
											promovalue,
											cookingtime,
											production,
											unit,spotDisc,code,purchasePrice,packaged) {
			var catselect = document.getElementById('modeditmenucategoryId');
			var subcatselect = document.getElementById('modeditmenusubcategoryId');
			var catoption = "";
			var subcatoption = "";
			catoption = "<option value='"+catid+"'>" + catname + "</option>";
			subcatoption = "<option value='"+subcatid+"'>" + subcatname + "</option>";
			catselect.innerHTML = catoption;
			subcatselect.innerHTML = subcatoption;
			document.getElementById('modeditmenuitemsId').value = id;
			document.getElementById('modeditmenuitemsName').value = name;
			document.getElementById('modeditmenuitemsDesc').value = desc;
			document.getElementById('modeditmenuitemsPrice').value = rate;
			document.getElementById('modeditmenuitemsVat').value = vat;
			document.getElementById('modeditmenuitemsStax').value = stax;
			document.getElementById('modeditmenuitemsPurchasePrice').value = purchasePrice;
			if (type == 'Y') {
				document.getElementById('modeditmenuitemsVeg').checked = true;
			} else {
				document.getElementById('modeditmenuitemsNonVeg').checked = true;
			}
			if (spicy == 'Y') {
				document.getElementById('modeditmenuitemsspicyYes').checked = true;
			} else {
				document.getElementById('modeditmenuitemsspicyNo').checked = true;
			}
			if (promo == 'Y') {
				document.getElementById('modeditmenuitemspromoYes').checked = true;
				document.getElementById('modeditmenuitemsPromoDesc').value = promodesc;
				document.getElementById('modeditmenuitemsPromoValue').value = promovalue;
			} else {
				document.getElementById('modeditmenuitemspromoNo').checked = true;
				document.getElementById('modeditmenuitemsPromoDesc').disabled = 'true';
				document.getElementById('modeditmenuitemsPromoValue').disabled = 'true';
				//document.getElementById('modeditmenuitemsPromoDesc').value=promodesc;
				// document.getElementById('modeditmenuitemsPromoValue').value=promovalue;
			}
			document.getElementById('modeditmenuitemsCookingTime').value = cookingtime;
			var prodline = "";
			if (production == 'Y') {
				prodline = "<option value='Y'>ENABLE</option><option value='N'>DISABLE</option>";
			} else {
				prodline = "<option value='N'>DISABLE</option><option value='Y'>ENABLE</option>";
			}
			document.getElementById('modeditmenuitemsProductionId').innerHTML = prodline;
			 var spotdiscline="";
			   if(spotDisc=='Y')
			   		{
				   spotdiscline="<option value='Y'>ENABLE</option><option value='N'>DISABLE</option>";
			   		}
		   		else
			   		{
		   			spotdiscline="<option value='N'>DISABLE</option><option value='Y'>ENABLE</option>";
			   		}
			   document.getElementById('modeditmenuitemsspotDiscId').innerHTML=spotdiscline;
			   document.getElementById('modeditmenuitemsCode').value=code;
			var unitArray = [];
			var unitoption = "";
			var unitoption1 = "";
			<c:forEach items="${fmcgList}" var="fmcg" varStatus="loop">
			unitArray.push('${fmcg.name}');
			</c:forEach>
			unitoption = "<option value='"+unit+"'>" + unit + "</option>";
			for ( var i = 0; i < unitArray.length; i++) {
				if (unitArray[i] != unit) {
					unitoption1 += "<option value='"+unitArray[i]+"'>" + unitArray[i] + "</option>";
				}
			}
			var unitoptionfinal = unitoption + unitoption1;
			document.getElementById('modeditmenuitemsUnit').innerHTML = unitoptionfinal;
			var packageline="";
			   if(packaged=='Y')
			   		{
				   packageline="<option value='Y'>YES</option><option value='N'>NO</option>";
			   		}
		   		else
			   		{
		   			packageline="<option value='N'>NO</option><option value='Y'>YES</option>";
			   		}
			   document.getElementById('modeditmenuitemsPackaging').innerHTML=packageline;
			$('#menuitemEditModal').modal('show');
		}
		function closenmenuitemseditModal() {
			$('#menuitemEditModal').modal('hide');
		}
		function shownmenuitemsdetailModal(	catid,
											catname,
											subcatid,
											subcatname,
											id,
											name,
											desc,
											rate,
											vat,
											stax,
											type,
											spicy,
											promo,
											promodesc,
											promovalue,
											cookingtime,
											production,
											unit,spotDisc,code,purchasePrice) {
			document.getElementById('moddetailmenuitemscatnameTd').innerHTML = catname;
			document.getElementById('moddetailmenuitemssubcatnameTd').innerHTML = subcatname;
			document.getElementById('moddetailmenuitemsidTd').innerHTML = id;
			document.getElementById('moddetailmenuitemsnameTd').innerHTML = name;
			document.getElementById('moddetailmenuitemsdescTd').innerHTML = desc;
			document.getElementById('moddetailmenuitemspriceTd').innerHTML = parseFloat(rate).toFixed(2);
			document.getElementById('moddetailmenuitemsvatTd').innerHTML = vat;
			document.getElementById('moddetailmenuitemsstaxTd').innerHTML = stax;
			var foodtype;
			var spicytype;
			var promotype;
			var status;
			var spotdiscstatus;
			if (type == 'Y') {
				foodtype = 'VEG';
			} else {
				foodtype = 'NON VEG';
			}
			if (spicy == 'Y') {
				spicytype = 'YES';
			} else {
				spicytype = 'NO';
			}
			if (promo == 'Y') {
				promotype = 'YES';
			} else {
				promotype = 'NO';
			}
			if (production == 'Y') {
				status = 'ENABLE';
			} else {
				status = 'DISABLE';
			}
			 if(spotDisc=='Y'){
				 spotdiscstatus='ENABLE';
			} else {
			     spotdiscstatus='DISABLE';
			 }
			document.getElementById('moddetailmenuitemstypeTd').innerHTML = foodtype;
			document.getElementById('moddetailmenuitemsspicyTd').innerHTML = spicytype;
			document.getElementById('moddetailmenuitemspromoTd').innerHTML = promotype;
			document.getElementById('moddetailmenuitemspromodescTd').innerHTML = promodesc;
			document.getElementById('moddetailmenuitemspromovalueTd').innerHTML = promovalue;
			document.getElementById('moddetailmenuitemscookingtimeTd').innerHTML = cookingtime;
			document.getElementById('moddetailmenuitemsproductionTd').innerHTML = status;
			document.getElementById('moddetailmenuitemsunitTd').innerHTML = unit;
		    document.getElementById('moddetailmenuitemsspotDiscTd').innerHTML=spotdiscstatus;
		    document.getElementById('moddetailmenuitemscodeTd').innerHTML=code;
		    document.getElementById('moddetailmenuitemsPurchasePriceTd').innerHTML=purchasePrice;
		    
			$('#menuitemsDetailModal').modal('show');
		}
		function showConfirmdeleteMenuItemsModal(	subcatId,
													id) {
			document.getElementById('deletemodmenuitemssubcatId').value = subcatId;
			document.getElementById('deletemodmenuitemsId').value = id;
			$('#confirmdeleteMenuItemsModal').modal('show');
		}
		function showalertnoItemFoundModal() {
			$('#alertnoItemFoundModal').modal('show');
		}
		function showspecialNoteModal() {
			$('#specialnoteModal').modal('show');
		}
		function closespecialNoteModal() {
			$('#specialnoteModal').modal('hide');
		}
		function showmenuitemkotaddModal() {
			$('#menuitemaddkotPrinterModal').modal('show');
		}
		function closemenuitemkotaddModal() {
			$('#menuitemaddkotPrinterModal').modal('hide');
		}
		function showalertmenuitemdataopModal()
		{
			$('#alertmenuitemdataopModal').modal('show');
		}
		/* end for menu items*/
	</script>
	<script type="text/javascript">
		$(function() {
			$("#itemSearch").autocomplete({
				source : function(	request,
									response) {
					$.ajax({
						url : "${pageContext.request.contextPath}/menumgnt/autocomplete.htm",
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
					$("#autocompleteItemId").val(ui.item.itemCode);

				}
			});
		});
	</script>
</body>
</html>