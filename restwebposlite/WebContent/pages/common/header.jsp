<%@page import="com.sharobi.webpos.util.Constants"%>
<%@page import="com.sharobi.webpos.base.model.Store"%>
<%@page import="com.sharobi.webpos.vfd.Display"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="today" value="<%=new java.util.Date()%>" />
<header>
	<div class="container-fluid">
		<div class="row">
			<a style="float: left"
				href="${pageContext.request.contextPath }/home/welcome.htm"> <c:choose>
					<c:when test="${sessionScope.loggedinStore.id ==37}">
						<img src="${pageContext.request.contextPath}/assets/images/header/hsb_topbar-icon.png" />
					</c:when>
					<c:when test="${sessionScope.loggedinStore.id ==38}">
						<img src="${pageContext.request.contextPath}/assets/images/header/hsb_topbar-icon.png" />
					</c:when>
					<c:when test="${sessionScope.loggedinStore.id ==39}">
						<img src="${pageContext.request.contextPath}/assets/images/header/ht_pos_topbarlogo.png" />
					</c:when>
					<c:when test="${sessionScope.loggedinStore.id ==41}">
						<img src="${pageContext.request.contextPath}/assets/images/header/th_poslogo.png" />
					</c:when>
					<c:when test="${sessionScope.loggedinStore.id ==35}">
						<img src="${pageContext.request.contextPath}/assets/images/header/marufaz_pos-logo.png" />
					</c:when>
					<c:otherwise>
						<img src="${pageContext.request.contextPath}/assets/images/header/yewpos_f&b_lite_logo.png" />
					</c:otherwise>
				</c:choose>

			</a>
			<div class="col-md-8" style="float: right; color: #fff;">
				<c:if test="${! empty sessionScope.loggedinUser.contactNo}">
					<strong><fmt:formatDate pattern="dd MMMM yyyy, EEEE"
							value="${today}" /></strong>
					<img
						src="${pageContext.request.contextPath}/assets/images/header/e/e_user.png">Welcome&nbsp;&nbsp;<strong>${sessionScope.loggedinUser.name}</strong>
                    &nbsp;&nbsp;
                    <!--<strong><img src="assets/img/e_switchuser.png">&nbsp;&nbsp;SWITCH USER</strong>-->
					<c:if test="${sessionScope.loggedinStore.license == 'Y'}">
						<a href="javascript:openLicenseInfoModal()"> <img
							src="${pageContext.request.contextPath}/assets/images/header/info.png"
							style="height: 22px;"></a>
					</c:if>
					<a
						href="${pageContext.request.contextPath }/authentication/logout.htm"><img
						src="${pageContext.request.contextPath}/assets/images/header/e/e_logout.png"></a>
					<!--                    <div style="text-transform: uppercase; color: #fff;"> 
                   		 <strong><fmt:formatDate pattern="dd MMMM yyyy, EEEE" value="${today}" /></strong>
                    </div> -->
				</c:if>
			</div>
		</div>
	</div>
