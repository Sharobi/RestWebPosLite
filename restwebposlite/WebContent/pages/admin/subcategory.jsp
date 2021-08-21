<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
    <title>:. POS :: Sub Category :.</title>
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
				<div class="col-md-6 col-sm-6">
                    <div style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="admin.subcategory.jsp.subCategory" text="SUB CATEGORY" /></div> 
                </div><div class="col-md-4 col-sm-4">
                    <c:if test="${! empty catList }">
                    	<select id="menucatId" onchange="javascript:loadsubCategoryPage(this.value)">
                    		 <c:if test="${! empty menucategory }">
                    			<option value="${menucategory.id}">${menucategory.menuCategoryName}</option>
                    		</c:if>
                    		<c:forEach items="${catList}" var="menucat">
                    		<c:if test="${! empty menucategory }">
                    			 <c:if test="${menucategory.id!=menucat.id }"> 
                    				<option value="${menucat.id}">${menucat.menuCategoryName}</option>
                    			 </c:if>
                    		</c:if>
                    		<c:if test="${ empty menucategory }">
                    			<option value="${menucat.id}">${menucat.menuCategoryName}</option>
                    		</c:if> 
                    		</c:forEach>
                    	</select>
                    </c:if> 
                </div>
                <div class="col-md-2 col-sm-2">
                    <a href="javascript:shownmenusubcataddModal()" class="btn btn-success" style="width:80px; background:#78B626;margin-bottom: 3px;"><spring:message code="admin.subcategory.jsp.add" text="ADD" /></a>
                </div>
                <div class="col-md-12 col-sm-12">
                  <!--   Kitchen Sink -->
                  <div style="max-height: 400px;overflow-y:auto; ">
                    <div class="panel panel-default">
                        
                        <div class="panel-body">
                            <div class="table-responsive" style="background:#404040;">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead style="background:#404040; color:#FFF;">
                                        
                                            <th style="text-align:center;"><spring:message code="admin.subcategory.jsp.id" text="ID" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.subcategory.jsp.name" text="NAME" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.subcategory.jsp.edit" text="EDIT" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.subcategory.jsp.delete" text="DELETE" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.subcategory.jsp.details" text="DETAILS" /></th>
                                            <c:if test="${sessionScope.loggedinStore.kotPrintType=='subcategory'}">
                                            <th style="text-align:center;"><spring:message code="admin.subcategory.jsp.kotPrinter" text="KOT PRINTER" /></th>
                                            </c:if>
                                        
                                    </thead>
                                    <tbody>
                                    	<c:if test="${! empty menusubcategorylist }">
                                    		<c:forEach items="${menusubcategorylist}" var="menusubcategoy">
                                    			<tr style="background:#404040; color:#FFF;">
                                    				<td align="center">${menusubcategoy.id}</td>
                                    				<td>${menusubcategoy.menuCategoryName}</td>
                                    				<td align="center"><a href="javascript:shownmenusubcateditModal(${menusubcategoy.id},&quot;${menusubcategoy.menuCategoryName}&quot;,&quot;${menusubcategoy.bgColor}&quot;)"> <input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_edit.png"></a></td>
                                           			<td align="center"><a href="javascript:showConfirmdeleteSubCatModal(${menusubcategoy.id},&quot;${menusubcategoy.menuCategoryName}&quot;,&quot;${menusubcategoy.bgColor}&quot;)"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_delete.png"></a></td>
                                            		<td align="center"><a href="javascript:showDetailSubCatModal(${menusubcategoy.id},&quot;${menusubcategoy.menuCategoryName}&quot;,&quot;${menusubcategoy.bgColor}&quot;)"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a></td>
                                            		<c:if test="${sessionScope.loggedinStore.kotPrintType=='subcategory'}">
                                            		<td align="center"><a href="javascript:showSubCatKOTPrinterModal(${menusubcategoy.id},&quot;${menusubcategoy.menuCategoryName}&quot;)"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_tprinter.png"></a></td>
                                            		</c:if>
                                    			</tr>
                                    		</c:forEach>
                                    	</c:if>
                                        <c:if test="${empty menusubcategorylist}">
                                        	<tr style="background:#404040; color:#FFF;">
                                        		<td colspan="5"><spring:message code="admin.subcategory.jsp.noDataFound" text="No Data found!" /></td>
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
                <div class="modal fade" data-backdrop="static" id="menusubcatAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.subcategory.jsp.addSubCategory" text="Add Sub Category" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 20px;">
                                            	<table>
                                            		<tr>
                                            			<td><spring:message code="admin.subcategory.jsp.subCatName" text="SUB CATEGORY NAME" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="addsubcategorynameContId" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.subcategory.jsp.bgColor" text="BACKGROUND COLOR" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="addsubcatbgcolorContId" value="fff" style="text-align:center; width:95%; color: #222222" /></td>
                                            		</tr>
                                            		
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addsubcatalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.subcategory.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:addSubCategory()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.subcategory.jsp.create" text="CREATE" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="menusubcatEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.subcategory.jsp.edtSubCat" text="Edit Sub Category" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 20px;">
                                        	<input type="hidden" id="modeditsubcatidContId" value="">
                                            	<table>
                                            		<tr>
                                            			<td><spring:message code="admin.subcategory.jsp.subCatName" text="SUB CATEGORY NAME" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="editsubcategorynameContId" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td><spring:message code="admin.subcategory.jsp.bgColor" text="BACKGROUND COLOR" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="editsubcatbgcolorContId" style="text-align:center; width:95%; color: #222222" /></td>
                                            		</tr>
                                            		
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="editsubcatalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" onclick="javascript:cancelSubCategory()" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.subcategory.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:editSubCategory()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.subcategory.jsp.edit" text="EDIT" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="confirmdeleteSubCatModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.subcategory.jsp.confirmation" text="Confirmation!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            	<spring:message code="admin.subcategory.jsp.areYouSure" text="Are you sure?" />
                                            	<input type="hidden" id="moddeleteconfirmsubcatidContId" value="">
                                            	<input type="hidden" id="moddeleteconfirmsubcatnameContId" value="">
                                            	<input type="hidden" id="moddeleteconfirmsubcatbgcolorContId" value="">
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.subcategory.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javacsript:deleteSubCategory()" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.subcategory.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="menusubcatDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.subcategory.jsp.subCatDetails" text="Sub Category Details" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div align="center" style="font-size: 20px;">
                                            	<table>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.subcategory.jsp.id" text="ID" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailsubcatidTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.subcategory.jsp.subCatName" text="SUB CATEGORY NAME" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailsubcatnameTd"></td>
                                            		</tr>
                                            		<tr class="hide">
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.subcategory.jsp.bgColor" text="BACKGROUND COLOR" />&nbsp;&nbsp;</td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetailsubcatbgcolorTd"></td>
                                            		</tr>
                                            		
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success" data-dismiss="modal"><spring:message code="admin.subcategory.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                             <div class="modal fade" data-backdrop="static" id="menusubcataddkotPrinterModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.subcategory.jsp.addKotPrinter" text="Add KOT Printer" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div align="center" style="font-size: 20px;">
                                            	<table>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.subcategory.jsp.id" text="ID" /><spring:message code="admin.subcategory.jsp.id" text="ID" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="modsubcatkotsubcatidTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.subcategory.jsp.subCatName" text="SUB CATEGORY NAME" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="modsubcatkotsubcatnameTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.subcategory.jsp.printerLocation" text="PRINTER LOCATION" /></td>
                                            			<td width="5%">:</td>
                                            			<td>
                                            			<select id="modsubcatkotprinterloc" style="color: #222222;"></select>
                                            			</td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.subcategory.jsp.printerName" text="PRINTER NAME" /></td>
                                            			<td width="5%">:</td>
                                            			<td>
                                            			<input type="text" id="modsubcatkotprintername" style="text-align:center; width:95%; color: #222222" />
                                            			</td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.subcategory.jsp.kitchenName" text="KITCHEN NAME" /></td>
                                            			<td width="5%">:</td>
                                            			<td>
                                            			<input type="text" id="modsubcatkotkitchenname" style="text-align:center; width:95%; color: #222222" />
                                            			</td>
                                            		</tr>
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addsubcatkotalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.subcategory.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javacsript:AddSubCatKOTPrinter()" style="background: #72BB4F;font-weight: bold;width: 25%;"  class="btn btn-success"><spring:message code="admin.subcategory.jsp.add" text="ADD" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                           
                            <div class="modal fade" data-backdrop="static" id="alertsubcatdataopModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.subcategory.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                        	<input type="hidden" id="alertsubcatiddataopmodal" >
                                            <div id="subcatdataopmassagecont"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" onclick="javacsript:loadsubCategoryPage(document.getElementById('alertsubcatiddataopmodal').value);" style="background: #72BB4F;font-weight: bold;width: 25%"  data-dismiss="modal" class="btn btn-success"><spring:message code="admin.subcategory.jsp.ok" text="OK" /></button>
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
   var storeID="${sessionScope.loggedinStore.id}";
   /* for sub category*/
   function shownmenusubcataddModal()
   {
   	$('#menusubcatAddModal').modal('show');
   	$('#menusubcatAddModal').on('shown.bs.modal', function () {
	$('#addsubcategorynameContId').focus();});
   }
   function closenmenusubcataddModal()
   {
   	$('#menusubcatAddModal').modal('hide');
   }
   function shownmenusubcateditModal(id,name,color)
	{
	   if( color.charAt( 0 ) == '#' )
		   color = color.slice( 1 );
	   	document.getElementById('modeditsubcatidContId').value=id;
	   	document.getElementById('editsubcategorynameContId').value=name;
	   	document.getElementById('editsubcatbgcolorContId').value=color;
		$('#menusubcatEditModal').modal('show');
	}
  function closenmenusubcateditModal()
	{
		$('#menusubcatEditModal').modal('hide');
	}
  function showConfirmdeleteSubCatModal(id,name,color)
  {
	   if( color.charAt( 0 ) == '#' )
		   color = color.slice( 1 );
	   document.getElementById('moddeleteconfirmsubcatidContId').value=id;
	   document.getElementById('moddeleteconfirmsubcatnameContId').value=name;
	   document.getElementById('moddeleteconfirmsubcatbgcolorContId').value=color;
	   $('#confirmdeleteSubCatModal').modal('show');
  }
  function showDetailSubCatModal(id,name,color)
  {
	   document.getElementById('moddetailsubcatidTd').innerHTML=id;
	   document.getElementById('moddetailsubcatnameTd').innerHTML=name;
	   document.getElementById('moddetailsubcatbgcolorTd').innerHTML=color;
	   $('#menusubcatDetailModal').modal('show');
  }
  
  function showmenusubcatkotaddModal()
	{
		$('#menusubcataddkotPrinterModal').modal('show');
	}
	function closemenusubcatkotaddModal()
	{
		$('#menusubcataddkotPrinterModal').modal('hide');
	}
	function showalertsubcatdataopModal()
	{
		$('#alertsubcatdataopModal').modal('show');
	}
   /* end for sub category*/
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