<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
		<div class="col-md-2 col-sm-2">
                <div class="menu-category" style="height:100%;">
                	<div style="overflow-y:auto;height:500px;">
                	<div style="padding:5px;">
                    	<!-- <div class="item" style="margin-bottom:10px;">
                        </div> -->
                       <div class="item item-sub-child" style="background:#FF8576;" >
                    		<a href="javascript:viewDashboard()">DASHBOARD</a>
                    	</div>
                		<div class="item item-sub-child" style="background:#FF8576;" >
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/menumgnt/viewmenumgnt.htm'">CATEGORIES</a>
                    	</div>
                    	<div class="item item-sub-child" style="background-color:#41A1E3;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/menumgnt/loadsubcategory.htm'">SUB CATEGORIES</a>
                    	</div>
                    	<div class="item item-sub-child" style="background-color:#E0B12F;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/menumgnt/loadmenuitems.htm'">MENU ITEMS</a>
                    	</div>
                    	<div class="item item-sub-child" style="background-color:#FF8576; margin-top:20px;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/tablemgnt/loadtablemgnt.htm'">TABLES</a>
                    	</div>
                    	<c:if test="${sessionScope.loggedinStore.advOrder=='Y'}">  
                         <div class="item item-sub-child" style="background-color:#FF8576;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/advancebooking/loadadvancebooking.htm'">ADV BOOKING</a>
                    	</div>
                       </c:if>  
                    	<div class="item item-sub-child" style="background-color:#41A1E3; margin-top:20px;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/unpaidorderlist/loadunpaidorder.htm'">UNPAID ORDERS</a>
                    	</div>
                    	<div class="item item-sub-child" style="background-color:#41A1E3; margin-top:10px;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/taxmgnt/viewtaxmgnt.htm'">TAX SETUP</a>
                    	</div>
                    <c:if test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}">
                     <div class="item item-sub-child" style="background-color:#FF8576;">
                      <a href="javascript:location.href='${pageContext.request.contextPath}/servicecharge/viewservicecharge.htm'">SERVICE CHARGE SETUP</a>
                     </div>
                     </c:if>
                     
                 <c:if test="${sessionScope.loggedinStore.simpleIm=='Y'}">
         
                    	<div class="item item-sub-child" style="background-color:#FF8576; margin-top:20px;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/vendormgnt/loadvendormgnt.htm'">VENDOR</a>
                    	</div>
                    	<div class="item item-sub-child" style="background-color:#41A1E3;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/inventorymgnt/loadinvtypemgnt.htm'">INVENTORY TYPE</a>
                    	</div> 
                    	 <div class="item item-sub-child" style="background-color:#E0B12F;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/inventorymgnt/loadsimpleinvitemmgnt.htm'">INVENTORY ITEM</a>
                    	</div> 
                    	<%-- <div class="item item-sub-child" style="background-color:#E0B12F;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/inventorymgnt/loadinvitemmgnt.htm'">SIMPLE INVENTORY ITEM</a>
                    	</div>
                    	 --%>
                    	 <div class="item item-sub-child" style="background-color:#41A1E3;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/vendormgnt/loadvendorpayment.htm'">VENDOR PAYMENT</a>
                    	</div>
                    	<div class="item item-sub-child" style="background-color:#41A1E3;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/vendormgnt/loadfgvendorpayment.htm'">FG VENDOR PAYMENT</a>
                    	</div>
                   </c:if>
                    	 
                     	<div class="item item-sub-child" style="background-color:#FF8576;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/menumgnt/viewmenuitemupload.htm'">UPLOAD MENU</a> 
                    	</div> 
                    	 <div class="item item-sub-child" style="background-color:#FF8576;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/expendituremgmt/loadexpendituremgmt.htm'">DAILY EXPENDITURE</a>
                    	</div>
                    	<div class="item item-sub-child" style="background-color:#FF8576;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/expendituremgmt/viewdailyexpenditure.htm'">VIEW PERIODWISE  EXPENDITURE</a>
                    	</div> 
                    	<c:if test="${sessionScope.loggedinStore.creditSale=='Y'}">
                    	<div class="item item-sub-child" style="background-color:#FF8576; margin-top:20px;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/storecustomermgnt/loadstorecustomermgnt.htm'">CUSTOMER</a>
                    	</div>
                    	<div class="item item-sub-child" style="background-color:#41A1E3;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/creditsale/loadcreditcustomer.htm'">CREDIT SALE</a>
                    	</div>
                    	</c:if>
                    	 <c:if test="${sessionScope.loggedinStore.isRefund=='Y'}">
							<div class="item item-sub-child" style="background: purple;">
								<a href="javascript:location.href='${pageContext.request.contextPath}/order/openorderrefund.htm'">ORDER REFUND</a>
							</div> 
						 </c:if>
                    	 <c:if test="${sessionScope.loggedinStore.deliveryBoyFlag=='Y'}">
                    	<div class="item item-sub-child" style="background-color:#41A1E3;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/deliveryboy/viewdeliveryboy.htm'">
                    		<c:choose>
							    <c:when test="${sessionScope.loggedinStore.id==168}">
							     DOCTOR
							     </c:when>    
							    <c:otherwise>
							       DELIVERY BOY
							    </c:otherwise>
							</c:choose>
                    		 
                    		</a>
                    	</div>
                    	 </c:if>
                    
                    
                    </div>
                    </div>
                </div>
           </div>
           <script src="${pageContext.request.contextPath}/assets/js/adminleftpanel.js"></script>  
           <script type="text/javascript">
           var BASE_URL="${pageContext.request.contextPath}";
           </script>