</header>
<!-- HEADER END-->
<div class="navbar navbar-inverse set-radius-zero">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-collapse">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
		</div>
		<section class="menu-section">
			<div class="row">
				<div class="col-md-12">
					<div id="tablebookingheaderdata" class="col-md-2 col-sm-1"
						style="display: none;">
						<div
							style="padding-top: 10px; font-size: 14px; font-weight: bold; text-transform: uppercase;">
							Order no.
							<%-- <select id="orderNo" onchange="javascript:selectOderNo()">
                								<c:if test="${! empty orders}">
                									<c:choose>
                										<c:when test="${orders.ordertype.id==2 }">
                											<option value="${orders.id }">${orders.id } #P</option>
                										</c:when>
                										<c:when test="${orders.ordertype.id==1 }">
                											<option value="${orders.id }">${orders.id } #H</option>
                										</c:when>
                										<c:otherwise>
                											<option value="${orders.id }">${orders.id } #T${orders.table_no}#${orders.seatNo}</option>
                										</c:otherwise>
                									</c:choose>
                									
                								</c:if>
                								<c:if test="${empty orders}">
                									<option value="0">0</option>
                								</c:if>
                								<c:if test="${!empty sessionScope.unpaidorderList}">
            										<c:forEach items="${sessionScope.unpaidorderList}" var="unpaidorderList">
            											<c:if test="${orders.id != unpaidorderList.id}">
            												<c:choose>
                												<c:when test="${unpaidorderList.ordertype.id==2 }">
                													<option value="${unpaidorderList.id }">${unpaidorderList.id } #P</option>
                												</c:when>
                												<c:when test="${unpaidorderList.ordertype.id==1 }">
                													<option value="${unpaidorderList.id }">${unpaidorderList.id } #H</option>
                												</c:when>
                												<c:otherwise>
                													<option value="${unpaidorderList.id }">${unpaidorderList.id } #T${unpaidorderList.table_no}#${unpaidorderList.seatNo}</option>
                												</c:otherwise>
                											</c:choose>
            												
            											</c:if>
            										</c:forEach>
            									</c:if>
                						  </select> --%>
							<select id="orderNo" onchange="javascript:selectOderNo()">
								<c:if test="${! empty orders}">
									<option id="${orders.ordertype.id }" value="${orders.id }">${orders.orderNo}
										#${orders.ordertype.ordertypeShortName }</option>
								</c:if>
								<c:if test="${empty orders}">
									<option value="0">0</option>
								</c:if>
								<c:if test="${!empty sessionScope.unpaidorderList}">
									<c:forEach items="${sessionScope.unpaidorderList}"
										var="unpaidorderList">
										<c:if test="${orders.id != unpaidorderList.id}">
											<option id="${unpaidorderList.ordertype.id }"
												value="${unpaidorderList.id }">${unpaidorderList.orderNo }
												#${unpaidorderList.ordertype.ordertypeShortName }</option>
										</c:if>
									</c:forEach>
								</c:if>
							</select>
							<!--                         		Table No.  -->

							<c:if test="${!empty orders}">
								<strong class="hide"><span id="tablenoCont">${orders.table_no}</span></strong>
							</c:if>
							<c:if test="${empty orders}">
								<strong class="hide"><span id="tablenoCont">${currentTable}</span></strong>
							</c:if>
							<c:if test="${!empty sessionScope.unpaidorderList}">
								<c:forEach items="${sessionScope.unpaidorderList}"
									var="unpaidlist">
									<input type="hidden" id="tno${unpaidlist.id}"
										value="${unpaidlist.table_no}" />
									<input type="hidden" id="sno${unpaidlist.id}"
										value="${unpaidlist.seatNo}" />
								</c:forEach>
							</c:if>
							<input type="hidden" id="hidcurrentSeat" value="${currentSeat}">

						</div>
					</div>

					<div id="changetableheaderdata" class="col-md-1 col-sm-1"
						style="display: none; padding-top: 8px">
						<%-- <c:if test="${fn:containsIgnoreCase(sessionScope.loggedinStore.multiOrderTable, 'N') }">
                        	<a href="javascript:showchangeTable()" class="btn btn-success" style="text-align:center;margin-top:2px;"><span class="fa fa-exchange"></span>&nbsp;</a>
                        </c:if> --%>
						<a
							href="${pageContext.request.contextPath}/order/vieworder.htm?ono=0&tno=0&sno=0"
							class="btn btn-success" style="background-color: #ff7d6c">NEW
							ORDER </a>
					</div>
					
					
						
					
					<!-- division order_type has been added by SAYANI AND SIBAPRASAD -->

					<div id="order_type" class="col-md-2"
						style="display:none;padding-top: 10px; font-size: 14px; font-weight: bold; text-transform: uppercase;">
						Order Type <select id="orderType" onchange="selectedOrderType(this.value)">
							<c:forEach items="${orderTypeList}" var="typeList">
