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
                    		<a href="javascript:viewCategory()">CATEGORIES</a>
                    	</div>
                    	<div class="item item-sub-child" style="background-color:#41A1E3;">
                    		<a href="javascript:loadSubCategory()">SUB CATEGORIES</a>
                    	</div>
                    	<div class="item item-sub-child" style="background-color:#E0B12F;">
                    		<a href="javascript:loadMenuItems()">MENU ITEMS</a>
                    	</div>
                    	<!-- <div class="item item-sub-child" style="background-color:#FF8576; margin-top:20px;">
                    		<a href="javascript:tableManagement()">TABLES</a>
                    	</div> -->
                    	<c:if test="${sessionScope.loggedinStore.advOrder=='Y'}">  
                         <div class="item item-sub-child" style="background-color:#FF8576;">
                    		<a href="javascript:advanceBooking()">ADV BOOKING</a>
                    	</div>
                       </c:if>  
                    	<div class="item item-sub-child" style="background-color:#41A1E3; margin-top:20px;">
                    		<a href="javascript:loadUnpaidOrder()">UNPAID ORDERS</a>
                    	</div>
                    	<div class="item item-sub-child" style="background-color:#41A1E3; margin-top:10px;">
                    		<a href="javascript:viewTaxManagement()">TAX SETUP</a>
                    	</div>
                    <c:if test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}">
                     <div class="item item-sub-child" style="background-color:#FF8576;">
                      <a href="javascript:viewServiceCharge()">SERVICE CHARGE SETUP</a>
                     </div>
                     </c:if>
                     
                 <c:if test="${sessionScope.loggedinStore.simpleIm=='Y'}">
         
                    	<div class="item item-sub-child" style="background-color:#FF8576; margin-top:20px;">
                    		<a href="javascript:loadVendorManagement()">VENDOR</a>
                    	</div>
                    	<div class="item item-sub-child" style="background-color:#41A1E3;">
                    		<a href="javascript:loadInventoryType()">INVENTORY TYPE</a>
                    	</div> 
                    	 <div class="item item-sub-child" style="background-color:#E0B12F;">
                    		<a href="javascript:loadInventoryItem()">INVENTORY ITEM</a>
                    	</div> 
                    	<%-- <div class="item item-sub-child" style="background-color:#E0B12F;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/inventorymgnt/loadinvitemmgnt.htm'">SIMPLE INVENTORY ITEM</a>
                    	</div>
                    	 --%>
                    	 <div class="item item-sub-child" style="background-color:#41A1E3;">
                    		<a href="javascript:loadVendorPayment()">VENDOR PAYMENT</a>
                    	</div>
                    	<div class="item item-sub-child" style="background-color:#41A1E3;">
                    		<a href="javascript:loadFGVendorPayment()">FG VENDOR PAYMENT</a>
                    	</div>
                   </c:if>
                    	 
                     	<div class="item item-sub-child" style="background-color:#FF8576;">
                    		<a href="javascript:viewMenuItemUpload()">UPLOAD MENU</a> 
                    	</div> 
                    	 <div class="item item-sub-child" style="background-color:#FF8576;">
                    		<a href="javascript:loadDailyExpenditure()">DAILY EXPENDITURE</a>
                    	</div>
                    	<div class="item item-sub-child" style="background-color:#FF8576;">
                    		<a href="javascript:viewPeriodExpenditure()">VIEW PERIODWISE  EXPENDITURE</a>
                    	</div> 
                    	<c:if test="${sessionScope.loggedinStore.creditSale=='Y'}">
                    	<div class="item item-sub-child" style="background-color:#FF8576; margin-top:20px;">
                    		<a href="javascript:loadStoreCustomer()">CUSTOMER</a>
                    	</div>
                    	<div class="item item-sub-child" style="background-color:#41A1E3;">
                    		<a href="javascript:loadCreditSale()">CREDIT SALE</a>
                    	</div>
                    	</c:if>
                    	 <c:if test="${sessionScope.loggedinStore.isRefund=='Y'}"> 
							<div class="item item-sub-child" style="background: purple;">
								<a href="javascript:openOrderRefund()">ORDER REFUND</a>
							</div> 
						  </c:if> 
                    	 <c:if test="${sessionScope.loggedinStore.deliveryBoyFlag=='Y'}">
                    	<div class="item item-sub-child" style="background-color:#41A1E3;">

                    		<a href="javascript:viewDeliveryBoy()">
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