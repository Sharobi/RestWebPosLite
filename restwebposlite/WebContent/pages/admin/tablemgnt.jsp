<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
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
    <title>:. POS :: Table Management :.</title>
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
</head>
<body>
    <jsp:include page="/pages/common/header.jsp"></jsp:include>
    <div class="content-wrapper">
        <div class="container-fluid">
        <div class="row">
             <jsp:include page="/pages/admin/admleftpanel.jsp"></jsp:include>  
          
           <div class="col-md-10 col-sm-10" >
				<div class="col-md-10 col-sm-10">
                    <div style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="admin.tablemgnt.jsp.tableMgnt" text="TABLE MANAGEMENT" /></div> 
                </div>
                <div class="col-md-2 col-sm-2">
                    <a href="javascript:showtableaddModal()" class="btn btn-success" style="width:80px; background:#78B626;margin-bottom: 3px;"><spring:message code="admin.tablemgnt.jsp.add" text="ADD" /></a>
                </div>
                <div class="col-md-12 col-sm-12">
                  <!--   Kitchen Sink -->
                  <div style="max-height: 450px;overflow-y:auto; ">
                    <div class="panel panel-default">
                        
                        <div class="panel-body">
                            <div class="table-responsive" style="background:#404040;">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead style="background:#404040; color:#FFF;">
                                        
                                            <th style="text-align:center;"><spring:message code="admin.tablemgnt.jsp.id" text="ID" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.tablemgnt.jsp.tableNo" text="TABLE NO" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.tablemgnt.jsp.seatingCapacity" text="SEATING CAPACITY" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.tablemgnt.jsp.edit" text="EDIT" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.tablemgnt.jsp.delete" text="DELETE" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.tablemgnt.jsp.details" text="DETAILS" /></th>
                                        
                                    </thead>
                                    <tbody>
                                    	<c:if test="${! empty tableListforMgnt }">
                                    		<c:forEach items="${tableListforMgnt}" var="tablemgnt">
                                    			<tr style="background:#404040; color:#FFF;">
                                    				<td align="center">${tablemgnt.tableId}</td>
                                    				<td align="center">${tablemgnt.tableNo}</td>
                                    				<td align="center" width="20%">${tablemgnt.seatingCapacity}</td>
                                    				<td align="center"><a href="javascript:showtableeditModal(${tablemgnt.tableId},&quot;${tablemgnt.tableNo}&quot;,${tablemgnt.seatingCapacity},&quot;${tablemgnt.tableDescription}&quot;,'${tablemgnt.isBooked}','${tablemgnt.multiOrder}')"> <input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_edit.png"></a></td>
                                           			<td align="center"><a href="javascript:showConfirmdeleteTableModal(${tablemgnt.tableId},'${tablemgnt.isBooked}')"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_delete.png"></a></td>
                                            		<td align="center"><a href="javascript:showDetailTableModal(${tablemgnt.tableId},&quot;${tablemgnt.tableNo}&quot;,${tablemgnt.seatingCapacity},&quot;${tablemgnt.tableDescription}&quot;,'${tablemgnt.status}','${tablemgnt.isBooked}','${tablemgnt.multiOrder}')"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a></td>
                                    			</tr>
                                    		</c:forEach>
                                    	</c:if>
                                        <c:if test="${empty tableListforMgnt}">
                                        	<tr style="background:#404040; color:#FFF;">
                                        		<td colspan="6"><spring:message code="admin.tablemgnt.jsp.noDataFound" text="No Data found!" /></td>
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
                			<div class="modal fade" data-backdrop="static" id="tableAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.tablemgnt.jsp.addTable" text="Add Table" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 20px;">
                                            	<table>
                                            		<tr>
                                            			<td><spring:message code="admin.tablemgnt.jsp.tableNo" text="TABLE NO" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="addtablenoContId"  style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.tablemgnt.jsp.seatingCapacity" text="SEATING CAPACITY" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="addseatingcapContId" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.tablemgnt.jsp.desc" text="DESCRIPTION" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="addtabledescContId" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addtablealertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.tablemgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:addTable()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.tablemgnt.jsp.create" text="CREATE" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="tableisBookedModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.tablemgnt.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <spring:message code="admin.tablemgnt.jsp.tab_cont_one" text="Table is already booked,You can't do any operation,Release the table first!" />
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button"  style="background: #72BB4F;font-weight: bold;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.tablemgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="tableEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.tablemgnt.jsp.editTable" text="Edit Table" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 20px;">
                                        		<input type="hidden" id="edittableidContId" value="">
                                            	<table>
                                            		<tr>
                                            			<td><spring:message code="admin.tablemgnt.jsp.tableNo" text="TABLE NO" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="edittablenoContId"  style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.tablemgnt.jsp.seatingCapacity" text="SEATING CAPACITY" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="editseatingcapContId" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.tablemgnt.jsp.desc" text="DESCRIPTION" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="edittabledescContId" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<c:if test="${sessionScope.loggedinStore.multiOrderTable=='Y'}">
                                            		<tr>
                                            			<td><spring:message code="admin.tablemgnt.jsp.multiOrder" text="MULTI ORDER" /></td>
                                            			<td>:</td>
                                            			<td>
                                            				<select id="edittablemultiorderContId" style="margin-bottom: 2px;color: #222222;">
                                            				</select>
                                            			</td>
                                            		</tr>
                                            		</c:if>
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="edittablealertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" onclick="javascript:cancelTable()" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.tablemgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:editTable()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.tablemgnt.jsp.edit" text="EDIT" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="confirmdeleteTableModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.tablemgnt.jsp.confirmation" text="Confirmation!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            	<spring:message code="admin.tablemgnt.jsp.areYouSure" text="Are you sure?" />
                                            	<input type="hidden" id="moddeleteconfirmcatidTableId" value="">
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.tablemgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javacsript:deleteTable()" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.tablemgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="tableDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.tablemgnt.jsp.tableDetails" text="Table Details" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div align="center" style="font-size: 20px;">
                                            	<table>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.tablemgnt.jsp.tableId" text="TABLE ID" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailtableidTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.tablemgnt.jsp.tableNo" text="TABLE NO" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailtablenoTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.tablemgnt.jsp.seatingCapacity" text="SEATING CAPACITY" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailtablecapacityTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.tablemgnt.jsp.tableStatus" text="TABLE STATUS" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailtablestatusTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.tablemgnt.jsp.desc" text="DESCRIPTION" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailtabledescTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.tablemgnt.jsp.bookingStatus" text="BOOKING STATUS" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailbookingstatusTd"></td>
                                            		</tr>
                                            		<c:if test="${sessionScope.loggedinStore.multiOrderTable=='Y'}">
                                            		<tr>
                                            			<td><spring:message code="admin.tablemgnt.jsp.multiOrder" text="MULTI ORDER" /></td>
                                            			<td>:</td>
                                            			<td id="moddetailmutiorderTd"></td>
                                            		</tr>
                                            		</c:if>
                                            	</table>
                                           		
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success" data-dismiss="modal"><spring:message code="admin.tablemgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal fade" data-backdrop="static" id="alerttabledataopModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.tablemgnt.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <div id="tabledataopmassagecont"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="location.href='${pageContext.request.contextPath}/tablemgnt/loadtablemgnt.htm'" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.tablemgnt.jsp.ok" text="OK" /></button>
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
   var BASE_URL="${pageContext.request.contextPath}";
   var ismultiOrder="${sessionScope.loggedinStore.multiOrderTable}";
   var storeID="${sessionScope.loggedinStore.id}";