<%-- 								<c:set var="orderTypeList" value="${typeList}" />
 --%>							
								<c:if test="${typeList.orderTypeName!='Dine In'}">
								
									<option value="${typeList.id}">${typeList.orderTypeName}</option>
								</c:if>
                			</c:forEach>
						</select>
					</div>
					
					

					<div id="changetableheaderdataordersearch"
						class="col-md-1 col-sm-1" style="display: none; padding-top: 8px">
						<div class="input-group">
							<input type="text" id="inputorderno" size="8"
								placeholder="Order No" aria-describedby="basic-addon2">
							<span class="input-group-addon" id="basic-addon2"
								style="padding: 5px 10px;"
								onclick="searchbyorderno(document.getElementById('inputorderno').value)"><i
								class="fa fa-search" aria-hidden="true"></i></span>
						</div>
					</div>
					
				
					
					<c:if test="${sessionScope.loggedinStore.id ==120}">
					
					<div id="changetaxsetup" class="col-md-3"
						style="display: none; padding-top: 8px">
						
						<a href="javascript:changeTaxSetUp()" class="btn btn-success" style="background-color: #ff7d6c">TAX
							SETUP </a>
						</div>
					
					
					 </c:if>
					
					
					

					<div class="navbar-collapse collapse " id="nav">
						<ul id="menu-top" class="nav navbar-nav navbar-right">
				<%-- 			<li><a
								href="${pageContext.request.contextPath }/home/welcome.htm"><img
									src="${pageContext.request.contextPath}/assets/images/menu/a/a_home.png"
									title="Home"></a></li>
							<li><a href="${pageContext.request.contextPath}/table/viewtable.htm"><img src="${pageContext.request.contextPath}/assets/images/menu/a/a_table.png" title="Table"></a></li>
							<li><a
								href="${pageContext.request.contextPath}/order/vieworder.htm?ono=0&tno=0&sno=0"><img
									src="${pageContext.request.contextPath}/assets/images/menu/a/a_pos.png"
									title="POS"></a></li>
							<c:choose>
								<c:when test="${sessionScope.loggedinStore.id ==53}">
									<li><a href="javascript:showloginunpaidordermoduleModal()"><img
											src="${pageContext.request.contextPath}/assets/images/menu/a/a_order.png"
											title="Unpaid Order"></a></li>
								</c:when>
								<c:otherwise>
									<li><a
										href="${pageContext.request.contextPath}/unpaidorder/viewunpaidorder.htm"><img
											src="${pageContext.request.contextPath}/assets/images/menu/a/a_order.png"
											title="Unpaid Order"></a></li>
								</c:otherwise>
							</c:choose>
							<li><a
								href="${pageContext.request.contextPath}/report/viewdaywisesales.htm"><img
									src="${pageContext.request.contextPath}/assets/images/menu/a/a_report.png"
									title="Report"></a></li>
							<li><a
								href="${pageContext.request.contextPath}/order/viewallpaidorder.htm"><img
									src="${pageContext.request.contextPath}/assets/images/menu/a/a_reprint.png"
									title="Paid Order"></a></li>
							<c:choose>
								<c:when test="${sessionScope.loggedinStore.id ==42}">
									<li><a href="javascript:showlogininvmoduleModal()"><img
											src="${pageContext.request.contextPath}/assets/images/menu/a/a_im.png"
											title="Inventory"></a></li>
								</c:when>
								<c:otherwise>
									                            	<li><a href="${pageContext.request.contextPath}/inventory/viewinventory.htm"><img src="${pageContext.request.contextPath}/assets/images/menu/a/a_im.png" title="Inventory"></a></li>
									<li><a
										href="${pageContext.request.contextPath}/inventorynew/loadinventory.htm"><img
											src="${pageContext.request.contextPath}/assets/images/menu/a/a_im.png"
											title="Inventory"></a></li>
								</c:otherwise>
							</c:choose>
							                            	<li><a href="${pageContext.request.contextPath}/inventorynew/loadinventory.htm"><img src="${pageContext.request.contextPath}/assets/images/menu/a/a_im.png" title="Inventory New"></a></li>
							                            	<li><a href="${pageContext.request.contextPath}/recipe/loadrecipeingredient.htm"><img src="${pageContext.request.contextPath}/assets/images/menu/a/a_im.png" title="Recipe Management"></a></li>
							<li><a href="${pageContext.request.contextPath}/kitchen/loadkitchenitem.htm"><img src="${pageContext.request.contextPath}/assets/images/menu/a/a_kitchen.png" title="Kitchen"></a></li>
							<li><a href="${pageContext.request.contextPath}/menumgnt/viewmenumgnt.htm"><img src="${pageContext.request.contextPath}/assets/images/menu/a/a_admin.png" title="Admin"></a></li>
							<li><a href="javascript:showloginadminmoduleModal()"><img
									src="${pageContext.request.contextPath}/assets/images/menu/a/a_admin.png"
									title="Admin"></a></li> --%>
									
					
									
								<c:forEach items="${posModuless}" var="posheader">
								<c:if test="${posheader.moduleName=='home' && posheader.modPresent=='Y'}">
									<c:if test="${home=='Y'}">
										<li class="menu-top-active">
									</c:if>
									<c:if test="${home!='Y'}">
										<li>
									</c:if>
									<a href="${pageContext.request.contextPath }/home/welcome.htm"><img src="${pageContext.request.contextPath}/assets/images/menu/a/a_home.png" title="Home"></a>
									</li>
								</c:if>
								<%-- <c:if test="${posheader.moduleName=='table management' && posheader.modPresent=='Y'}">
									<c:if test="${tabelmanagement=='Y'}">
										<li class="menu-top-active">
									</c:if>
									<c:if test="${tabelmanagement!='Y'}">
										<li>
									</c:if>
									<a href="${pageContext.request.contextPath}/table/viewtable.htm"><img src="${pageContext.request.contextPath}/assets/images/menu/a/a_table.png" title="Table"></a>
									</li>
								</c:if> --%>
								
														
								<c:if test="${posheader.moduleName=='order taking' && posheader.modPresent=='Y'}">
									<c:if test="${ordertaking=='Y'}"> 
								
										<li id="posliId" class="menu-top-active">
 									 </c:if>
									<c:if test="${ordertaking!='Y'}">
										<li> <!-- id="posliId" class="hide"> -->
									</c:if>
									<a href="${pageContext.request.contextPath}/order/vieworder.htm?ono=0&tno=0&sno=0"><img src="${pageContext.request.contextPath}/assets/images/menu/a/a_pos.png" title="POS"></a>
									</li>
								</c:if> 
								<c:if test="${posheader.moduleName=='unpaid order' && posheader.modPresent=='Y'}">
									<c:choose>
										<c:when test="${sessionScope.loggedinStore.id ==53 || sessionScope.loggedinStore.id ==87}">
											<c:if test="${unpaidorder=='Y'}">
												<li class="menu-top-active">
											</c:if>
											<c:if test="${unpaidorder!='Y'}">
												<li>
											</c:if>
											<a href="javascript:showloginunpaidordermoduleModal()"><img src="${pageContext.request.contextPath}/assets/images/menu/a/a_order.png" title="Unpaid Order"></a>
											</li>
										</c:when>
										<c:otherwise>
											<c:if test="${unpaidorder=='Y'}">
												<li class="menu-top-active">
											</c:if>
											<c:if test="${unpaidorder!='Y'}">
												<li>
											</c:if>
											<a href="${pageContext.request.contextPath}/unpaidorder/viewunpaidorder.htm"><img src="${pageContext.request.contextPath}/assets/images/menu/a/a_order.png" title="Unpaid Order"></a>
											</li>
										</c:otherwise>
									</c:choose>
								</c:if>
								<%-- <c:if
									test="${posheader.moduleName=='reports' && posheader.modPresent=='Y'}">
									<c:choose>
										<c:when test="${sessionScope.loggedinStore.id ==87}">
											<c:if test="${reports=='Y'}">
												<li class="menu-top-active">
											</c:if>
											<c:if test="${reports!='Y'}">
												<li>
											</c:if>
											<a href="javascript:showloginReportmoduleModal()"><img
												src="${pageContext.request.contextPath}/assets/images/menu/a/a_report.png"
												title="Report"></a>
											</li>
										</c:when>
										<c:otherwise>
											<c:if test="${reports=='Y'}">
												<li class="menu-top-active">
											</c:if>
											<c:if test="${reports!='Y'}">
												<li>
											</c:if>
											
												
									<a href="${pageContext.request.contextPath}/report/viewdaywisesales.htm">
								    <img src="${pageContext.request.contextPath}/assets/images/menu/a/a_report.png" title="Report"></a>
									</li>
										</c:otherwise>
									</c:choose>

								</c:if> --%>
								<c:if test="${posheader.moduleName=='reports' && posheader.modPresent=='Y'}">
									<c:choose>
										<c:when test="${sessionScope.loggedinStore.id ==87 || sessionScope.loggedinStore.id ==86}">
											<c:if test="${reports=='Y'}">
												<li class="menu-top-active">
											</c:if>
											<c:if test="${reports!='Y'}">
												<li>
											</c:if>
											<a href="javascript:showloginReportmoduleModal()"><img src="${pageContext.request.contextPath}/assets/images/menu/a/a_report.png" title="Report"></a>
											</li>
										</c:when>
										 <c:otherwise>
											<c:if test="${reports=='Y'}">
												<li class="menu-top-active">
											</c:if>
											<c:if test="${reports!='Y'}">
												<li>
											</c:if>
											<a href="${pageContext.request.contextPath}/report/getReportByStore.htm"><img src="${pageContext.request.contextPath}/assets/images/menu/a/a_report.png" title="Report"></a>
											</li>

										</c:otherwise> 
									</c:choose>

								</c:if>

								<c:if test="${posheader.moduleName=='Paid Order' && posheader.modPresent=='Y'}">
									<c:if test="${paidorder=='Y'}">
										<li class="menu-top-active">
									</c:if>
									<c:if test="${paidorder!='Y'}">
										<li>
									</c:if>
									<a href="${pageContext.request.contextPath}/order/viewallpaidorder.htm"><img src="${pageContext.request.contextPath}/assets/images/menu/a/a_reprint.png" title="Paid Order"></a>
									</li>
								</c:if>
								
								
						<c:if test="${sessionScope.loggedinStore.simpleIm=='Y'}">
								<c:if test="${posheader.moduleName=='inventory' && posheader.modPresent=='Y'}">
									<c:choose>
										<c:when test="${sessionScope.loggedinStore.id ==42}">
											<c:if test="${activeinventory=='Y'}">
												<li class="menu-top-active">
											</c:if>
											<c:if test="${activeinventory!='Y'}">
												<li>
											</c:if>
											<a href="javascript:showlogininvmoduleModal()"><img src="${pageContext.request.contextPath}/assets/images/menu/a/a_im.png" title="Inventory"></a>
											</li>
										</c:when>
										<c:otherwise>
											<%--                             	<li><a href="${pageContext.request.contextPath}/inventory/viewinventory.htm"><img src="${pageContext.request.contextPath}/assets/images/menu/a/a_im.png" title="Inventory"></a></li> --%>
											<c:if test="${activeinventory=='Y'}">
												<li class="menu-top-active">
											</c:if>
											<c:if test="${activeinventory!='Y'}">
												<li>
											</c:if>
											<a href="${pageContext.request.contextPath}/inventorynew/loadinventory.htm"><img src="${pageContext.request.contextPath}/assets/images/menu/a/a_im.png" title="Inventory"></a>
											</li>
										</c:otherwise>
									</c:choose>
								</c:if>
						</c:if>
								
								
								
								<c:if test="${posheader.moduleName=='menu management admin' && posheader.modPresent=='Y'}">
								</c:if>
								<%-- <c:if test="${posheader.moduleName=='Recipe Based Inventory' && posheader.modPresent=='Y'}">
									<c:if test="${receipebasedinventory=='Y'}">
										<li class="menu-top-active">
									</c:if>
									<c:if test="${receipebasedinventory!='Y'}">
										<li>
									</c:if>
									<a href="${pageContext.request.contextPath}/recipe/loadrecipeingredient .htm"><img src="${pageContext.request.contextPath}/assets/images/menu/a/a_im_adv.png" title="Recipe Based IM"></a>
									</li>
								</c:if> --%>
								<c:if test="${posheader.moduleName=='kitchen' && posheader.modPresent=='Y'}">
									<c:if test="${kitchen=='Y'}">
										<li class="menu-top-active">
									</c:if>
									<c:if test="${kitchen!='Y'}">
										<li>
									</c:if>
									<a href="${pageContext.request.contextPath}/kitchen/loadkitchenitem.htm"><img src="${pageContext.request.contextPath}/assets/images/menu/a/a_kitchen.png" title="Kitchen"></a>
									</li>
								</c:if>

								<%-- <c:if test="${posheader.moduleName=='BI' && posheader.modPresent=='Y'}">
									<li><a href="${pageContext.request.contextPath}/bi/getBidataPage.htm"><img src="${pageContext.request.contextPath}/assets/images/menu/a/a_biTools.png" title="Bi"></a></li>
								</c:if>
 --%>
							</c:forEach>

							<c:if test="${admin=='Y'}">
								<li class="menu-top-active">
							</c:if>
							<c:if test="${admin!='Y'}">
								<li>
							</c:if>
							<a href="javascript:showloginadminmoduleModal()"><img src="${pageContext.request.contextPath}/assets/images/menu/a/a_admin.png" title="Admin"></a>
							</li>
						</ul>
					</div> 
				</div>
			</div>
		</section>
	</div>
