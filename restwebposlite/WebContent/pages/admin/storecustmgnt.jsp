<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1" />
<meta name="description" content="" />
<meta name="author" content="" />
<!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
<title>:. POS :: Customer Management :.</title>
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
<link
	href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css"
	rel="stylesheet" />
<link rel="icon" id="favicon"
	href="${pageContext.request.contextPath}/assets/images/title/fb.png">

<!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
	<jsp:include page="/pages/common/header.jsp"></jsp:include>
	<c:set var="today" value="<%=new java.util.Date()%>" />
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="row">
				<jsp:include page="/pages/admin/admleftpanel.jsp"></jsp:include>

				<div class="col-md-10 col-sm-10">
				<div class="col-md-12 col-sm-12">
					<div class="col-md-1 col-sm-1">
						<div style="color: #FFF; font-size: 16px; font-weight: bold;">CUSTOMER</div>
						
					</div>
					<div class="col-md-9 col-sm-9" style="text-align:left;">
					   <input type="text" class="text-input" id="filter" placeholder="Search Customer by Name..." value="" style="width: 50%; " />
					
					</div>
					<div class="col-md-2 col-sm-2">
						<a href="javascript:showstorecustaddModal()"
							class="btn btn-success"
							style="width: 80px; background: #78B626; margin-bottom: 3px;">ADD</a>
					</div>
				</div>
				<div class="col-md-12 col-sm-12">
						<!--   Kitchen Sink -->
						<div style="max-height: 400px; overflow-y: auto;">
							<div class="panel panel-default">

								<div class="panel-body">
									<div class="table-responsive" style="background: #404040;">
										<table class="table table-striped table-bordered table-hover" id="customerList">
											<thead style="background: #404040; color: #FFF;">

												<th style="text-align: center;">ID</th>
												<th style="text-align: center;">NAME</th>
												<th style="text-align: center;">CONTACT</th>
												<th style="text-align: center;">EDIT</th>
												<th style="text-align: center;">DELETE</th>
												<th style="text-align: center;">DETAILS</th>

											</thead>
											<tbody>
												<c:if test="${! empty storecustList }">
													<c:forEach items="${storecustList}" var="storecust">
														<tr style="background: #404040; color: #FFF;">
															<td align="center">${storecust.id}</td>
															<td>${storecust.name}</td>
															<td align="center">${storecust.contactNo}</td>
															<td align="center"><a
															
																href="javascript:showstorecusteditModal(${storecust.id},&quot;${storecust.name}&quot;,&quot;${storecust.contactNo}&quot;,&quot;${storecust.address}&quot;,&quot;${storecust.emailId}&quot;,&quot;${storecust.location}&quot;,&quot;${storecust.address}&quot;,&quot;${storecust.house_no}&quot;,&quot;${storecust.street}&quot;,&quot;${storecust.dob}&quot;,&quot;${storecust.anniversary}&quot;,${storecust.creditLimit},&quot;${storecust.creditCustomer}&quot;)">
																	<input type="image"
																	src="${pageContext.request.contextPath}/assets/images/admin/g/g_edit.png">
															</a></td>
															<td align="center"><a
																href="javascript:showConfirmdeleteStoreCustModal(${storecust.id})"><input
																	type="image"
																	src="${pageContext.request.contextPath}/assets/images/admin/g/g_delete.png"></a></td>
															<td align="center"><a
																href="javascript:showDetailStoreCustModal(${storecust.id},&quot;${storecust.name}&quot;,&quot;${storecust.contactNo}&quot;,&quot;${storecust.address}&quot;,&quot;${storecust.emailId}&quot;,&quot;${storecust.location}&quot;,&quot;${storecust.address}&quot;,&quot;${storecust.house_no}&quot;,&quot;${storecust.street}&quot;,&quot;${storecust.dob}&quot;,&quot;${storecust.anniversary}&quot;,${storecust.creditLimit},&quot;${storecust.creditCustomer}&quot;)"><input
																	type="image"
																	src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a></td>
														</tr>
													</c:forEach>
												</c:if>
												<c:if test="${empty storecustList}">
													<tr style="background: #404040; color: #FFF;">
														<td colspan="6">No Data found!</td>
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
			<div class="modal fade" data-backdrop="static" id="storecustAddModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">Add
								Customer</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: left; font-size: 20px;">
								<table>
									<tr>
										<td>NAME <span style="color: #ff0000;">*</span></td>
										<td>:</td>
										<td style="margin-bottom: 3px;"><input type="text"
											id="addstorecustnameContId"
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td>CONTACT NO <span style="color: #ff0000;">*</span></td>
										<td>:</td>
										<td><input type="text" id="addstorecustcontactContId" maxlength="10"
											style="width: 95%; color: #222222; margin-bottom: 5px;" onkeypress='return isNumberKey(event)'/></td>
									</tr>
									<tr>
										<td>EMAIL ID</td>
										<td>:</td>
										<td><input type="text" id="addstorecustemailContId"
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td>LOCATION</td>
										<td>:</td>
										<td><input type="text" id="addstorelcustlocation"
											style="width: 95%; color: #222222; margin-bottom: 5px;"
											 /></td>
									</tr>
									<tr>
										<td>ADDRESS</td>
										<td>:</td>
										<td><textarea id="addstorecustaddressContId" rows="2"
												style="margin-bottom: 2px; color: #222222; width: 95%; margin-bottom: 5px;"></textarea></td>
									</tr>

									<tr>
										<td>HOUSE NO</td>
										<td>:</td>
										<td><input type="text" id="addstorecusthouseno"
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td>STREET NO</td>
										<td>:</td>
										<td><input type="text" id="addstorecuststreet"
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>

									<tr>
										<td>DATE OF BIRTH</td>
										<td>:</td>
										<td><input type="text" id="addstorecustdob"	style="width: 95%; color: #222222; margin-bottom: 5px;"value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>"></td>
									</tr>

									<tr>
										<td>ANNIVERSARY DATE</td>
										<td>:</td>
										<td><input type="text" id="addstorecustanniversarydate"
											style="width: 95%; color: #222222; margin-bottom: 5px;"value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>"></td>
									</tr>
									<tr>
										<td>CREDIT LIMIT</td>
										<td>:</td>
										<td><input type="text" id="addstorecustcrlimitContId"
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>

								</table>
								<div
									style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
									id="addstorecustalertMsg"></div>
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #F60; font-weight: bold; width: 25%"
								class="btn btn-warning" data-dismiss="modal">CANCEL</button>
							<button type="button" onclick="javascript:addStoreCustomer()"
								style="background: #72BB4F; font-weight: bold; width: 25%"
								class="btn btn-success">CREATE</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static"
				id="storecustEditModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">Edit
								Customer</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: left; font-size: 20px;">
								<input type="hidden" id="editstorecustidContId" value="">
								<table>
									<tr>
										<td>NAME <span style="color: #ff0000;">*</span></td>
										<td>:</td>
										<td style="margin-bottom: 3px;"><input type="text"
											id="editstorecustnameContId"
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td>CONTACT NO <span style="color: #ff0000;">*</span></td>
										<td>:</td>
										<td><input type="text" id="editstorecustcontactContId" maxlength="10"
											style="width: 95%; color: #222222; margin-bottom: 5px;" onkeypress='return isNumberKey(event)'/></td>
									</tr>
								<!-- 	<tr>
										<td>ADDRESS</td>
										<td>:</td>
										<td><textarea id="editstorecustaddressContId" rows="2"
												style="margin-bottom: 2px; color: #222222; width: 95%; margin-bottom: 5px;"></textarea></td>
									</tr> -->
									<tr>
										<td>EMAIL ID</td>
										<td>:</td>
										<td><input type="text" id="editstorecustemailContId"
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td>LOCATION</td>
										<td>:</td>
										<td><input type="text" id="editstorelcustlocation"
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td>ADDRESS</td>
										<td>:</td>
										<td><textarea id="editstorecustaddressContId" rows="2"
												style="margin-bottom: 2px; color: #222222; width: 95%; margin-bottom: 5px;"></textarea></td>
									</tr>

									<tr>
										<td>HOUSE NO</td>
										<td>:</td>
										<td><input type="text" id="editstorecusthouseno"
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td>STREET NO</td>
										<td>:</td>
										<td><input type="text" id="editstorecuststreet"
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>

									<tr>
										<td>DATE OF BIRTH</td>
										<td>:</td>
										<td><input type="text" id="editstorecustdob"	
											style="width: 95%; color: #222222; margin-bottom: 5px;"></td>
									</tr>

									<tr>
										<td>ANNIVERSARY DATE</td>
										<td>:</td>
										<td><input type="text" id="editstorecustanniversarydate"
											style="width: 95%; color: #222222; margin-bottom: 5px;"></td>
									</tr>
									<tr>
										<td>CREDIT LIMIT</td>
										<td>:</td>
										<td><input type="text" id="editstorecustcrlimitContId"
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td>CREDIT CUSTOMER</td>
										<td>:</td>
										<td><select id="editstorecustcreditflagContId"
											style="margin-bottom: 2px; color: #222222; margin-bottom: 5px;">

										</select></td>
									</tr>



								</table>
								<div
									style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
									id="editstorecustalertMsg"></div>
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #F60; font-weight: bold; width: 25%"
								class="btn btn-warning" data-dismiss="modal">CANCEL</button>
							<button type="button" onclick="javascript:editStoreCustomer()"
								style="background: #72BB4F; font-weight: bold; width: 25%"
								class="btn btn-success">EDIT</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static"
				id="confirmdeleteStoreCustModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">Confirmation!</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								Are you sure? <input type="hidden"
									id="moddeleteconfirmstorecustidContId" value="">
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #F60; font-weight: bold; width: 25%;"
								class="btn btn-warning" data-dismiss="modal">CANCEL</button>
							<button type="button" onclick="javacsript:deleteStoreCustomer()"
								style="background: #72BB4F; font-weight: bold; width: 25%;"
								data-dismiss="modal" class="btn btn-success">OK</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" data-backdrop="static"
				id="storecustDetailModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">Customer
								Details</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div align="center" style="font-size: 20px;">
								<table>
									<tr>
										<td style="padding: 5px 0px;">ID</td>
										<td width="5%">:</td>
										<td id="moddetailstorecustidTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;">NAME</td>
										<td width="5%">:</td>
										<td id="moddetailstorecustnameTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;">CONTACT NO</td>
										<td width="5%">:</td>
										<td id="moddetailstorecustcontactTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;">EMAIL ID</td>
										<td width="5%">:</td>
										<td id="moddetailstorecustemailTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;">LOCATION</td>
										<td width="5%">:</td>
										<td id="moddetailstorecustlocationTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;">ADDRESS</td>
										<td width="5%">:</td>
										<td id="moddetailstorecustaddressTd"></td>
									</tr>
											<tr>
										<td style="padding: 5px 0px;">HOUSE NO</td>
										<td width="5%">:</td>
										<td id="moddetailstorehousenoTd"></td>
									</tr>
											<tr>
										<td style="padding: 5px 0px;">STREET NO</td>
										<td width="5%">:</td>
										<td id="moddetailstorecuststreetnoTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;">DATE OF BIRTH</td>
										<td width="5%">:</td>
										<td id="moddetailstorecustdateofbirthTd"></td>
									</tr>
											<tr>
										<td style="padding: 5px 0px;">ANNIVERSARY DATE</td>
										<td width="5%">:</td>
										<td id="moddetailstorecustanniversaryTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;">CREDIT LIMIT</td>
										<td width="5%">:</td>
										<td id="moddetailstorecustcrlimitTd"></td>
									</tr>
									<tr>
										<td style="padding: 5px 0px;">CREDIT CUSTOMER</td>
										<td width="5%">:</td>
										<td id="moddetailstorecustcreditflagTd"></td>
									</tr>
								</table>

							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #72BB4F; font-weight: bold; width: 25%"
								class="btn btn-success" data-dismiss="modal">OK</button>
						</div>
					</div>
				</div>
			</div>
			
			<div class="modal fade" data-backdrop="static" id="alertcatdataopModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                         <div style="text-align: center;font-size: 20px;">
                                            <div id="catdataopmassagecont"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="location.href='${pageContext.request.contextPath}/storecustomermgnt/loadstorecustomermgnt.htm'" data-dismiss="modal" class="btn btn-success">OK</button>
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
	<script
		src="${pageContext.request.contextPath}/assets/js/adminScript.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
	<!-- CORE JQUERY SCRIPTS -->
	<script
		src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
	<!-- BOOTSTRAP SCRIPTS  -->
	<script
		src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>

	<script
		src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>
	<script type="text/javascript">
		var BASE_URL = "${pageContext.request.contextPath}";

		function showstorecustaddModal() {
			document.getElementById('addstorecustnameContId').value = '';
			document.getElementById('addstorecustcontactContId').value = '';
			document.getElementById('addstorecustaddressContId').value = '';
			document.getElementById('addstorecustemailContId').value = '';
			document.getElementById('addstorecustcrlimitContId').value = '';
			document.getElementById('addstorecustalertMsg').innerHTML = '';
			$('#storecustAddModal').modal('show');
		}
		function closestorecustaddModal() {
			$('#storecustAddModal').modal('hide');
		}
	
		function showstorecusteditModal(id, name, contact, address, email,location,address,houseNo,street,dob,anniversary,
				crlimit, crflag) {
			document.getElementById('editstorecustalertMsg').innerHTML = '';
			document.getElementById('editstorecustidContId').value = id;
			document.getElementById('editstorecustnameContId').value = name;
			document.getElementById('editstorecustcontactContId').value = contact;
			document.getElementById('editstorecustaddressContId').value = address;
			document.getElementById('editstorecustemailContId').value = email;
			document.getElementById('editstorelcustlocation').value = location;
			document.getElementById('editstorecustaddressContId').value = address;
			document.getElementById('editstorecusthouseno').value = houseNo;
			document.getElementById('editstorecuststreet').value = street;
			if(isNaN(dob)){
				document.getElementById('editstorecustdob').value = formatDate(dob);

			}
			else
				{
				document.getElementById('editstorecustdob').value="";
				}
			if(isNaN(anniversary)){
				document.getElementById('editstorecustanniversarydate').value = formatDate(anniversary);

			}
			else
				{
				document.getElementById('editstorecustanniversarydate').value="";
				}
			document.getElementById('editstorecustcrlimitContId').value = crlimit;
			var creditcust = "";
			if (crflag == 'Y') {
				creditcust = "<option value='Y'>ENABLE</option><option value='N'>DISABLE</option>";
			} else {
				creditcust = "<option value='N'>DISABLE</option><option value='Y'>ENABLE</option>";
			}
			document.getElementById('editstorecustcreditflagContId').innerHTML = creditcust;
			$('#storecustEditModal').modal('show');
		}
		function closestorecusteditModal() {
			$('#storecustEditModal').modal('hide');
		}
		function showalertcatdataopModal()
		 {
		  $('#alertcatdataopModal').modal('show');
		 }
		
		function showConfirmdeleteStoreCustModal(id) {
			document.getElementById('moddeleteconfirmstorecustidContId').value = id;
			$('#confirmdeleteStoreCustModal').modal('show');
		}
		function showDetailStoreCustModal(id, name, contact, address, email,location,address,houseNo,street,dob,anniversary,
				crlimit, crflag) {
			document.getElementById('moddetailstorecustidTd').innerHTML = id;
			document.getElementById('moddetailstorecustnameTd').innerHTML = name;
			document.getElementById('moddetailstorecustcontactTd').innerHTML = contact;
			document.getElementById('moddetailstorecustaddressTd').innerHTML = address;
			document.getElementById('moddetailstorecustemailTd').innerHTML = email;
			document.getElementById('moddetailstorecustlocationTd').innerHTML = location;
			document.getElementById('moddetailstorecustaddressTd').innerHTML = address;
			document.getElementById('moddetailstorehousenoTd').innerHTML = houseNo;
			document.getElementById('moddetailstorecuststreetnoTd').innerHTML = street;
			if(isNaN(dob)){
				document.getElementById('moddetailstorecustdateofbirthTd').innerHTML = formatDate(dob);

			}
			else
				{
				document.getElementById('moddetailstorecustdateofbirthTd').innerHTML="";
				}
			if(isNaN(anniversary)){
				document.getElementById('moddetailstorecustanniversaryTd').innerHTML = formatDate(anniversary);

			}
			else
				{
				document.getElementById('moddetailstorecustanniversaryTd').innerHTML="";
				}
			document.getElementById('moddetailstorecustcrlimitTd').innerHTML = crlimit;
			document.getElementById('moddetailstorecustcreditflagTd').innerHTML = crflag;
			$('#storecustDetailModal').modal('show');
		}
		
		$(document).ready(function() {

			   $('#addstorecustanniversarydate').datepicker({
			    format : "yyyy-mm-dd",
			    autoclose : true,
			    endDate: '0'
			    
			   }); 
			   $('#addstorecustdob').datepicker({
			    format : "yyyy-mm-dd",
			    autoclose : true,
			    endDate: '0'
			   }); 
			   
			   $('#editstorecustanniversarydate').datepicker({
				    format : "yyyy-mm-dd",
				    autoclose : true,
				    endDate: '0'
				    
				   }); 
				   $('#editstorecustdob').datepicker({
				    format : "yyyy-mm-dd",
				    autoclose : true,
				    endDate: '0'
				   });
			 });
		

		function isNumberKey(evt){
	         var charCode = (evt.which) ? evt.which : evt.keyCode;
	         if (charCode > 31 && (charCode < 48 || charCode > 57))
	             return false;
	         return true;
	     }	
		
		
		 $("#filter").keyup(function(){
			   var filter = $(this).val().toLowerCase(), count = 0;
	        $("#customerList tbody tr").each(function(index){
	           $row = $(this);
	           var id = $row.find("td").eq(1).text().toLowerCase();
	             if (id.indexOf(filter) != 0) {
							$row.hide();
						}
						else {
							$row.show();
						}
	             
	         });

	 });
	</script>

</body>
</html>
