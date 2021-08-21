<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<div class="col-md-2 col-sm-2">
	<div class="menu-category">
		<div style="padding: 8px;">
			<!-- for saravanaa -->
			<%-- <div class="item item-sub-child" style="background:#404040;" >
                    			<a href="#" style="font-weight:bold;cursor:auto; font-size:22px;">Reports</a>
                    	</div>
                    	<div class="item item-sub-child" style="background:#FF8576;" >
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/report/viewdaywisesales.htm'">DAY WISE SALES</a>
                    	</div>
                    	<c:choose>
                    		<c:when test="${sessionScope.loggedinStore.id ==37 || sessionScope.loggedinStore.id ==38}">
                    			<div class="item item-sub-child" style="background-color:#41A1E3;">
                    			<a href="javascript:location.href='${pageContext.request.contextPath}/report/viewdaywisehourlysales.htm'">HOURLY DAILY SALES</a>
                    			</div>
                    		</c:when>
                    		<c:otherwise>
                    			<div class="item item-sub-child" style="background-color:#41A1E3;">
                    			<a href="javascript:location.href='${pageContext.request.contextPath}/report/viewitemwisedailyorders.htm'">ITEM WISE DAILY ORDER</a>
                    			</div>
                    		</c:otherwise>
                    	</c:choose>
                    	
                    	<div class="item item-sub-child" style="background-color:#E0B12F;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/report/viewperiodwisesales.htm'">PERIOD WISE SALES</a>
                    	</div>
                    	<div class="item item-sub-child" style="background-color:#E0B12F;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/report/viewdaywisesummarysales.htm'">DAILY SALES SUMMARY</a>
                    	</div>
                    	<div class="item item-sub-child" style="background-color:#E0B12F;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/report/viewperiodwisesummarysales.htm'">PERIOD WISE SALES SUMMARY</a>
                    	</div> --%>
			<!-- end for saravanaa -->
			<%--                  <div style="overflow-y:auto; height: 430px;">
                        <div class="list-group panel" style="background:#404040; text-align:center;  text-transform:uppercase;">
                        <a href="#4" class="list-group-item" style="background:#1abb9c;" data-toggle="collapse" data-parent="#accord">Sales</a> 
                        <div class="collapse" id="4">
                		<div class="item item-sub-child" style="background:#FF8576;" >
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/report/viewdaywisesales.htm'">DAY WISE SALES</a>
                    	</div>
                    	<div class="item item-sub-child" style="background:#FE2E64;" >
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/report/viewdaytimewisesales.htm'">DAY TIME WISE SALES</a>
                    	</div>
                    	<div class="item item-sub-child" style="background-color:#073D91;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/report/viewuserwisedailysales.htm'">USER WISE DAILY SALES</a>
                    	</div>
                    	<div class="item item-sub-child" style="background-color:#41A1E3;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/report/viewitemwisedailyorders.htm'">ITEM WISE DAILY ORDER</a>
                    	</div>
                    	<div class="item item-sub-child" style="background-color:#41A1E3;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/report/viewitemwiseperiodorders.htm'">ITEM WISE PERIODIC ORDER</a>
                    	</div>
                    	<div class="item item-sub-child" style="background-color:#E0B12F;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/report/viewperiodwisesales.htm'">PERIOD WISE SALES</a>
                    	</div>
                    	<div class="item item-sub-child" style="background-color:#da84cb;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/report/viewdaywisesalescategory.htm'">CATEGORY WISE SALES</a>
                    	</div>
                    	<c:if test="${sessionScope.loggedinStore.creditSale=='Y'}">
                    	<div class="item item-sub-child" style="background-color:#7ca82f;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/report/viewperiodwisecreditsales.htm'">CREDIT SALES</a>
                    	</div>
                    	</c:if>
                    	<div class="item item-sub-child" style="background-color:#da84cb;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/report/viewperiodwisecancelorder.htm'">PERIOD WISE CANCEL ORDER</a>
                    	</div>
                    	<div class="item item-sub-child" style="background-color:#da84cb;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/report/viewperiodwisenockotorder.htm'">PERIOD WISE NOC ORDER</a>
                    	</div>
                    	</div>
                    	</div>
                    
                    	
                    	<div class="item item-sub-child" style="background-color:#E0B12F; margin: 5px 0;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/report/viewcurrentstock.htm'">CURRENT STOCK</a>
                    	</div>
						<div class="list-group panel" style="background:#404040; text-align:center;  text-transform:uppercase;">
                        		<a href="#1" class="list-group-item" style="background:#0CF;" data-toggle="collapse" data-parent="#accord">Purchase Order</a> 
                               
                                	<div class="collapse" id="1">
                                    		<a href="${pageContext.request.contextPath}/report/viewdaywisepo.htm" class="list-group-item" style="background:#999;">Daywise</a>
                                            <a href="${pageContext.request.contextPath}/report/viewperiodwisepo.htm" class="list-group-item" style="background:#999;">Periodwise</a>
                                    </div>
                                   <a href="#2" class="list-group-item " style="background:#0C3;" data-toggle="collapse" data-parent="#accord">Stock In</a> 
                                   	<div class="collapse" id="2">
                                    		<a href="${pageContext.request.contextPath}/report/viewdaywisestockin.htm" class="list-group-item" style="background:#999;">Daywise</a>
                                            <a href="${pageContext.request.contextPath}/report/viewperiodwisestockin.htm" class="list-group-item" style="background:#999;">Periodwise</a>
                                    </div>
                                    <a href="#3" class="list-group-item " style="background:#C60;" data-toggle="collapse" data-parent="#accord">Stock Out</a> 
                                   	<div class="collapse" id="3">
                                    		<a href="#3_1" class="list-group-item" style="background:#0C9;" data-toggle="collapse">Kitchenwise</a>
                                            <div class="collapse" id="3_1">
                                    			<a href="${pageContext.request.contextPath}/report/viewdaywisestockoutkitchen.htm" class="list-group-item" style="background:#999;">Daywise</a>
                                            	<a href="${pageContext.request.contextPath}/report/viewperiodwisestockoutkitchen.htm" class="list-group-item" style="background:#999;">Periodwise</a>
                                    		</div>
                                            <a href="#3_2" class="list-group-item" style="background:#0C9;" data-toggle="collapse">All</a>
                                             <div class="collapse" id="3_2">
                                            	<a href="${pageContext.request.contextPath}/report/viewdaywisestockoutallcat.htm" class="list-group-item" style="background:#999;">Daywise</a>
                                            	<a href="${pageContext.request.contextPath}/report/viewperiodwisestockoutallcat.htm" class="list-group-item" style="background:#999;">Periodwise</a>
                                             </div>
                                    </div>
                        </div>
                        <div class="item item-sub-child" style="background-color:#E0B12F; margin: 5px 0;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/report/viewgstinoutrptperiodwise.htm'">GST IN OUT</a>
                    	</div>
                    	
                    	<div class="item item-sub-child" style="background-color:#E0B12F; margin: 5px 0;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/report/getcustomerlist.htm'">CUSTOMER DETAILS</a>
                    	</div>
                    
                    	</div>
                    </div>
                </div> --%>



			<c:if test="${! empty sessionScope.posModuleObj }">

				<div style="overflow-y: auto; height: 430px;">
					<div class="list-group panel"
						style="background: #404040; text-align: center; text-transform: uppercase;">
						<a href="#4" class="list-group-item" style="background: #1abb9c;"
							data-toggle="collapse" data-parent="#accord"><spring:message
								code="admin.rptleftpanel.jsp.sales" text="Sales" /></a>
						<div class="collapse" id="4">
							<c:forEach items="${posModuleObj}" var="posModuleObjList">

								<c:if test="${posModuleObjList.moduleName=='DayWise_Sale'}">
									<div class="item item-sub-child" style="background: #FF8576;">
										<a
											href="javascript:location.href='${pageContext.request.contextPath}/report/viewdaywisesales.htm'">
											<spring:message code="admin.rptleftpanel.jsp.dayWiseSales"
												text="DAY WISE SALES" />
										</a>
									</div>
								</c:if>

								<c:if test="${posModuleObjList.moduleName=='DayTimeWise_Sale'}">
									<div class="item item-sub-child" style="background: #FE2E64;">
										<a
											href="javascript:location.href='${pageContext.request.contextPath}/report/viewdaytimewisesales.htm'">
											<spring:message
												code="admin.rptleftpanel.jsp.dayTimeWiseSales"
												text="DAY TIME WISE SALES" />
										</a>
									</div>
								</c:if>
								<c:if test="${posModuleObjList.moduleName=='hourly_sales'}">
									<div class="item item-sub-child" style="background: #073D91;">
										<a
											href="javascript:location.href='${pageContext.request.contextPath}/report/viewdaywisehourlysales.htm'">
											<spring:message
												code="admin.rptleftpanel.jsp.hourlyWiseSales"
												text="HOURLY SALES" />
										</a>
									</div>
								</c:if>
								
								
								
								<c:if test="${posModuleObjList.moduleName=='Period_Wise_Sale'}">
									<div class="item item-sub-child"
										style="background-color: #E0B12F;">
										<a
											href="javascript:location.href='${pageContext.request.contextPath}/report/viewperiodwisesales.htm'"><spring:message
												code="admin.rptleftpanel.jsp.periodWiseSale"
												text="PERIOD WISE SALES" /></a>
									</div>
								</c:if>

							
								<c:if
									test="${posModuleObjList.moduleName=='Cancel_Order_Report'}">
									<div class="item item-sub-child"
										style="background-color: #E0B12F;">
										<a
											href="javascript:location.href='${pageContext.request.contextPath}/report/viewperiodwisecancelorder.htm'">
											<spring:message code="admin.rptleftpanel.jsp.cancleWiseSales"
												text="PERIOD WISE CANCEL ORDER" />
										</a>
									</div>
								</c:if>



								<c:if test="${posModuleObjList.moduleName=='DayWiseUser_Sale'}">
									<div class="item item-sub-child"
										style="background-color: #073D91;">
										<a
											href="javascript:location.href='${pageContext.request.contextPath}/report/viewUserWiseDailySales.htm'">
											USER WISE DAILY SALES </a>
									</div>
								</c:if>

								<c:if
									test="${posModuleObjList.moduleName=='item_wise_order_day'}">
									<div class="item item-sub-child"
										style="background-color: #41A1E3;">
										<a
											href="javascript:location.href='${pageContext.request.contextPath}/report/viewitemwisedailyorders.htm'"><spring:message
												code="admin.rptleftpanel.jsp.itemWiseDailyOrder"
												text="ITEM WISE DAILY ORDER" /></a>
									</div>
								</c:if>

								<c:if
									test="${posModuleObjList.moduleName=='item_wise_order_period'}">
									<div class="item item-sub-child"
										style="background-color: #41A1E3;">
										<a
											href="javascript:location.href='${pageContext.request.contextPath}/report/viewitemwiseperiodorders.htm'"><spring:message
												code="admin.rptleftpanel.jsp.itemWisePeriodicOrder"
												text="ITEM WISE PERIODIC ORDER" /></a>
									</div>
								</c:if>

								<c:if
									test="${posModuleObjList.moduleName=='day_wise_settlement'}">
									<div class="item item-sub-child" style="background: #FE2E64;">
										<a
											href="javascript:location.href='${pageContext.request.contextPath}/report/viewpaymentmodewisesales.htm'"><spring:message
												code="admin.rptleftpanel.jsp.dayWiseSetelment"
												text="DAY WISE SETTLEMENT" /></a>
									</div>
								</c:if>

								<c:if
									test="${posModuleObjList.moduleName=='category_wise_sales'}">
									<div class="item item-sub-child"
										style="background-color: #da84cb;">
										<a
											href="javascript:location.href='${pageContext.request.contextPath}/report/viewdaywisesalescategory.htm'"><spring:message
												code="admin.rptleftpanel.jsp.catWiseSale"
												text="CATEGORY WISE SALES" /></a>
									</div>
								</c:if>

								<c:if
									test="${posModuleObjList.moduleName=='category_wise_periodic_sales'}">
									<div class="item item-sub-child"
										style="background-color: #da84cb;">
										<a
											href="javascript:location.href='${pageContext.request.contextPath}/report/viewcatwisesales.htm'"><spring:message
												code="admin.rptleftpanel.jsp.catWisePerodSales"
												text="CATEGORY WISE PERIODIC SALES" /></a>
									</div>
								</c:if>

								 <c:if
									test="${posModuleObjList.moduleName=='nonchargeable_kot'}">
									<div class="item item-sub-child"
										style="background-color: #FE2E64;">
										<a
											href="javascript:location.href='${pageContext.request.contextPath}/report/viewperiodwisenockotorder.htm'"><spring:message
												code="admin.rptleftpanel.jsp.nonchargablekot"
												text="NON-CHARGABLE KOT" /></a>
									</div>
								</c:if> 

							</c:forEach>
						</div>
					</div>
					<!----------------------- End Sales Menu ------------------------->


                   <c:if test="${sessionScope.loggedinStore.simpleIm=='Y'}">
					<c:forEach items="${posModuleObj}" var="posModuleObjList">
						<c:if test="${posModuleObjList.moduleName=='current_stock'}">
							<div class="item item-sub-child"
								style="background-color: #E0B12F; margin: 5px 0;">
								<a
									href="javascript:location.href='${pageContext.request.contextPath}/report/viewcurrentstock.htm'"><spring:message
										code="admin.rptleftpanel.jsp.curStock" text="CURRENT STOCK" /></a>
							</div>
						</c:if>
					</c:forEach>
					</c:if>
					
					
					
					<c:if test="${sessionScope.loggedinStore.creditSale=='Y'}">
                    			<div class="item item-sub-child" style="background-color:#7ca82f; margin: 5px 0;">
                    				<a href="javascript:location.href='${pageContext.request.contextPath}/report/viewperiodwisecreditsales.htm'">CREDIT SALES</a>
                    			</div>
                    		</c:if>
                    		
					<div class="list-group panel"
						style="background: #404040; text-align: center; text-transform: uppercase;">


              <c:if test="${sessionScope.loggedinStore.simpleIm=='Y'}">
                      
						<c:set var="po" value="0"></c:set>
						<c:forEach items="${posModuleObj}" var="posModuleObjList"
							begin="0" end="40" step="1" varStatus="loop">
							<!-- begin="0" end="20" step="1" -->
							<c:if
								test="${posModuleObjList.moduleName=='DayWise_PO' || posModuleObjList.moduleName=='PeriodWise_PO'}">
								<c:if test="${po == 0}">

									<a href="#1" class="list-group-item" style="background: #0CF;"
										data-toggle="collapse" data-parent="#accord"> <spring:message
											code="admin.rptleftpanel.jsp.purchaseOrder"
											text="Purchase Order" />
									</a>

								</c:if>
								<c:set var="po" value="${loop.count}"></c:set>
							</c:if>
						</c:forEach>

						<div class="collapse" id="1">


							<c:forEach items="${posModuleObj}" var="posModuleObjList">

								<c:if test="${posModuleObjList.moduleName=='DayWise_PO'}">
									<a
										href="${pageContext.request.contextPath}/report/viewdaywisepo.htm"
										class="list-group-item" style="background: #999;"><spring:message
											code="admin.rptleftpanel.jsp.dayWise" text="Daywise" /></a>
								</c:if>
								<c:if test="${posModuleObjList.moduleName=='PeriodWise_PO'}">
									<a
										href="${pageContext.request.contextPath}/report/viewperiodwisepo.htm"
										class="list-group-item" style="background: #999;"><spring:message
											code="admin.rptleftpanel.jsp.periodWise" text="Periodwise" /></a>

								</c:if>

							</c:forEach>
						</div>
               </c:if>
           <!-- ************** For RAW STOCK IN  *************** -->          
            <c:if test="${sessionScope.loggedinStore.simpleIm=='Y'}">
                 <c:set var="rawStIn" value="0"></c:set>
						<c:forEach items="${posModuleObj}" var="posModuleObjList"
							begin="0" end="40" step="1" varStatus="loop">
							<c:if test="${posModuleObjList.moduleName=='raw_stockin_register' || posModuleObjList.moduleName=='raw_stockin_summary' ||  posModuleObjList.moduleName=='raw_stockin_itemwise'}">
								<c:if test="${rawStIn == 0}">
									<a  href="#2" class="list-group-item " style="background: #0C3;"
									    data-toggle="collapse" data-parent="#accord">
										 <spring:message code="admin.rptleftpanel.jsp.rawstockIn" text="RAW STOCK IN" /></a>
								</c:if>
								<c:set var="rawStIn" value="${loop.count}"></c:set>
							</c:if>
						</c:forEach>
						<div class="collapse" id="2">
							<c:forEach items="${posModuleObj}" var="posModuleObjList">
								<c:if test="${posModuleObjList.moduleName=='raw_stockin_summary'}">
									<a href="${pageContext.request.contextPath}/report/viewrawstockinsummary.htm"
										class="list-group-item" style="background: #999;"><spring:message
									    code="base.rptleftpanel.jsp.rpt.summary" text="SUMMARY" /></a>
								</c:if>
								<c:if test="${posModuleObjList.moduleName=='raw_stockin_register'}">
									<a href="${pageContext.request.contextPath}/report/viewrawstockinregister.htm"
									   class="list-group-item" style="background: #999;"><spring:message
									   code="base.rptleftpanel.jsp.rpt.register" text="REGISTER" /></a>
								</c:if>
								<c:if test="${posModuleObjList.moduleName=='raw_stockin_itemwise'}">
									<a  href="${pageContext.request.contextPath}/report/viewrawstockinitemwise.htm"
										class="list-group-item" style="background: #999;"><spring:message
										code="base.rptleftpanel.jsp.rpt.itemwise" text="ITEM WISE" /></a>
								</c:if>
							</c:forEach>
						</div>
			</c:if>	 
			<!-- ************** For FG STOCK IN  *************** -->          
           <c:if test="${sessionScope.loggedinStore.simpleIm=='Y'}">
                 <c:set var="fgStIn" value="0"></c:set>
						 <c:forEach items="${posModuleObj}" var="posModuleObjList"
							begin="0" end="49" step="1" varStatus="loop"> 
							 <c:if test="${posModuleObjList.moduleName == 'fg_stockin_summary' || posModuleObjList.moduleName == 'fg_stockin_register' ||  posModuleObjList.moduleName == 'fg_stockin_itemwise'}"> 
								<c:if test="${fgStIn == 0}">
									<a  href="#22" class="list-group-item " style="background: #0C3;"
									    data-toggle="collapse" data-parent="#accord">
										 <spring:message code="base.rptleftpanel.jsp.fgstockIn" text="FG STOCK IN" /></a>
								</c:if>
								<c:set var="fgStIn" value="${loop.count}"></c:set>
							</c:if> 
						 </c:forEach>  
						<div class="collapse" id="22">
							<c:forEach items="${posModuleObj}" var="posModuleObjList">
								<c:if test="${posModuleObjList.moduleName=='fg_stockin_summary'}">
									<a href="${pageContext.request.contextPath}/report/viewfgstockinsummary.htm"
										class="list-group-item" style="background: #999;"><spring:message
									    code="base.rptleftpanel.jsp.rpt.summary" text="SUMMARY" /></a>
								</c:if>
								<c:if test="${posModuleObjList.moduleName=='fg_stockin_register'}">
									<a href="${pageContext.request.contextPath}/report/viewfgstockinregister.htm"
									   class="list-group-item" style="background: #999;"><spring:message
									   code="base.rptleftpanel.jsp.rpt.register" text="REGISTER" /></a>
								</c:if>
								<c:if test="${posModuleObjList.moduleName=='fg_stockin_itemwise'}">
									<a  href="${pageContext.request.contextPath}/report/viewfgstockinitemwise.htm"
										class="list-group-item" style="background: #999;"><spring:message
										code="base.rptleftpanel.jsp.rpt.itemwise" text="ITEM WISE" /></a>
								</c:if>
							</c:forEach>
						</div>
			</c:if>			
					
					
       <!-- ************** For RAW STOCK RETURN  *************** -->          
            <c:if test="${sessionScope.loggedinStore.simpleIm=='Y'}">
                 <c:set var="stIn3" value="0"></c:set>
						 <c:forEach items="${posModuleObj}" var="posModuleObjList"
							begin="0" end="49" step="1" varStatus="loop">
							<c:if test="${posModuleObjList.moduleName=='raw_stockin_return_register' || posModuleObjList.moduleName=='raw_stockin_return_summary' ||  posModuleObjList.moduleName=='raw_stockin_return_itemwise'}">
								<c:if test="${stIn3 == 0}">
									<a  href="#21" class="list-group-item " style="background: #0C3;"
									    data-toggle="collapse" data-parent="#accord">
										 <spring:message code="base.rptleftpanel.jsp.rawstockReturn" text="RAW STOCK RETURN" /></a>
								</c:if>
								<c:set var="stIn3" value="${loop.count}"></c:set>
							</c:if>
						</c:forEach> 
						<div class="collapse" id="21">
							<c:forEach items="${posModuleObj}" var="posModuleObjList">
								<c:if test="${posModuleObjList.moduleName=='raw_stockin_return_summary'}">
									<a href="${pageContext.request.contextPath}/report/viewrawstockreturnsummary.htm"
										class="list-group-item" style="background: #999;"><spring:message
									    code="base.rptleftpanel.jsp.rpt.summary" text="SUMMARY" /></a>
								</c:if>
								<c:if test="${posModuleObjList.moduleName=='raw_stockin_return_register'}">
									<a href="${pageContext.request.contextPath}/report/viewrawstockreturnregister.htm"
									   class="list-group-item" style="background: #999;"><spring:message
									   code="base.rptleftpanel.jsp.rpt.register" text="REGISTER" /></a>
								</c:if>
								<c:if test="${posModuleObjList.moduleName=='raw_stockin_return_itemwise'}">
									<a  href="${pageContext.request.contextPath}/report/viewrawstockreturnitemwise.htm"
										class="list-group-item" style="background: #999;"><spring:message
										code="base.rptleftpanel.jsp.rpt.itemwise" text="ITEM WISE" /></a>
								</c:if>
							</c:forEach>
						</div>
			</c:if>		
				 <!-- ************** For FG STOCK RETURN  *************** -->          
           <c:if test="${sessionScope.loggedinStore.simpleIm=='Y'}">
                 <c:set var="stIn" value="0"></c:set>
						 <c:forEach items="${posModuleObj}" var="posModuleObjList"
							begin="0" end="49" step="1" varStatus="loop">
							<c:if test="${posModuleObjList.moduleName=='fg_stockin_return_register' || posModuleObjList.moduleName=='fg_stockin_return_summary' || posModuleObjList.moduleName=='fg_stockin_return_itemwise'}">
							 	<c:if test="${stIn == 0}">
									<a  href="#23" class="list-group-item " style="background: #0C3;"
									    data-toggle="collapse" data-parent="#accord">
										 <spring:message code="base.rptleftpanel.jsp.fgtockReturn" text="FG STOCK RETURN" /></a>
								</c:if>
								 <c:set var="stIn" value="${loop.count}"></c:set>
							</c:if>
						</c:forEach> 
						<div class="collapse" id="23">
							<c:forEach items="${posModuleObj}" var="posModuleObjList">
								<c:if test="${posModuleObjList.moduleName=='fg_stockin_return_summary'}">
									<a href="${pageContext.request.contextPath}/report/viewfgstockreturnsummary.htm"
										class="list-group-item" style="background: #999;"><spring:message
									    code="base.rptleftpanel.jsp.rpt.summary" text="SUMMARY" /></a>
								</c:if>
								<c:if test="${posModuleObjList.moduleName=='fg_stockin_return_register'}">
									<a href="${pageContext.request.contextPath}/report/viewfgstockreturnregister.htm"
									   class="list-group-item" style="background: #999;"><spring:message
									   code="base.rptleftpanel.jsp.rpt.register" text="REGISTER" /></a>
								</c:if>
								<c:if test="${posModuleObjList.moduleName=='fg_stockin_return_itemwise'}">
									<a  href="${pageContext.request.contextPath}/report/viewfgstockreturnitemwise.htm"
										class="list-group-item" style="background: #999;"><spring:message
										code="base.rptleftpanel.jsp.rpt.itemwise" text="ITEM WISE" /></a>
								</c:if>
							</c:forEach>
						</div>
			</c:if>				
					
					
					
					
					
						
						
						
						<!-- ************** For StockOut  *************** -->
						 
     <c:if test="${sessionScope.loggedinStore.simpleIm=='Y'}">
						
					   <c:set var="so" value="0"></c:set>
						<c:forEach items="${posModuleObj}" var="posModuleObjList"
							begin="0" end="40" step="1" varStatus="loop">
							<c:if
								test="${posModuleObjList.moduleName=='StockOut_KitchenWise_DayWise' || posModuleObjList.moduleName=='StockOut_KitchenWise_PeriodWise' || posModuleObjList.moduleName=='StockOut_All_DayWise' || posModuleObjList.moduleName=='StockOut_All_PeriodWise'}">
								<c:if test="${so == 0}">

									<a href="#3" class="list-group-item " style="background: #C60;"
										data-toggle="collapse" data-parent="#accord"><spring:message
											code="admin.rptleftpanel.jsp.stockOut" text="Stock Out" /></a>
								</c:if>
								<c:set var="so" value="${loop.count}"></c:set>
							</c:if>
						</c:forEach>

						<div class="collapse" id="3">
							<!-- ************** For StockOut All  *************** -->
							<c:set var="kt" value="0"></c:set>
							<c:forEach items="${posModuleObj}" var="posModuleObjList"
								begin="0" end="40" step="1" varStatus="loop">
								<c:if
									test="${posModuleObjList.moduleName=='StockOut_KitchenWise_DayWise' || posModuleObjList.moduleName=='StockOut_KitchenWise_PeriodWise'}">
									<c:if test="${kt == 0}">

										<a href="#3_1" class="list-group-item"
											style="background: #0C9;" data-toggle="collapse"><spring:message
												code="admin.rptleftpanel.jsp.kitchenWise" text="Kitchenwise" /></a>

									</c:if>
									<c:set var="kt" value="${loop.count}"></c:set>
								</c:if>
							</c:forEach>

							<div class="collapse" id="3_1">
								<c:forEach items="${posModuleObj}" var="posModuleObjList">
									<c:if
										test="${posModuleObjList.moduleName=='StockOut_KitchenWise_DayWise'}">
										<a
											href="${pageContext.request.contextPath}/report/viewdaywisestockoutkitchen.htm"
											class="list-group-item" style="background: #999;"><spring:message
												code="admin.rptleftpanel.jsp.dayWise" text="Daywise" /></a>
									</c:if>
									<c:if
										test="${posModuleObjList.moduleName=='StockOut_KitchenWise_PeriodWise'}">
										<a
											href="${pageContext.request.contextPath}/report/viewperiodwisestockoutkitchen.htm"
											class="list-group-item" style="background: #999;"><spring:message
												code="admin.rptleftpanel.jsp.periodWise" text="Periodwise" /></a>

									</c:if>
								</c:forEach>
							</div>

							<!--  ************** For StockOut All  *************** -->
							<c:set var="all" value="0"></c:set>
							<c:forEach items="${posModuleObj}" var="posModuleObjList"
								begin="0" end="40" step="1" varStatus="loop">
								<c:if
									test="${posModuleObjList.moduleName=='StockOut_All_DayWise' || posModuleObjList.moduleName=='StockOut_All_PeriodWise'}">
									<c:if test="${all == 0}">

										<a href="#3_2" class="list-group-item"
											style="background: #0C9;" data-toggle="collapse"><spring:message
												code="admin.rptleftpanel.jsp.all" text="All" /></a>

									</c:if>
									<c:set var="all" value="${loop.count}"></c:set>
								</c:if>
							</c:forEach>
							<div class="collapse" id="3_2">
								<c:forEach items="${posModuleObj}" var="posModuleObjList">
									<c:if
										test="${posModuleObjList.moduleName=='StockOut_All_DayWise'}">
										<a
											href="${pageContext.request.contextPath}/report/viewdaywisestockoutallcat.htm"
											class="list-group-item" style="background: #999;"><spring:message
												code="admin.rptleftpanel.jsp.dayWise" text="Daywise" /></a>
									</c:if>
									<c:if
										test="${posModuleObjList.moduleName=='StockOut_All_PeriodWise'}">
										<a
											href="${pageContext.request.contextPath}/report/viewperiodwisestockoutallcat.htm"
											class="list-group-item" style="background: #999;"><spring:message
												code="admin.rptleftpanel.jsp.periodWise" text="Periodwise" /></a>
									</c:if>
								</c:forEach>

							</div>
						</div>
		</c:if>	
					<%-- 	<c:set var="po" value="0"></c:set>
						<c:forEach items="${posModuleObj}" var="posModuleObjList"
							begin="0" end="40" step="1" varStatus="loop">
							<!-- begin="0" end="20" step="1" -->
							<c:if
								test="${posModuleObjList.moduleName=='DayWise_PO' || posModuleObjList.moduleName=='PeriodWise_PO'}">
								<c:if test="${po == 0}"> --%>

									<a href="#5" class="list-group-item" style="background: #0CF;"
										data-toggle="collapse" data-parent="#accord"> Customer
									</a>

							<%-- 	</c:if>
								<c:set var="po" value="${loop.count}"></c:set>
							</c:if>
						</c:forEach> --%>

						<div class="collapse" id="5">


						<%-- 	<c:forEach items="${posModuleObj}" var="posModuleObjList">

								<c:if test="${posModuleObjList.moduleName=='DayWise_PO'}"> --%>
								<a
										href="javascript:location.href='${pageContext.request.contextPath}/report/getcustomerlist.htm'"
										class="list-group-item" style="background: #999;">CUSTOMER DETAILS</a>
									<a
										href="${pageContext.request.contextPath}/report/viewtopcustomer.htm"
										class="list-group-item" style="background: #999;">TOP CUSTOMER</a>
