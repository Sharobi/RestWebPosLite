<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="com.sharobi.webpos.util.Constants"%>
<%@page import="com.sharobi.webpos.base.model.Store"%>
<%@page import="com.sharobi.webpos.vfd.Display"%>
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
    <title>:. POS :: Dashboard:.</title>
    <!-- BOOTSTRAP CORE STYLE  -->
<link
	href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css"
	rel="stylesheet" />
<!-- FONT AWESOME ICONS  -->
<link
	href="${pageContext.request.contextPath}/assets/css/font-awesome.css"
	rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/style.css"
	rel="stylesheet" />
<link rel="icon" id="favicon"
	href="${pageContext.request.contextPath}/assets/images/title/fb.png">
<link
	href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css"
	rel="stylesheet" />
    <style type="text/css">
.panel {
	margin-left: 18px;
}

.panel-primary {
	border: 1px;
	border-radius: 5px;
	border-color: #5cc16cc9;
}

.rightblock {
	margin-left: 18px;
}

.panel-heading {
	border-color: #5cc16cc9;
	color: white;
	background-color: #5cc16cc9;
}

.coldivider {
	margin-right: -1%;
}

.boxheading {
	font-family: "Karla", sans-serif;
	color: white;
}

.test {
	/* float: left;*/
	width: 18%;
	margin: 1%;
	height: 100px;
}