/*start table management*/
   
   function showtableaddModal()
	{
		$('#tableAddModal').modal('show');
		$('#tableAddModal').on('shown.bs.modal', function () {
		$('#addtablenoContId').focus();});
	}
   function closetableaddModal()
	{
		$('#tableAddModal').modal('hide');
	}
   function showtableisBookedModal()
   {
	   $('#tableisBookedModal').modal('show');
   }
   function showtableeditModal(id,no,capacity,desc,isbooked,multiorder)
	{
	   if(isbooked=='Y')
		   {
		   showtableisBookedModal();
		   }
	   else{
		   	document.getElementById('edittableidContId').value=id;
		   	document.getElementById('edittablenoContId').value=no;
		   	document.getElementById('editseatingcapContId').value=capacity;
		   	document.getElementById('edittabledescContId').value=desc;
		   	if(ismultiOrder=='Y')
		   		{
		   		var mutiorderline="";
		   		if(multiorder=='Y')
				   {
		   			mutiorderline="<option value='Y'>ENABLE</option><option value='N'>DISABLE</option>";
				   }
			   else
				   {
				   mutiorderline="<option value='N'>DISABLE</option><option value='Y'>ENABLE</option>";
				   }
		   		document.getElementById('edittablemultiorderContId').innerHTML=mutiorderline;
		   		}
		   		
			$('#tableEditModal').modal('show');
	   	   }
	}
  function closetableeditModal()
	{
		$('#tableEditModal').modal('hide');
	}
  function showConfirmdeleteTableModal(id,isbooked)
  {
	  if(isbooked=='Y')
	   {
	   showtableisBookedModal();
	   }
  else{
	   document.getElementById('moddeleteconfirmcatidTableId').value=id;
	   $('#confirmdeleteTableModal').modal('show');
  	  }
  }
  function showDetailTableModal(id,no,capacity,desc,status,isbooked,multiorder)
  {
	   document.getElementById('moddetailtableidTd').innerHTML=id;
	   document.getElementById('moddetailtablenoTd').innerHTML=no;
	   document.getElementById('moddetailtablecapacityTd').innerHTML=capacity;
	   document.getElementById('moddetailtablestatusTd').innerHTML=status;
	   document.getElementById('moddetailtabledescTd').innerHTML=desc;
	   document.getElementById('moddetailbookingstatusTd').innerHTML=isbooked;
	   if(ismultiOrder=='Y')
		   {
		   var multi='';
		   if(multiorder=='Y'){multi='ENABLE';} else {multi='DISABLE';}
		   document.getElementById('moddetailmutiorderTd').innerHTML=multi; 
		   }
		     
	   $('#tableDetailModal').modal('show');
  }
  function showalerttabledataopModal()
	{
		$('#alerttabledataopModal').modal('show');
	}
   /*end table management*/
   </script>
   
   <c:choose>
    <c:when test="${pageContext.response.locale == 'ar'}">
       <script src="${pageContext.request.contextPath}/assets/js/lang/adminScript_AR.js"></script>
    </c:when>    
    
    <c:otherwise>
     <script src="${pageContext.request.contextPath}/assets/js/lang/adminScript_EN.js"></script> 
    </c:otherwise>
    </c:choose>