<%-- 								</c:if>  
								<c:if test="${posModuleObjList.moduleName=='PeriodWise_PO'}">--%>
								
								<a href="${pageContext.request.contextPath}/report/viewnewvsrepeat.htm"
										class="list-group-item" style="background: #999;">NEW V/S REPEAT CUSTOMER(AMT. & COUNT)</a>
									 <a
										href="${pageContext.request.contextPath}/report/viewoutstandingcustomer.htm"
										class="list-group-item" style="background: #999;">OUTSTANDING CUSTOMER</a>

 							<%-- </c:if>
 							<a
										href="${pageContext.request.contextPath}/report/viewperiodwisepo.htm"
										class="list-group-item" style="background: #999;">Outstanding Customer</a>

							</c:forEach> --%>
						</div>

					</div>

					<%-- <c:forEach items="${posModuleObj}" var="posModuleObjList">
						<c:if test="${posModuleObjList.moduleName=='current_stock'}">
							<div class="item item-sub-child"
								style="background-color: #E0B12F; margin: 5px 0;">
								<a
									href="javascript:location.href='${pageContext.request.contextPath}/report/getcustomerlist.htm'"><spring:message
										code="admin.rptleftpanel.jsp.custDetails"
										text="CUSTOMER DETAILS" /></a>
							</div>
						</c:if>
					</c:forEach> --%>
					
					
					 <c:if 
						test="${sessionScope.loggedinStore.deliveryBoyFlag=='Y'}">
						<div class="item item-sub-child"
								style="background-color: #E0B12F; margin: 5px 0;">
								<a href="javascript:location.href='${pageContext.request.contextPath}/report/vieworderwisedeliveryboy.htm'"> 
									<c:choose>
									    <c:when test="${sessionScope.loggedinStore.id==168}">
									      ORDERS & DOCTORS
									     </c:when>    
									    <c:otherwise>
									       ORDERS & DELIVERY BOYS
									    </c:otherwise>
									</c:choose>
								</a>
							</div>
					</c:if> 

					<c:forEach items="${posModuleObj}" var="posModuleObjList">
						<%-- <c:if
							test="${posModuleObjList.moduleName=='Cancel_Order_Report_Celavi'}">
							<div class="item item-sub-child"
								style="background-color: #E0B12F; margin: 5px 0;">
								<a
									href="javascript:location.href='${pageContext.request.contextPath}/report/viewcancelorderreasonrpt.htm'">Cancel
									Order</a>
							</div>
						</c:if> --%>
						<c:if test="${posModuleObjList.moduleName=='Expenditure_Details_Report'}">
							<div class="item item-sub-child"
								style="background-color: #E0B12F; margin: 5px 0;">
								<a
									href="javascript:location.href='${pageContext.request.contextPath}/report/viewcancelorderreasonrpt.htm'">Expenditure Details</a>
							</div>
						</c:if>
					</c:forEach>

					<c:forEach items="${posModuleObj}" var="posModuleObjList">
						<c:if
							test="${posModuleObjList.moduleName=='daily_sales_report_celavi'}">
							<div class="item item-sub-child"
								style="background-color: #E0B12F; margin: 5px 0;">
								<a
									href="javascript:location.href='${pageContext.request.contextPath}/report/viewdailysalescelavirpt.htm'">Daily
									Sales</a>
							</div>
						</c:if>
					</c:forEach>
					<c:forEach items="${posModuleObj}" var="posModuleObjList">
						<c:if
							test="${posModuleObjList.moduleName=='discount_report_celavi'}">
							<div class="item item-sub-child"
								style="background-color: #E0B12F; margin: 5px 0;">
								<a
									href="javascript:location.href='${pageContext.request.contextPath}/report/viewdiscountreasonrpt.htm'">Discounted
									Order</a>
							</div>
						</c:if>
					</c:forEach>
					<c:forEach items="${posModuleObj}" var="posModuleObjList">
						<c:if
							test="${posModuleObjList.moduleName=='nonchargeable_report_celavi'}">
							<div class="item item-sub-child"
								style="background-color: #E0B12F; margin: 5px 0;">
								<a
									href="javascript:location.href='${pageContext.request.contextPath}/report/viewnonchargeableorderrpt.htm'">Non-Chargeable</a>
							</div>
						</c:if>
					</c:forEach>
					<c:forEach items="${posModuleObj}" var="posModuleObjList">
						<c:if
							test="${posModuleObjList.moduleName=='payment_report_celavi'}">
							<div class="item item-sub-child"
								style="background-color: #E0B12F; margin: 5px 0;">
								<a
									href="javascript:location.href='${pageContext.request.contextPath}/report/viewpaymentwiserpt.htm'">Payment
									Wise</a>
							</div>
						</c:if>
					</c:forEach>
					<c:forEach items="${posModuleObj}" var="posModuleObjList">
						<c:if
							test="${posModuleObjList.moduleName=='daily_sales_inclusive_taxes_report_celavi'}">
							<div class="item item-sub-child"
								style="background-color: #E0B12F; margin: 5px 0;">
								<a
									href="javascript:location.href='${pageContext.request.contextPath}/report/viewdailysalesinclusiverpt.htm'">Sales
									Inclusive Tax</a>
							</div>
						</c:if>
					</c:forEach>
					<c:forEach items="${posModuleObj}" var="posModuleObjList">
						<c:if
							test="${posModuleObjList.moduleName=='monthly_summary_report_celavi'}">
							<div class="item item-sub-child"
								style="background-color: #E0B12F; margin: 5px 0;">
								<a
									href="javascript:location.href='${pageContext.request.contextPath}/report/viewdailysalessummaryrpt.htm'">Sales
									Summary</a>
							</div>
						</c:if>
					</c:forEach>
						<!--start refund report -->
							<c:if test="${sessionScope.loggedinStore.isRefund=='Y'}">
								<c:set var="redunds" value="0"></c:set>
								<c:forEach items="${posModuleObj}" var="posModuleObjList"
									begin="0" end="40" step="1" varStatus="loop">
									<c:if
										test="${posModuleObjList.moduleName=='refund_summary' || posModuleObjList.moduleName=='refund_details'}">
										<c:if test="${redunds == 0}">
											<a href="#refundrpt" class="list-group-item "
												style="background: #0CF; text-align: center;"
												data-toggle="collapse" data-parent="#accord"><spring:message
													code="paidorder.jsp.REFUND" text="REFUND" /></a>
										</c:if>
										<c:set var="redunds" value="${loop.count}"></c:set>
									</c:if>
								</c:forEach>
								<div class="collapse" id="refundrpt">
									<c:forEach items="${posModuleObj}" var="posModuleObjList">
										<c:if test="${posModuleObjList.moduleName=='refund_summary'}">
											<a
												href="${pageContext.request.contextPath}/report/viewrefundsummary.htm"
												class="list-group-item"
												style="background: #999; text-align: center;"><spring:message
													code="admin.rptleftpanel.jsp.refundsummary"
													text="Refund Summary" /></a>
										</c:if>
										<c:if test="${posModuleObjList.moduleName=='refund_details'}">
											<a
												href="${pageContext.request.contextPath}/report/viewrefunddetails.htm"
												class="list-group-item"
												style="background: #999; text-align: center;"><spring:message
													code="admin.rptleftpanel.jsp.refunddetails"
													text="Refund Details" /></a>
										</c:if>
									</c:forEach>
								</div>
							</c:if>
							<!-- end refund report -->
					 <!--start accounts report -->               
			    <c:set var="accounts" value="0"></c:set>
				<c:forEach items="${posModuleObj}" var="posModuleObjList" begin="0" end="40" step="1" varStatus="loop" >
				<c:if test="${posModuleObjList.moduleName=='pl_statement' || posModuleObjList.moduleName=='tax_inout'}">
				<c:if test="${accounts == 0}">
				<a href="#accrpt" class="list-group-item " style="background: #0C3;text-align: center;"
				data-toggle="collapse" data-parent="#accord"><spring:message
				code="admin.rptleftpanel.jsp.account" text="ACCOUNT" /></a>
				</c:if>
				<c:set var="accounts" value="${loop.count}"></c:set>
				</c:if>
				</c:forEach>
				<div class="collapse" id="accrpt">
							<c:forEach items="${posModuleObj}" var="posModuleObjList">
								<c:if test="${posModuleObjList.moduleName=='pl_statement'}">
									<a href="${pageContext.request.contextPath}/report/viewplstatement.htm"
										class="list-group-item" style="background: #999;text-align: center;"><spring:message
											code="admin.rptleftpanel.jsp.plstatement" text="P&L Statement" /></a>
								</c:if>
								<c:if
									test="${posModuleObjList.moduleName=='tax_inout'}">									
									 <a href="${pageContext.request.contextPath}/report/viewtaxstatement.htm"
										class="list-group-item" style="background: #999;text-align: center;"><spring:message
											code="admin.rptleftpanel.jsp.taxstatement" text="Tax Statement" /></a>
								</c:if>
							</c:forEach>
						</div>
						
               <!-- end accounts report -->
					<c:forEach items="${posModuleObj}" var="posModuleObjList">
						<c:if
							test="${posModuleObjList.moduleName=='tax_summary'}">
							<div class="item item-sub-child"
								style="background-color: #E0B12F; margin: 5px 0;">
								<a
									href="javascript:location.href='${pageContext.request.contextPath}/report/viewtaxsummary.htm'">TAX
									SUMMARY</a>
							</div>
						</c:if>
					</c:forEach>
					
				</div>

			</c:if>

		</div>
	</div>
</div>