</div>

<!-- <div id="changetableheaderdataordersearch" class="col-md-1 col-sm-1" style="display: none;padding-top: 8px">
						<div class="input-group">
							<input type="text" id="inputorderno" size="8" placeholder="Order No" aria-describedby="basic-addon2"> <span class="input-group-addon" id="basic-addon2" style="padding: 5px 10px;" onclick="searchbyorderno(document.getElementById('inputorderno').value)"><i class="fa fa-search" aria-hidden="true" ></i></span>
						</div>
			</div> -->

<!-- modal starts -->
<div class="modal fade" data-backdrop="static"
	id="loginAdminModuleModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true"
	style="display: none;">
	<div class="modal-dialog" style="margin: 100px auto;">
		<div class="modal-content"
			style="border: 3px solid #ffffff; border-radius: 0px;">
			<div class="modal-header"
				style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

				<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
					id="myModalLabel">Login to Admin Module</h4>
			</div>
			<div class="modal-body"
				style="background: #404040; border-top: 1px solid #404040; color: #fff;">
				<div style="text-align: center; font-size: 20px;">
					Enter Security Code : <input type="password"
						id="adminmodulepassword"
						style="text-align: center; color: #222222;">
					<div
						style="text-align: center; color: #F60; font-size: 12px; font-weight: bold; margin-top: 20px;"
						id="adminmoduleloginModalalertMsg"></div>
				</div>
			</div>
			<div class="modal-footer"
				style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
				<button type="button"
					style="width: 25%; background: #F60; font-weight: bold;"
					class="btn btn-warning" data-dismiss="modal">CANCEL</button>
				<button type="button"
					onclick="javascript:loginAdminModule(document.getElementById('adminmodulepassword').value)"
					style="width: 25%; background: #72BB4F; font-weight: bold;"
					class="btn btn-success">SUBMIT</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" data-backdrop="static" id="loginInvModuleModal"
	tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
	aria-hidden="true" style="display: none;">
	<div class="modal-dialog" style="margin: 100px auto;">
		<div class="modal-content"
			style="border: 3px solid #ffffff; border-radius: 0px;">
			<div class="modal-header"
				style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
 id="myModalLabel">Login to Inventory Module</h4>
			</div>
			<div class="modal-body"
				style="background: #404040; border-top: 1px solid #404040; color: #fff;">
				<div style="text-align: center; font-size: 20px;">
					Enter Security Code : <input type="password" id="invmodulepassword"
						style="text-align: center; color: #222222;">
					<div
						style="text-align: center; color: #F60; font-size: 12px; font-weight: bold; margin-top: 20px;"
						id="invmoduleloginModalalertMsg"></div>
				</div>
			</div>
			<div class="modal-footer"
				style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
				<button type="button"
					style="width: 25%; background: #F60; font-weight: bold;"
					class="btn btn-warning" data-dismiss="modal">CANCEL</button>
				<button type="button"
					onclick="javascript:loginInvModule(document.getElementById('invmodulepassword').value)"
					style="width: 25%; background: #72BB4F; font-weight: bold;"
					class="btn btn-success">SUBMIT</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" data-backdrop="static"
	id="loginunpaidorderModuleModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true"
	style="display: none;">
	<div class="modal-dialog" style="margin: 100px auto;">
		<div class="modal-content"
			style="border: 3px solid #ffffff; border-radius: 0px;">
			<div class="modal-header"
				style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

				<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
					id="myModalLabel">Login to Unpaid Order Module</h4>
			</div>
			<div class="modal-body"
				style="background: #404040; border-top: 1px solid #404040; color: #fff;">
				<div style="text-align: center; font-size: 20px;">
					Enter Security Code : <input type="password"
						id="unpaidordermodulepassword"
						style="text-align: center; color: #222222;">
					<div
						style="text-align: center; color: #F60; font-size: 12px; font-weight: bold; margin-top: 20px;"
						id="unpaidordermoduleloginModalalertMsg"></div>
				</div>
			</div>
			<div class="modal-footer"
				style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
				<button type="button"
					style="width: 25%; background: #F60; font-weight: bold;"
					class="btn btn-warning" data-dismiss="modal">CANCEL</button>
				<button type="button"
					onclick="javascript:loginunpaidorderModule(document.getElementById('unpaidordermodulepassword').value)"
					style="width: 25%; background: #72BB4F; font-weight: bold;"
					class="btn btn-success">SUBMIT</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" data-backdrop="static" id="loginReportModuleModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
	<div class="modal-dialog" style="margin: 100px auto;">
		<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
			<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
				<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">
					<spring:message code="header.jsp.LogintoReportModule" text="Login to Report Module" />
				</h4>
			</div>
			<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
				<div style="text-align: center; font-size: 20px;">
					<spring:message code="header.jsp.EnterSecurityCode" text="Enter Security Code" />
					: <input type="password" id="reportmodulepassword" style="text-align: center; color: #222222;">
					<div style="text-align: center; color: #F60; font-size: 12px; font-weight: bold; margin-top: 20px;" id="reportmoduleloginModalalertMsg"></div>
				</div>
			</div>
			<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
				<button type="button" style="width: 25%; background: #F60; font-weight: bold;" class="btn btn-warning" data-dismiss="modal">
					<spring:message code="header.jsp.CANCEL" text="CANCEL" />
				</button>
				<button type="button" onclick="javascript:loginReportModule(document.getElementById('reportmodulepassword').value)" style="width: 25%; background: #72BB4F; font-weight: bold;" class="btn btn-success">
					<spring:message code="header.jsp.SUBMIT" text="SUBMIT" />
				</button>
			</div>
		</div>
	</div>
