<%@page import="com.sharobi.webpos.util.CommonResource"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
    <title>:. POS :: Kitchen Management :.</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME ICONS  -->
    <link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
    <link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
     <!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style type="text/css">
    .selected{
    background-color: #eae2c4 !important;
    }
    </style>
</head>
<body>
<c:set var="today" value="<%=new java.util.Date()%>" />
    <jsp:include page="/pages/common/header.jsp"></jsp:include>
    <div class="content-wrapper">
        <div class="container-fluid">
        <div class="row">
            <div style="height:500px; overflow-y:auto;">
                  <!--   Kitchen Sink -->
                  
                    <div class="panel panel-default">
                        
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="sortable">
                                	<thead style="background:#404040; color:#FFF; font-size:16px; font-weight:bold;">
                                		<th align="center" nowrap>ORDER NO</th>
                                            <th nowrap>ITEM NAME</th>
                                            <th align="center">QTY</th>
                                            <th align="center">ORDER TYPE</th>
                                            <th align="center">NOTE</th>
                                           	<th align="center">KITCHEN</th>
                                            <th align="center" nowrap>ORDER TIME</th>
                                            <th align="center" nowrap>START</th>
                                            <th align="center" nowrap>END</th>
                                            <th align="center" nowrap>KITCHEN OUT</th>
                                            <th align="center" nowrap>COOKING TIME</th>
                                	</thead>
                                    <tbody>
                                    	<!-- <tr id="1" style="background:#404040; color:#FFF; font-size:16px; font-weight:bold; " >
                                            <td align="center" nowrap>ORDER NO</td>
                                            <td nowrap>ITEM NAME</td>
                                            <td align="center">QTY</td>
                                            <td align="center">NOTE</td>
                                           	<td align="center">KITCHEN</td>
                                            <td align="center" nowrap>ORDER TIME</td>
                                            <td align="center" nowrap>START</td>
                                            <td align="center" nowrap>END</td>
                                            <td align="center" nowrap>KITCHEN OUT</td>
                                            <td align="center" nowrap>COOKING TIME</td>
                                        </tr> -->
                                        <c:if test="${! empty allkitchenItem}">
                                        	<c:forEach items="${allkitchenItem}" var="kitchenitem">
                                        	<tr style="background:#fff;" id="${kitchenitem.ordrId}">
                                        		<td align="center"><div id="content" style="display:none;">${kitchenitem.ordrId}</div><div>${kitchenitem.orderNo}</div></td>
                                        		<td>${kitchenitem.item.name}</td>
                                        		<td align="center">${kitchenitem.quantityOfItem}</td>
                                        		<td align="center">
                                        			<c:choose>
                                					<c:when test="${kitchenitem.ordertype==2}">
                                					PARCEL
                                					</c:when>
                                					<c:otherwise>
                                					DINE IN
                                					</c:otherwise>
                                				</c:choose>
                                        		</td>
                                        		<td align="center">
                                        			<c:if test="${empty kitchenitem.specialNote}">
                                        				<a href="#" style="cursor: auto;"><img src="${pageContext.request.contextPath}/assets/images/kitchen/note/note_n.png" height="40px" width="40px"/></a>
                                        			</c:if>
                                        			<c:if test="${!empty kitchenitem.specialNote}">
                                        				<a href="javascript:openSpecialNoteModal(&quot;${kitchenitem.specialNote}&quot;)"><img src="${pageContext.request.contextPath}/assets/images/kitchen/note/note_y.png" height="40px" width="40px"/></a>
                                        			</c:if>
                                        		</td>
                                        		<td align="center">${kitchenitem.kitchenName}</td>
                                        		<td align="center">${kitchenitem.orderTime}</td>
                                        		<td align="center">
                                        			<c:if test="${empty kitchenitem.cookingStartTime }">
                                        				<a href="javascript:startCooking(${kitchenitem.ordrId},${kitchenitem.id},'<fmt:formatDate type="time" value="${today}" />')" class="btn-unpaid-order" style="background: #FFDC39;color: #000;">START</a>
                                        			</c:if>
                                        			<c:if test="${!empty kitchenitem.cookingStartTime }">
                                        				<a href="#" class="btn-unpaid-order" style="cursor: auto;">${kitchenitem.cookingStartTime}</a>
                                        			</c:if>
                                        		</td>
                                            	<td align="center">
                                            		<c:if test="${empty kitchenitem.cookingEndTime }">
                                            			<a href="javascript:stopCooking(${kitchenitem.ordrId},${kitchenitem.id},'<fmt:formatDate type="time" value="${today}" />','${kitchenitem.cookingStartTime}')" class="btn-unpaid-order" style="background: #FFCC66;color: #000;">STOP</a>
                                            		</c:if>
                                            		<c:if test="${!empty kitchenitem.cookingEndTime }">
                                            			<a href="#" class="btn-unpaid-order" style="background: #DD5055;cursor: auto;">${kitchenitem.cookingEndTime }</a>
                                            		</c:if>
                                            	</td>
                                            	<td align="center"><a href="javascript:kitchenOut(${kitchenitem.ordrId},${kitchenitem.id},'${kitchenitem.cookingStartTime}','${kitchenitem.cookingEndTime}')" class="btn-unpaid-order" style="background: #FFDC39;color: #000;">YES</a></td>
                                        		<td align="center">${kitchenitem.item.cookingTimeInMins}</td>
                                        	</tr>
                                        	</c:forEach>
                                        </c:if>
                                    	<c:if test="${empty allkitchenItem}">
                                    	<tr>
                                    	<td colspan="10">No Data Found!</td>
                                    	
                                    	</tr>
                                    	
                                    	</c:if>
                                         
                                    </tbody>
                                </table>
                            </div>
                       
                    </div>
                     <!-- End  Kitchen Sink -->
                     </div>
               
           </div>
       </div>
      				<!-- modal starts -->
      						<div class="modal fade" data-backdrop="static" id="kitchenitemSpesialNoteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">SPECIAL NOTE</h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <div id="kitchenitemSpNoteContId"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button"  style="background: #72BB4F;font-weight: bold;" data-dismiss="modal" class="btn btn-success">OK</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="alertkitchenOutnoStartModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">Alert!</h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            You have not start cooking.Please start cooking!
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button"  style="background: #72BB4F;font-weight: bold;" data-dismiss="modal" class="btn btn-success">OK</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="alertkitchenOutnoEndModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">Alert!</h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            You have not end cooking.Please end cooking!
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button"  style="background: #72BB4F;font-weight: bold;" data-dismiss="modal" class="btn btn-success">OK</button>
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
    <script src="${pageContext.request.contextPath}/assets/js/kitchenScript.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
    <!-- CORE JQUERY SCRIPTS -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
   <script type="text/javascript">
   var BASE_URL="${pageContext.request.contextPath}";
   function openSpecialNoteModal(spnote)
   {
	   document.getElementById('kitchenitemSpNoteContId').innerHTML=spnote;
	   $('#kitchenitemSpesialNoteModal').modal('show');
   }
   function openalertnoStartModal()
   {
	   $('#alertkitchenOutnoStartModal').modal('show');
   }
   function openalertnoEndModal()
   {
	   $('#alertkitchenOutnoEndModal').modal('show');
   }
   
   window.onload = function(){
	   var previd='';
	   var currentColor='#e2e2e2';
	   var colorGrey='#e2e2e2';
	   var colorYellow='#eae2c4';
	   var trs=document.getElementsByTagName('tr');
	   for(var i=1;i<trs.length;i++)
		   {
		   var trid=trs[i].id;
		   if(i==1)
			   {
			   trs[i].style.background=''+currentColor;
			   }
		   else{
			   if(trid==previd)
				   {
				   trs[i].style.background=''+currentColor;
				   }
			   else{
				   if(currentColor==colorGrey)
					   {
					   currentColor=colorYellow;
					   }
				   else if(currentColor==colorYellow)
				   		{
					   currentColor=colorGrey;
					   
				       	}
				   trs[i].style.background=''+currentColor;
			       }
		       }
		   previd=trs[i].id;
		   }
   };
   </script>
   </body>
</html>