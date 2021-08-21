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
    <title>:. POS :: Vendor Management :.</title>
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
           
           <div class="col-md-10 col-sm-10">
                <div class="col-md-10 col-sm-10">
                    <div style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="admin.vendormgnt.jsp.vendor" text="VENDOR" /></div> 
                </div>
                <div class="col-md-2 col-sm-2">
                    <a href="javascript:showvendoraddModal()" class="btn btn-success" style="width:80px; background:#78B626;margin-bottom: 3px;"><spring:message code="admin.vendormgnt.jsp.add" text="ADD" /></a>
                </div>
                <div class="col-md-12 col-sm-12">
                  <!--   Kitchen Sink -->
                  <div style="max-height: 400px;overflow-y:auto; ">
                    <div class="panel panel-default">
                        
                        <div class="panel-body">
                            <div class="table-responsive" style="background:#404040;">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead style="background:#404040; color:#FFF;">
                                        
                                            <th style="text-align:center;"><spring:message code="admin.vendormgnt.jsp.id" text="ID" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.vendormgnt.jsp.code" text="CODE" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.vendormgnt.jsp.name" text="NAME" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.vendormgnt.jsp.edit" text="EDIT" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.vendormgnt.jsp.delete" text="DELETE" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.vendormgnt.jsp.details" text="DETAILS" /></th>
                                        
                                    </thead>
                                    <tbody>
                                    	<c:if test="${! empty vendorList }">
                                    		<c:forEach items="${vendorList}" var="vendor">
                                    			<tr style="background:#404040; color:#FFF;">
                                    				<td align="center">${vendor.id}</td>
                                    				<td align="center">${vendor.code}</td>
                                    				<td>${vendor.name}</td>
                                    				<td align="center"><a href="javascript:showvendoreditModal(${vendor.id},&quot;${vendor.name}&quot;,&quot;${vendor.code}&quot;,&quot;${vendor.description}&quot;,&quot;${vendor.rating}&quot;,&quot;${vendor.contactNo}&quot;,&quot;${vendor.address}&quot;,&quot;${vendor.type}&quot;,&quot;${vendor.createdBy}&quot;)"> <input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_edit.png"></a></td>
                                           			<td align="center"><a href="javascript:showConfirmdeleteVendorModal(${vendor.id})"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_delete.png"></a></td>
                                            		<td align="center"><a href="javascript:showDetailVendorModal(${vendor.id},&quot;${vendor.name}&quot;,&quot;${vendor.code}&quot;,&quot;${vendor.description}&quot;,&quot;${vendor.rating}&quot;,&quot;${vendor.contactNo}&quot;,&quot;${vendor.address}&quot;,&quot;${vendor.type}&quot;)"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a></td>
                                    			</tr>
                                    		</c:forEach>
                                    	</c:if>
                                        <c:if test="${empty vendorList}">
                                        	<tr style="background:#404040; color:#FFF;">
                                        		<td colspan="6"><spring:message code="admin.vendormgnt.jsp.noDataFound" text="No Data found!" /></td>
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
           					<div class="modal fade" data-backdrop="static" id="vendorAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.vendormgnt.jsp.addVndr" text="Add Vendor" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 20px;">
                                            	<table>
                                            		<tr>
                                            			<td><spring:message code="admin.vendormgnt.jsp.vndrName" text="VENDOR NAME" /><span style="color: #ff0000;">*</span></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="addvendornameContId" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.vendormgnt.jsp.vndrCode" text="VENDOR CODE" /><span style="color: #ff0000;"></span></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="addvendorcodeContId" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.vendormgnt.jsp.vndrDesc" text="VENDOR DESCRIPTION" /><span style="color: #ff0000;"></span></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="addvendordescContId" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.vendormgnt.jsp.vndrRating" text="VENDOR RATING" /><span style="color: #ff0000;"></span></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="addvendorratingContId" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.vendormgnt.jsp.cotcNo" text="CONTACT NO" /><span style="color: #ff0000;"></span></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="addvendorcontactContId" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.vendormgnt.jsp.addr" text="ADDRESS" /><span style="color: #ff0000;">*</span></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="addvendoraddressContId" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.vendormgnt.jsp.vendrType" text="VENDOR TYPE" /><span style="color: #ff0000;">*</span></td>
                                            			<td>:</td>
                                            			<td>
                                            				<select id="vendorTypeId" style="margin-bottom: 5px;color: #222222;">
                                            					<c:if test="${! empty invTypeList}">
                                            					<c:forEach items="${invTypeList}" var="invType">
                                            						<option value="${invType.name}">${invType.name}</option>
                                            					</c:forEach>
                                            					</c:if>
                                            				</select>
                                            			</td>
                                            		</tr>
                                            		
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addvendoralertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.vendormgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:addVendor()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.vendormgnt.jsp.create" text="CREATE" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="vendorEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.vendormgnt.jsp.editVndr" text="Edit Vendor" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 20px;">
                                        	<input type="hidden" id="editvendoridContId" value="">
                                        	<input type="hidden" id="editvendorcreatedbyContId" value="">
                                        	<!-- <input type="hidden" id="editvendorcreateddateContId" value=""> -->
                                            	<table>
                                            		<tr>
                                            			<td><spring:message code="admin.vendormgnt.jsp.vndrName" text="VENDOR NAME" /><span style="color: #ff0000;">*</span></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="editvendornameContId" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.vendormgnt.jsp.vndrCode" text="VENDOR CODE" /><span style="color: #ff0000;"></span></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="editvendorcodeContId" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.vendormgnt.jsp.vndrDesc" text="VENDOR DESCRIPTION" /><span style="color: #ff0000;"></span></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="editvendordescContId" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.vendormgnt.jsp.vndrRating" text="VENDOR RATING" /><span style="color: #ff0000;"></span></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="editvendorratingContId" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.vendormgnt.jsp.cotcNo" text="CONTACT NO" /><span style="color: #ff0000;"></span></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="editvendorcontactContId" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.vendormgnt.jsp.addr" text="ADDRESS" /><span style="color: #ff0000;">*</span></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="editvendoraddressContId" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.vendormgnt.jsp.vendrType" text="VENDOR TYPE" /><span style="color: #ff0000;">*</span></td>
                                            			<td>:</td>
                                            			<td>
                                            				<select id="editvendorTypeId" style="margin-bottom: 5px;color: #222222;">
                                            					<%-- <c:if test="${! empty invTypeList}">
                                            					<c:forEach items="${invTypeList}" var="invType">
                                            						<option value="${invType.name}">${invType.name}</option>
                                            					</c:forEach>
                                            					</c:if> --%>
                                            				</select>
                                            			</td>
                                            		</tr>
                                            		
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="editvendoralertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" onclick="javascript:cancelVendor()" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.vendormgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:editVendor()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.vendormgnt.jsp.edit" text="EDIT" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="confirmdeleteVendorModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.vendormgnt.jsp.confirmation" text="Confirmation!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            	<spring:message code="admin.vendormgnt.jsp.areYouSure" text="Are you sure?" />
                                            	<input type="hidden" id="moddeleteconfirmvendoridContId" value="">
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.vendormgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javacsript:deleteVendor()" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.vendormgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="vendorDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.vendormgnt.jsp.catDetails" text="Category Details" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div align="center" style="font-size: 20px;">
                                            	<table>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.vendormgnt.jsp.id" text="ID" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailvendoridTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.vendormgnt.jsp.name" text="NAME" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailvendornameTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.vendormgnt.jsp.code" text="CODE" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailvendorcodeTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.vendormgnt.jsp.desc" text="DESCRIPTION" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailvendordescTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.vendormgnt.jsp.rating" text="RATING" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailvendorratingTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.vendormgnt.jsp.cotcNo" text="CONTACT NO" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailvendorcontactTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.vendormgnt.jsp.addr" text="ADDRESS" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailvendoraddressTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.vendormgnt.jsp.type" text="TYPE" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailvendortypeTd"></td>
                                            		</tr>
                                    			</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success" data-dismiss="modal"><spring:message code="admin.vendormgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                             <div class="modal fade" data-backdrop="static" id="alertvendordataopModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.vendormgnt.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <div id="vendordataopmassagecont"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="location.href='${pageContext.request.contextPath}/vendormgnt/loadvendormgnt.htm'"  class="btn btn-success"><spring:message code="admin.vendormgnt.jsp.ok" text="OK" /></button>
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
   var language = '<%= session.getAttribute("language") %>';
   var storeID="${sessionScope.loggedinStore.id}";
   var user="${sessionScope.loggedinUser.name}";

   function showvendoraddModal()
	{
		$('#vendorAddModal').modal('show');
		$('#vendorAddModal').on('shown.bs.modal', function () {
		$('#addvendornameContId').focus();});
	}
   function closevendoraddModal()
	{
		$('#vendorAddModal').modal('hide');
	}
   function showvendoreditModal(id,name,code,desc,rating,contact,address,type,crby)
	{
	   	document.getElementById('editvendoridContId').value=id;
	   	document.getElementById('editvendornameContId').value=name;
	   	document.getElementById('editvendorcodeContId').value=code;
	   	document.getElementById('editvendordescContId').value=desc;
	   	document.getElementById('editvendorratingContId').value=rating;
	   	document.getElementById('editvendorcontactContId').value=contact;
	   	document.getElementById('editvendoraddressContId').value=address;
	   	document.getElementById('editvendorcreatedbyContId').value=crby;
	   	//document.getElementById('editvendorcreateddateContId').value=crdate;
	   	var typeselect=document.getElementById('editvendorTypeId');
	   	var typeoption="";
	   	var typeoption1="";
	   	var typearray=[];
	   	<c:forEach items="${invTypeList}" var="invtype" varStatus="loop">
	     	typearray.push('${invtype.name}');
	        </c:forEach>
	    //alert(typearray);  
	   	typeoption="<option value='"+type+"'>"+type+"</option>";
	   	for(var i=0;i<typearray.length;i++)
	   		{
	   		if(typearray[i]!=type)
	   			{
	   			typeoption1+="<option value='"+typearray[i]+"'>"+typearray[i]+"</option>";
	   			}
	   		}
	   	var typeoptionfinal=typeoption+typeoption1;
	   	//alert(typeoptionfinal);
	   	document.getElementById('editvendorTypeId').innerHTML=typeoptionfinal;       
	   	 
		$('#vendorEditModal').modal('show');
	}
   function closevendoreditModal()
	{
		$('#vendorEditModal').modal('hide');
	}
   function showConfirmdeleteVendorModal(id)
   {
	   document.getElementById('moddeleteconfirmvendoridContId').value=id;
	   $('#confirmdeleteVendorModal').modal('show');
   }
   function showDetailVendorModal(id,name,code,desc,rating,contact,address,type)
   {
	   document.getElementById('moddetailvendoridTd').innerHTML=id;
	   document.getElementById('moddetailvendornameTd').innerHTML=name;
	   document.getElementById('moddetailvendorcodeTd').innerHTML=code;
	   document.getElementById('moddetailvendordescTd').innerHTML=desc;
	   document.getElementById('moddetailvendorratingTd').innerHTML=rating;
	   document.getElementById('moddetailvendorcontactTd').innerHTML=contact;
	   document.getElementById('moddetailvendoraddressTd').innerHTML=address;
	   document.getElementById('moddetailvendortypeTd').innerHTML=type;
	   $('#vendorDetailModal').modal('show');
   }
   
   function showalertvendordataopModal()
	{
		$('#alertvendordataopModal').modal('show');
	}
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