</div>





<div class="modal fade" data-backdrop="static" id="licenseinfomodal"
	tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
	aria-hidden="true" style="display: none;">
	<div class="modal-dialog" style="margin: 100px auto;">
		<div class="modal-content"
			style="border: 3px solid #ffffff; border-radius: 0px;">
			<div class="modal-header"
				style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

				<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
					id="myModalLabel">Licence Information:</h4>
			</div>
			<div class="modal-body"
				style="background: #404040; border-top: 1px solid #404040; color: #fff;">
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
							<td>Store Name</td>
							<td>: &nbsp;&nbsp;</td>
							<td><span id="storeName"></span></td>
						</tr>
						<tr>
							<td>Number of Users</td>
							<td>: &nbsp;&nbsp;</td>
							<td><span id="licnoofuser"></span></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="modal-footer"
				style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

				<!-- 					<button type="button"  style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">Cancel</button> -->
				<button type="button" onclick="javascript:reloadPage()"
					style="font-weight: bold; width: 25%;" class="btn btn-success"
					data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<!-- modal ends -->
<!-- MENU SECTION END-->
<%-- <script src="${pageContext.request.contextPath}/assets/js/changemenu.js"></script>
 --%><script
	src="${pageContext.request.contextPath}/assets/js/changefavicon.js"></script>