.test-heading {
	padding: 5px 38px;
}
</style>
</head>
<c:set var="today" value="<%=new java.util.Date()%>" />
<body>
    <jsp:include page="/pages/common/header.jsp"></jsp:include>
    <div class="content-wrapper">
        <div class="container-fluid">
        <div class="row">
             <jsp:include page="/pages/admin/admleftpanel.jsp"></jsp:include>  
                <div class="col-md-10 col-sm-10" style="max-height:500px; overflow-x:hidden;overflow-y:scroll;">
                 <div class="row" style="margin-top: 2px;">
				<div class="col-lg-8 col-md-8"></div>
				<div class="col-lg-4 col-md-4">
					<div class="row" style="text-align: center;">
						<div class="col-lg-4 col-xs-12">
							<label for="startdate" style="color: white;">From:</label> <input
								type="text" class="" id="startdate" onchange="getDashBoardData()" style="text-align: center;"
								size=10
								value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
						</div>
						<div class="col-lg-4 col-xs-12">
							<label for="enddate" style="color: white;">To:</label> <input
								type="text" class="" id="enddate" onchange="getDashBoardData()"
								style="text-align: center;" size=10
								value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
						</div>
						
					</div>
				</div>
			</div>
					 <div class="col-md-12 col-sm-12 col-xs-12" style="margin-top: 2px;">
	                                 <div class="col-lg-2 col-xs-12 test"
											style="background-color: #61d2c6d1; border: 1px; border-radius: 5px;"
											title="Total Orders">
											<div class="test-heading">
												<div class="row">
													<div class="col-xs-3">
														<i class="fa fa-bitbucket fa-2x" style="color: white"></i>
													</div>
													<div class="col-xs-9 text-right">
														<div>
															<b class="boxheading">Total Order</b>
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-xs-12 text-right">
														<br> <span id="totorders" class="count" style="color:white;font-weight:bold">0</span>
													</div>
												</div>
											</div>
										</div>
										<div class="col-lg-2 col-xs-12 test"
											style="background-color: #61d2c6d1; border: 1px; border-radius: 5px;"
											title="Total Sales">
											<div class="test-heading">
												<div class="row">
													<div class="col-xs-3">
														<i class="fa fa-shopping-cart fa-2x" style="color: white"></i>
													</div>
													<div class="col-xs-9 text-right">
														<div>
															<b class="boxheading">Total Sale</b>
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-xs-12 text-right">
														<br><span id="totsales" class="count" style="color:white;font-weight:bold">0</span>
													</div>
												</div>
											</div>
										</div>
										<div class="col-lg-2 col-xs-12  test"
											style="background-color: #61d2c6d1; border: 1px; border-radius: 5px;"
											title="Total Cash">
											<div class="test-heading">
												<div class="row">
													<div class="col-xs-3">
														<i class="fa fa-money fa-2x" style="color: white"></i>
													</div>
													<div class="col-xs-9 text-right">
														<div>
															<b class="boxheading">Paid Order</b>
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-xs-12 text-right" style="color:white;font-weight:bold">
														<br> <span id="totpaidorder" class="count" style="color:white;font-weight:bold">0.0</span>
														   (<span id="totpaidorderNo" class="count" style="color:white;font-weight:bold">0</span>&nbsp;Orders)
													</div>
												</div>
											</div>
										</div> 
										 <div class="col-lg-2 col-xs-12 test"
											style="background-color: #61d2c6d1; border: 1px; border-radius: 5px;"
											title="Profit Or Loss">
											<div class="test-heading">
												<div class="row">
													<div class="col-xs-3">
														<i class="fa fa-credit-card fa-2x" style="color: white"></i>
													</div>
													<div class="col-xs-9 text-right">
														<div>
															<b class="boxheading">Credit Order</b>
														</div>
													</div>
												</div>
												<div class="row" style="color:white;font-weight:bold">
													<div class="col-xs-12 text-right">
														<br> <span id="totcreditorder" class="count" style="color:white;font-weight:bold">0.0</span>
														(<span id="totcreditorderNo" class="count" style="color:white;font-weight:bold">0</span>&nbsp;Orders)
													
													</div>
												</div>
											</div>
										</div>
										<!-- <div class="col-lg-3 col-xs-3 test"
											style="background-color: #61d2c6d1; border: 1px; border-radius: 5px;"
											title="Total Purchase">
											<div class="test-heading">
												<div class="row">
													<div class="col-xs-3">
														<i class="fa fa-briefcase fa-2x" style="color: white"></i>
													</div>
													<div class="col-xs-9 text-right">
														<div>
															<b class="boxheading">Purchase</b>
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-xs-12 text-right">
														<br> <span id="totpurchase" class="count" style="color:white;font-weight:bold">0</span>
													</div>
												</div>
											</div>
										</div> -->
										<div class="col-lg-2 col-xs-12 test"
											style="background-color: #61d2c6d1; border: 1px; border-radius: 5px;"
											title="Total Customers">
											<div class="test-heading">
												<div class="row">
													<div class="col-xs-3">
														<i class="fa fa-users fa-2x" style="color: white"></i>
													</div>
													<div class="col-xs-9 text-right">
														<div>
															<b class="boxheading">Customer</b>
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-xs-12 text-right">
														<br> <span id="totcustomers" class="count" style="color:white;font-weight:bold">0</span>
													</div>
												</div>
											</div>
										</div>
				              </div><!-- Box Line End -->
				              <div class="col-md-12 col-sm-12 col-xs-12" style="margin-top: 10px;">
				               <div class="col-lg-6 col-xs-12 col-md-6">
									<div class="panel panel-primary"
										style="margin-bottom: 1%;margin-left: 2%; ">
										<%--   <canvas id="canvas" style="background-color: #31708f00;"
				                        height="258vw" width="540vw"></canvas> --%>
										<canvas id="paichart1" style="background-color: #31708f00;"
											height="258vw" width="540vw"></canvas>
									</div>
								</div>
								<div class="col-lg-6 col-xs-12 col-md-6">
									<div class="panel panel-primary"
										style="margin-bottom: 1%;">
										<canvas id="paichart" style="background-color: #31708f00;"
											height="258vw" width="540vw"></canvas>
									</div>
								</div>
				             </div>
				             <div class="col-md-12 col-sm-12 col-xs-12" style="margin-top: 10px;">
								  <div class="col-lg-6 col-xs-12 col-md-6">
									<div class="panel panel-primary"
										style="margin-bottom: 1%;margin-left: 2%;">
										<canvas id="doughnut" style="background-color: #31708f00;"
											height="270vw" width="558vw"></canvas>
									</div>
								</div>
								<div class="col-lg-6 col-xs-12 col-md-6">
									<div class="panel panel-primary"
										style="margin-bottom: 1%">
										<canvas id="mychart1" style="background-color: #31708f00;"
											height="258vw" width="540vw"></canvas>
									</div>
								</div>
				           </div>
				            <div class="col-md-12 col-sm-12 col-xs-12" style="margin-top: 10px;">
								 
									<div class="panel panel-primary"
										style="margin-bottom: 1%;margin-left: 1%;">
										<canvas id="mychart2" style="background-color: #31708f00;"
											height="200vw" width="540vw"></canvas>
									</div>
								
				            </div>
				              
                </div>
             </div>
             <div class="modal fade" data-backdrop="static" id="alertWrongDateRangeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.rpt_order_day.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                              <span id="alertmsg"></span>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button"  style="background: #72BB4F;font-weight: bold;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.rpt_order_day.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
          </div>
     </div>
    <!-- CONTENT-WRAPPER SECTION END-->
    <!-- CORE JQUERY SCRIPTS -->
	<script
		src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
	<!-- BOOTSTRAP SCRIPTS  -->
	<script
		src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>
    	<!-- JS FOR GRAPH -->
	<script
		src="${pageContext.request.contextPath}/assets/js/chart/chart_js.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/chart/util.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
    <!-- FOOTER SECTION END-->
    <!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
   <script type="text/javascript">
	    var storeID="${sessionScope.loggedinStore.id}";
	    var BASE_URL="${pageContext.request.contextPath}";
         $(document).ready(function() {
         	var currentDate = new Date();
         	$('#startdate').datepicker({
         		format : 'yyyy-mm-dd',
         		endDate : currentDate,
         		autoclose : true,
         	});
         
         	$('#enddate').datepicker({
         		format : 'yyyy-mm-dd',
         		endDate : currentDate,
         		autoclose : true,
         	});
         
         });
      </script>
	<script type="text/javascript">
         var BASE_URL = "${pageContext.request.contextPath}";
         var storeId = '${sessionScope.loggedinStore.id}';
      </script>
	<script>
         window.onload = function() {
        	 
         	var ctx = document.getElementById('paichart1').getContext('2d');
         	window.myPie1 = new Chart(ctx, config1);
         	
         	var ctx2 = document.getElementById('paichart').getContext('2d');
         	window.myPie2 = new Chart(ctx2, config2);
         	
         	var ctx3 = document.getElementById('doughnut').getContext('2d');
         	window.doughnut1 = new Chart(ctx3, config3);
         
         	var ctx4 = document.getElementById('mychart1').getContext('2d');
         	window.doughnut2 = new Chart(ctx4, config4);
         
         	var ctx5 = document.getElementById('mychart2').getContext('2d');
         	window.doughnut3 = new Chart(ctx5, config5);
         	
         	getAllDataPie1();
        	getAllDataPie2();
        	getdoughnutData();
        	getBoxData();
        	getTopCustomer();
        	getTopSaledItems();
          }
         
       
        
         var config1 = {
              	type : 'pie',
              	data : {
              		datasets : [ {
              			data : [ ],
              			backgroundColor : [
         					],
              
              		} ],
              		labels : [ ]
              	},
              	options : {
              		responsive : true
              	}
              };
              
         
         var config2 = {
         	type : 'pie',
         	data : {
         		datasets : [ {
         			data : [ ],
         			backgroundColor : [ ],
         
         		} ],
         		labels : [ ]
         	},
         	options : {
         		responsive : true
         	}
         };
        
          var config3 = {
              	type : 'doughnut',
              	data : {
              		datasets : [ {
              			data : [ ],
              			backgroundColor : [
              
              			],
              			label : 'Dataset 1'
              		} ],
              		labels : [ 
              
              		]
              	},
              	options : {
              		responsive : true
              	}
              }; 
         
         
         var config4 = {
              	type : 'horizontalBar',
              	data : {
              		labels : [ ],
              		datasets : [ {
              			label : 'Top Customer',
              			data : [ ],
              			backgroundColor : [ 
              				    ],
              			borderColor : [ 
              				    
              					],
              			borderWidth : 1
              		} ]
              	},
              	options : {
              		responsive : true,
              		legend: {
                        display: false,
                    },
              		title: {
                        display: true,
                        text: 'Top 5 Customers'
                    },
              		scales : {
              			xAxes : [ {
              				ticks : {
              					maxRotation : 90,
              					minRotation : 80,
              					beginAtZero : true
              					
              				}
              			} ],
              			yAxes : [ {
              				ticks : {
              					beginAtZero : true,
              					
              				}
              			} ]
              		}
              	}
              	
              };
           
         var config5 = {
         	type : 'horizontalBar',
         	data : {
         		labels : [ ],
         		datasets : [ {
         		    label : 'Highest Sold Item', 
         			data : [  ],
         			backgroundColor : [ ],
         			borderColor : [ ],
         			borderWidth : 1
         		} ]
         	},
         	options : {
         		responsive : true,
         		legend: {
                    display: false,
                },
         		 title: {
                     display: true,
                     text: 'Top 5 Sold Items'
                 },
         		scales : {
         			xAxes : [ {
         				ticks : {
         					maxRotation : 90,
         					minRotation : 80,
         					beginAtZero : true
         				}
         			} ],
         			yAxes : [ {
         				ticks : {
         					beginAtZero : true
         				}
         			} ]
         		}
         	}
         };
         
         function getDashBoardData(){
        	//alert("hh");
         	getBoxData();
         	getAllDataPie1();
         	getAllDataPie2();
         	getdoughnutData();
         	getTopCustomer();
         	getTopSaledItems();
         	
         }
         
         function getBoxData(){
        	 var startDate = document.getElementById("startdate").value; 
        	 var endDate =   document.getElementById("enddate").value; 
        	 var commonResultSetMapper={};
        	 commonResultSetMapper.startDate=startDate;
        	 commonResultSetMapper.endDate=endDate;
        	 commonResultSetMapper.storeId=storeID;
      		
        	 if(startDate>endDate){
        		 document.getElementById("alertmsg").innerHTML="Please Enter Correct Date Range";
        		  $('#alertWrongDateRangeModal').modal('show');
        		 
        	 }
        	 else{
        		  var ajaxCallObject = new CustomBrowserXMLObject();
        	    	 ajaxCallObject.callAjaxPost(BASE_URL + "/dash/getBoxData.htm", commonResultSetMapper, function(response) {
                         var res = JSON.parse(response);
        			      document.getElementById("totsales").innerHTML=parseFloat(res.totSale).toFixed(2);
        			      document.getElementById("totorders").innerHTML=parseInt(res.noofOrder);
        			      document.getElementById("totcustomers").innerHTML=parseInt(res.noofCust);
        			      /*document.getElementById("totpurchase").innerHTML=parseFloat(res.totPurchase).toFixed(2);*/
        			     
        			      document.getElementById("totpaidorder").innerHTML=parseFloat(res.totPaidAmt).toFixed(2);
        			      document.getElementById("totpaidorderNo").innerHTML=parseInt(res.noofPaidOrder);
        			      document.getElementById("totcreditorder").innerHTML=parseFloat(res.totCreditAmt).toFixed(2);
        			      document.getElementById("totcreditorderNo").innerHTML=parseInt(res.noofCreditOrder);
        	    	      
        	    	 
        	    	 }); 
        	     }
        	 
        	 
         }
         
        function getAllDataPie1()
                   {      
         		             /*
         		             * for pic chart
         		             */
         	 var startDate = document.getElementById("startdate").value; 
        	 var endDate =   document.getElementById("enddate").value; 
        	 var commonResultSetMapper={};
        	 commonResultSetMapper.startDate=startDate;
        	 commonResultSetMapper.endDate=endDate;
        	 commonResultSetMapper.storeId=storeID;
      		
        	 if(startDate>endDate){
        		 document.getElementById("alertmsg").innerHTML="Please Enter Correct Date Range";
        		  $('#alertWrongDateRangeModal').modal('show');
        		 
        	 }
        	 else{
        		  var ajaxCallObject = new CustomBrowserXMLObject();
        	    	 ajaxCallObject.callAjaxPost(BASE_URL + "/dash/getPaymentSummary.htm", commonResultSetMapper, function(response) {
                         var res = JSON.parse(response);
                        config1.data.datasets[0].data[0]=parseFloat(res.paidAmt).toFixed(2);
       		         	config1.data.datasets[0].data[1]=parseFloat(res.unpaidAmt).toFixed(2);
       		         	config1.data.datasets[0].data[2]=parseFloat(res.refundAmt).toFixed(2);
       		            config1.data.datasets[0].data[3]=parseFloat(res.cancelAmt).toFixed(2);
       		            config1.data.datasets[0].data[4]=parseFloat(res.creditAmt).toFixed(2);
       		         	config1.data.datasets[0].backgroundColor[0]=window.chartColors.orange;
       		         	config1.data.datasets[0].backgroundColor[1]=window.chartColors.yellow;
       		         	config1.data.datasets[0].backgroundColor[2]=window.chartColors.green;
       		            config1.data.datasets[0].backgroundColor[3]=window.chartColors.red;
       		            config1.data.datasets[0].backgroundColor[4]=window.chartColors.blue;
       		         	config1.data.labels[0]='Paid Amount'+" ["+parseFloat(res.paidAmt).toFixed(2)+"]";
       		         	config1.data.labels[1]='Unpaid Amount'+" ["+parseFloat(res.unpaidAmt).toFixed(2)+"]";
       		         	config1.data.labels[2]='Refund Amount'+" ["+parseFloat(res.refundAmt).toFixed(2)+"]";
       		            config1.data.labels[3]='Cancel Amount'+" ["+parseFloat(res.cancelAmt).toFixed(2)+"]"; 
       		            config1.data.labels[4]='Credit Amount'+" ["+parseFloat(res.creditAmt).toFixed(2)+"]"; 
       		            window.myPie1.update();
        	    	      
        	    	 
        	    	 }); 
        	     } 
         		             
           }    
         
         
         
      function   getAllDataPie2(){
    	                   /*
                            * for pic chart
                            */
    	 var startDate = document.getElementById("startdate").value; 
     	 var endDate =   document.getElementById("enddate").value; 
     	 var commonResultSetMapper={};
     	 commonResultSetMapper.startDate=startDate;
     	 commonResultSetMapper.endDate=endDate;
     	 commonResultSetMapper.storeId=storeID;
   		
     	 if(startDate>endDate){
     		 document.getElementById("alertmsg").innerHTML="Please Enter Correct Date Range";
     		  $('#alertWrongDateRangeModal').modal('show');
     		 
     	 }
     	 else{
     		  var ajaxCallObject = new CustomBrowserXMLObject();
     	    	 ajaxCallObject.callAjaxPost(BASE_URL + "/dash/getDashSaleSummaryOrderType.htm", commonResultSetMapper, function(response) {
                    var res = JSON.parse(response);
                    config2.data.datasets[0].data=[];
                    config2.data.datasets[0].backgroundColor=[];
                    config2.data.labels=[];
                     for(var i=0;i<res.length;i++){
                    	config2.data.datasets[0].data[i]=parseFloat(res[i].saleAmt).toFixed(2);
                    	config2.data.datasets[0].backgroundColor[i]=colorArray[i];
                    	config2.data.labels[i]=res[i].orderType+"["+parseFloat(res[i].saleAmt).toFixed(2)+"]";
                    }
                    window.myPie2.update();
                   }); 
     	     }
      }
   
     function getdoughnutData(){
    	  /*
           * for doughnut chart
           */
    	 var startDate = document.getElementById("startdate").value; 
      	 var endDate =   document.getElementById("enddate").value; 
      	 var commonResultSetMapper={};
      	 commonResultSetMapper.startDate=startDate;
      	 commonResultSetMapper.endDate=endDate;
      	 commonResultSetMapper.storeId=storeID;
    		
      	 if(startDate>endDate){
      		 document.getElementById("alertmsg").innerHTML="Please Enter Correct Date Range";
      		  $('#alertWrongDateRangeModal').modal('show');
      		 
      	 }
      	 else{
      		  var ajaxCallObject = new CustomBrowserXMLObject();
      	    	 ajaxCallObject.callAjaxPost(BASE_URL + "/dash/getDashSaleSummaryPaymentType.htm", commonResultSetMapper, function(response) {
                     var res = JSON.parse(response);
                     config3.data.datasets[0].data=[];
                     config3.data.datasets[0].backgroundColor=[];
                     config3.data.labels=[];
                     for(var i=0;i<res.length;i++){
                     	config3.data.datasets[0].data[i]=parseFloat(res[i].amt).toFixed(2);
                     	config3.data.datasets[0].backgroundColor[i]=colorArray[i];
                     	config3.data.labels[i]=res[i].paymentType+"["+parseFloat(res[i].amt).toFixed(2)+"]";
                     }
                     window.doughnut1.update();
                   }); 
      	     }
           
        }
     
     function getTopCustomer(){
    	 /*
          * for bar chart
          */
   	     var startDate = document.getElementById("startdate").value; 
     	 var endDate =   document.getElementById("enddate").value; 
     	 var commonResultSetMapper={};
     	 commonResultSetMapper.startDate=startDate;
     	 commonResultSetMapper.endDate=endDate;
     	 commonResultSetMapper.storeId=storeID;
   		
     	 if(startDate>endDate){
     		 document.getElementById("alertmsg").innerHTML="Please Enter Correct Date Range";
     		  $('#alertWrongDateRangeModal').modal('show');
     		 
     	 }
     	 else{
     		  var ajaxCallObject = new CustomBrowserXMLObject();
     	    	 ajaxCallObject.callAjaxPost(BASE_URL + "/dash/getDashTopCustomer.htm", commonResultSetMapper, function(response) {
                    var res = JSON.parse(response);
                    config4.data.datasets[0].data=[];
                    config4.data.datasets[0].backgroundColor=[];
                    config4.data.datasets[0].borderColor=[];
                    config4.data.labels=[];
                    for(var i=0;i<res.length;i++){
                    	config4.data.datasets[0].data[i]=parseFloat(res[i].amtSpent).toFixed(2);
                    	config4.data.datasets[0].backgroundColor[i]=colorArray[i];
                    	config4.data.datasets[0].borderColor[i]=colorArray[i+1];
                    	config4.data.labels[i]=res[i].custName+"\n"+"["+parseFloat(res[i].amtSpent).toFixed(2)+"]";
                    }
                    config4.data.labels.forEach(function(e, i, a) {
                        if (/\n/.test(e)) {
                           a[i] = e.split(/\n/);
                           
                        }
                     });
                    window.doughnut2.update();
                   }); 
     	     }
    	 
     }
     
     function getTopSaledItems(){
    	 /*
          * for bar chart
          */
   	     var startDate = document.getElementById("startdate").value; 
     	 var endDate =   document.getElementById("enddate").value; 
     	 var commonResultSetMapper={};
     	 commonResultSetMapper.startDate=startDate;
     	 commonResultSetMapper.endDate=endDate;
     	 commonResultSetMapper.storeId=storeID;
   		
     	 if(startDate>endDate){
     		 document.getElementById("alertmsg").innerHTML="Please Enter Correct Date Range";
     		  $('#alertWrongDateRangeModal').modal('show');
     		 
     	 }
     	 else{
     		  var ajaxCallObject = new CustomBrowserXMLObject();
     	    	 ajaxCallObject.callAjaxPost(BASE_URL + "/dash/getDashTopItem.htm", commonResultSetMapper, function(response) {
                    var res = JSON.parse(response);
                    config5.data.datasets[0].data=[];
                    config5.data.datasets[0].backgroundColor=[];
                    config5.data.datasets[0].borderColor=[];
                    config5.data.labels=[];
                    for(var i=0;i<res.length;i++){
                    	config5.data.datasets[0].data[i]=res[i].qty;
                    	config5.data.datasets[0].backgroundColor[i]=colorArray[i];
                    	config5.data.datasets[0].borderColor[i]=colorArray[i+1];
                    	config5.data.labels[i]=res[i].itemName+"\n"+"["+res[i].qty+"]";
                    }
                
                    config5.data.labels.forEach(function(e, i, a) {
                        if (/\n/.test(e)) {
                           a[i] = e.split(/\n/);
                           
                        }
                     });
                    window.doughnut3.update();
                   }); 
     	     }
     }
     
      var colorArray = [
    	  '#FF6633', '#FFB399', '#FF33FF', '#FFFF99', '#00B3E6', 
		  '#E6B333', '#3366E6', '#999966', '#99FF99', '#B34D4D',
		  '#80B300', '#809900', '#E6B3B3', '#6680B3', '#66991A', 
		  '#FF99E6', '#CCFF1A', '#FF1A66', '#E6331A', '#33FFCC',
		  '#66994D', '#B366CC', '#4D8000', '#B33300', '#CC80CC', 
		  '#66664D', '#991AFF', '#E666FF', '#4DB3FF', '#1AB399',
		  '#E666B3', '#33991A', '#CC9999', '#B3B31A', '#00E680', 
		  '#4D8066', '#809980', '#E6FF80', '#1AFF33', '#999933',
		  '#FF3380', '#CCCC00', '#66E64D', '#4D80CC', '#9900B3', 
		  '#E64D66', '#4DB380', '#FF4D4D', '#99E6E6', '#6666FF'
		  ];

      
      
      
      </script>
	
</body>
</html>