<script
	src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
<script type="text/javascript">
var posmodules="${posModuless}";
var orderTypeList="${orderTypeList}";

</script>
<script type="text/javascript">
 //   	setPage();
function showloginadminmoduleModal()
{
	document.getElementById('adminmoduleloginModalalertMsg').innerHTML='';
	$('#loginAdminModuleModal').modal('show');
	
}
function closeloginadminmoduleModal()
{
	$('#loginAdminModuleModal').modal('hide');
}
function loginAdminModule(pass)
{
	if(pass=='')
		{
		document.getElementById('adminmoduleloginModalalertMsg').innerHTML='Please enter security code !';
		document.getElementById('adminmodulepassword').focus();
		}
	else
		{
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax("${pageContext.request.contextPath}" + "/admin/loginadminmodule/"+pass  + ".htm", function(response) {
			if(response=='failure')
				{
				document.getElementById('adminmoduleloginModalalertMsg').innerHTML='Invalid security code !';
				document.getElementById('adminmodulepassword').focus();
				}
			else{
				closeloginadminmoduleModal();
				location.href="${pageContext.request.contextPath}"+'/dash/viewmdashboard.htm';
				}
			}, null);
		}
}
function showlogininvmoduleModal()
{
	document.getElementById('invmoduleloginModalalertMsg').innerHTML='';
	$('#loginInvModuleModal').modal('show');
	
}
function closelogininvmoduleModal()
{
	$('#loginInvModuleModal').modal('hide');
}
function showloginReportmoduleModal()
{
	document.getElementById('reportmoduleloginModalalertMsg').innerHTML='';
	$('#loginReportModuleModal').modal('show');
	
}
function closeloginReportmoduleModal()
{
	$('#loginReportModuleModal').modal('hide');
}
function showloginunpaidordermoduleModal()
{
	document.getElementById('unpaidordermoduleloginModalalertMsg').innerHTML='';
	$('#loginunpaidorderModuleModal').modal('show');
	
}
function closeloginunpaidordermoduleModal()
{
	$('#loginunpaidorderModuleModal').modal('hide');
}
function showlogininvmoduleModal()
{
	document.getElementById('invmoduleloginModalalertMsg').innerHTML='';
	$('#loginInvModuleModal').modal('show');
	
}
function closeloginunpaidordermoduleModal()
{
	$('#loginunpaidorderModuleModal').modal('hide');
}
function loginInvModule(pass)
{
	if(pass=='')
		{
		document.getElementById('invmoduleloginModalalertMsg').innerHTML='Please enter security code !';
		document.getElementById('invmodulepassword').focus();
		}
	else
		{
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax("${pageContext.request.contextPath}" + "/admin/loginadminmodule/"+pass  + ".htm", function(response) {
			if(response=='failure')
				{
				document.getElementById('invmoduleloginModalalertMsg').innerHTML='Invalid security code !';
				document.getElementById('invmodulepassword').focus();
				}
			else{
				closelogininvmoduleModal();
// 				location.href="${pageContext.request.contextPath}"+'/inventory/viewinventory.htm';
				location.href="${pageContext.request.contextPath}"+'/inventorynew/loadinventory.htm';
				}
			}, null);
		}
}

function loginunpaidorderModule(pass)
{
	if(pass=='')
		{
		document.getElementById('unpaidordermoduleloginModalalertMsg').innerHTML='Please enter security code !';
		document.getElementById('unpaidordermodulepassword').focus();
		}
	else
		{
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax("${pageContext.request.contextPath}" + "/admin/loginadminmodule/"+pass  + ".htm", function(response) {
			if(response=='failure')
				{
				document.getElementById('unpaidordermoduleloginModalalertMsg').innerHTML='Invalid security code !';
				document.getElementById('unpaidordermodulepassword').focus();
				}
			else{
				closeloginunpaidordermoduleModal();
				location.href="${pageContext.request.contextPath}"+'/unpaidorder/viewunpaidorder.htm';
				}
			}, null);
		}
}
    		 <%-- <%
    		Store store=(Store)session.getAttribute(Constants.LOGGED_IN_STORE);
    		if(store.getCustomerDisplay().startsWith("COM")){%>
    	 	 <% Display display=new Display(store.getCustomerDisplay());
    			display.vfdWelcome(store.getCustomerDisplay());
    		}%> --%> 
    		
    	/* if('${sessionScope.loggedinStore.id}'=='37')
    		{
    		alert('hi');
    		$("link[rel*='icon']").attr("href","${pageContext.request.contextPath}/assets/images/title/fav_icon.png");
    		alert('bye');
    		} */
    		if('${sessionScope.loggedinStore.id}'=='37')
    		{
    			changeFavicon('${pageContext.request.contextPath}/assets/images/title/fav_icon.png');
    		}
    		if('${sessionScope.loggedinStore.id}'=='38')
    		{
    			changeFavicon('${pageContext.request.contextPath}/assets/images/title/fav_icon.png');
    		}
    		if('${sessionScope.loggedinStore.id}'=='39')
    		{
    			changeFavicon('${pageContext.request.contextPath}/assets/images/title/ht_fav-icon.png');
    		}
    		if('${sessionScope.loggedinStore.id}'=='41')
    		{
    			changeFavicon('${pageContext.request.contextPath}/assets/images/title/th_fav.png');
    		}
    		if('${sessionScope.loggedinStore.id}'=='35')
    		{
    			changeFavicon('${pageContext.request.contextPath}/assets/images/title/maru_fav.png');
    		}
    		function openLicenseInfoModal(){
    			$.ajax({
    				url : "${pageContext.request.contextPath}" + "/home/getlicenseinfo/" + ${sessionScope.loggedinStore.id} + ".htm",
    				type : 'GET',
    				// 				  contentType:'application/json;charset=utf-8',
    				//				  data: JSON.stringify(SpliBill),
    				success : function(response) {
    					//called when successful
//    						console.log(response);
    					var responseObj = JSON.parse(response);
    					$('#licenseinfomodal').modal('show');
    					$('#licvalidfrom').text(responseObj.from_date);
    					$('#licvalidto').text(responseObj.to_date);
    					$('#storeName').text(responseObj.storeName);
    					$('#licnoofuser').text(responseObj.no_of_users);
    				},
    				error : function(e) {
    					//called when there is an error
    					//console.log(e.message);
    				}
    			});
    		}
    		
    		
function loginReportModule(pass){
    			if(pass=='')
    			{
    			document.getElementById('reportmoduleloginModalalertMsg').innerHTML='Please enter security code !';
    			document.getElementById('reportmodulepassword').focus();
    			}
    		else
    			{
    			var ajaxCallObject = new CustomBrowserXMLObject();
    			ajaxCallObject.callAjax("${pageContext.request.contextPath}" + "/admin/loginadminmodule/"+pass  + ".htm", function(response) {
    				if(response=='failure')
    					{
    					document.getElementById('reportmoduleloginModalalertMsg').innerHTML='Invalid security code !';
    					document.getElementById('reportmodulepassword').focus();
    					}
    				else{
    					
    					closeloginReportmoduleModal();
    					/* location.href="${pageContext.request.contextPath}"+'/report/viewdaywisesales.htm'; */
    					/*  ajaxCallObject.callAjax("${pageContext.request.contextPath}" + "/report/getReportByStore.htm", function(response) 
    							{
    						
    							},null);  */
    					location.href="${pageContext.request.contextPath}"+'/report/getReportByStore.htm';  
    					
    					}
    				}, null);
    			}
   			}  	
   			
   			
   			
function changeTaxSetUp()
{
	
	$('#alertselectTaxModal').modal('show');
	
	
}

 var matchedOrderType=[];

  function selectedOrderType()
{
	var orderText=$('#orderType').find("option:selected").text();
     //alert("orderText:"+orderText);
	//console.log(JSON.parse(orderTypeList));
	
	//console.log("responseobject>>>" + responseObjOrderType.length);
	 for(var i=0; i<responseObjOrderType.length; i++)
		 {
		// alert("in for loop");

		 //   var orderType=responseObjOrderType[i];
		    //alert(orderTypeList[i]);
		 // console.log("orderType" + responseObjOrderType.orderTypeName);
		    if(orderText==responseObjOrderType[i].orderTypeName)
		    	{
		    	matchedOrderType=responseObjOrderType[i];
		    //	console.log(" in ordertype " + matchedOrderType.orderTypeName);

		    	}
		 
		 }
}
   

  		
/* $(document).ready(function() {
	

	 	var orderText=$('#orderType').find("option:selected").text();
 	//	alert("OrderText" + orderTypeList.size());

 		//console.log(sessionScope.ALL_ORDERTYPE_LIST);
		 for(var i=0; i<responseObjOrderType.length; i++)
			 {
		//	 alert("in for loop");
			   // var orderType=orderTypeList[i];
			  // alert(orderTypeList[i]);
			   if(orderText==responseObjOrderType[i].orderTypeName)
		    	{
		    	matchedOrderType=responseObjOrderType[i];
		    	document.getElementById('hiddenOrderType').innerHTML=matchedOrderType;
		    //	console.log(" in ordertype " + matchedOrderType.orderTypeName);

		    	}
			 
			 }
	

	  
	 });  
	  */
	 
    </script>
