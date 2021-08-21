<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
<title>.: POS :: Expenditure :.</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link
	href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css"
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
						<div style="color: #FFF; font-size: 16px; font-weight: bold;">EXPENDITURE</div>
						
					</div>
                     <div class="col-md-12 col-sm-12" style="color: #FA5726; font-size: 14px; font-weight: bold;text-decoration: underline;">
						<spring:message code="admin.expenditure.jsp.expenditure.alertmsg" text="[Please don't insert purchase type expenditures if you already using the daily inventory management module. If you do that you can't get proper accounts report.]" />
					</div>
                         
					<div class="col-md-12 col-sm-12">
						<!--   Kitchen Sink -->
						<div style="max-height: 400px; overflow-y: auto;">
							<div class="panel panel-default">
								<div class="panel-body">
									<div class="table-responsive" style="background: #404040;">
										<table class="table  table-bordered" id="tbl">
											<thead>
												<tr
													style="background: #404040; color: #FFF; font-size: 16px; font-weight: bold;">
													<!-- <td align="center">Date</td>
													<td align="center">Voucher No.</td>
													<td align="center">Particulars</td>
													<td align="center">Amount</td> -->
													<td align="center" width="10%">Type</td>
													<td align="center" width="10%">Date</td>
													<td align="center" width="15%">Voucher No.</td>
													<td align="center" width="10%">Vendor Name</td>
													<td align="center" width="20%">Particulars</td>
													<td align="center" width="10%">Amount</td>
													<td align="center" width="5%">Tax(%)</td>
													<td align="center" width="10%">Tax Amt</td>
													<td align="center" width="10%">Net Amt</td>
													
													</tr>
											</thead>
											<tbody id="tbdy">
												<!-- <tr class="item"
													style="background: #404040; color: #FFF; margin-top: 2px;">
													<td style="color: #000"  align="center"><input
														type="text" id="vochdate" name="vocdate" class="vocdate" required="required" /></td>
													<td style="color: #000" align="center"><input
														type="text" id="vochno" name="vocno" class="vocno" required="required" /></td>
													<td style="color: #000" align="center"><input
														type="text" id="vochpart" class="part" name="particulars" required="required" /></td>
													<td style="color: #000" align="center"><input
														type="text" id="vochamt" name="expamt" size="4" class="expAmt" required="required"
														onkeyup="keyup()" /></td>

												</tr> -->
												
												<tr class="item"
													style="background: #404040; color: #FFF; margin-top: 2px;">
													
													<td style="color: #000" align="center" width="10%" id="expenditureTypeList">
													   <select id="expstype_0" name="exptype" class="expType" required="required" style="width:100%; padding: 2px" onchange="selectExpType(this.value);">
	                                                         <c:forEach items="${expenditureTypes}" var="exptype">
                                                                    <option value="${exptype.id}">${exptype.typeName}</option>
	                                                         </c:forEach>
                                                       </select>
													</td>
													<td style="color: #000"  align="center" width="10%"><input
														type="text" id="vochdate" name="vocdate" class="vocdate" required="required" style="width:100%; padding: 2px" /></td>
													<td style="color: #000" align="center" width="15%"><input
														type="text" id="vochno" name="vocno" class="vocno" required="required" style="width:100%; padding: 2px"/></td>
													
													<td style="color: #000" align="center" width="10%"><input
														type="text" id="vendorname" name="vendname" class="vendname"  style="width:100%; padding: 2px"/></td>
													
													<td style="color: #000" align="center" width="20%"><input
														type="text" id="vochpart" class="part" name="particulars" required="required" style="width:100%; padding: 2px" /></td>
													<td style="color: #000" align="center" width="10%"><input
														type="text" id="vochamt" name="expamt" size="4" class="expAmt" required="required"
														onkeyup="setNetAmt(this.value);keyup();" onkeydown="numcheck(event);" style="width:100%; padding: 2px" /></td>

												    
												       <td style="color: #000" align="center" width="5%"><input
														type="text" id="taxperc" class="taxrate" name="taxrate"     style="width:100%; padding: 2px" onkeyup="taxCalculate(this.value);" onkeydown="numcheck(event);" /></td>
														<td style="color: #000" align="center" width="10%"><input readonly
														type="text" id="taxamt" class="taxamount" name="taxamount"  style="width:100%; padding: 2px" /></td>
											        	<td style="color: #000" align="center" width="10%"><input readonly
														type="text" id="netamt" class="netamount" name="netamount"  style="width:100%; padding: 2px" /></td>
												</tr>
											</tbody>
										</table>
										<table class="table table-hover">
											<tr style="background: #404040; color: #FFF;">
												<td></td>
												<!-- <td style="color: #fff" align="center">Total</td>
												
												<td style="color: #000" align="center"><input
													type="text" class="totExp" name="total" size="4"
													disabled="disabled" /></td> -->
												<td style="color: #fff" align="center"></td>
												<td style="color: #fff" align="center"></td>

												<td style="color: #000" align="center"><input
													type="button" id="add" class="btn btn-success" onclick="javascript:addRow('tbl')" value="+" /></td>
							
													<td style="color: #000" align="center"><input
													type="button" id="save" class="btn btn-success" onclick="javascript:saveExpenditure()" value="Save" /></td>

											</tr>
										</table>
									</div>
								</div>
							</div>
						</div>
						<!-- End  Kitchen Sink -->
					</div>
				</div>
				<!-- modal starts -->
            				<div class="modal fade" data-backdrop="static" id="expModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">Alert!</h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                           		All fields are required!
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button"  style="background: #72BB4F;font-weight: bold;" data-dismiss="modal" class="btn btn-success">OK</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
           <!-- modal ends -->
            <!-- modal starts -->
            				<div class="modal fade" data-backdrop="static" id="expGreaterDateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">Alert!</h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            Given date is greater than today's date!
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
	 var BASE_URL="${pageContext.request.contextPath}";
	 var expTypes =[];
	 expTypes = '<%= session.getAttribute("expenditureTypesList") %>';
	 
		// When the document is ready
		$(document).ready(function() {

			$('.vocdate').datepicker({
				format : "yyyy-mm-dd",
				autoclose : true
			});

		});
		
		function showExpAlertModal() {
			$('#expModal').modal('show');
		}
		
		function showExpGreaterAlertModal() {
			$('#expGreaterDateModal').modal('show');
		}
		
		
		// new added 19th April 2018 (updated 18.05.2018)
		
		function setNetAmt(amt){
			var taxrate = document.getElementById('taxperc').value;
			if(amt == '' || amt == 0){
				document.getElementById('taxamt').value = '';
				document.getElementById('netamt').value = '';
			}
			else{
			        if(taxrate == '' || taxrate == 0){
				         document.getElementById('netamt').value = parseFloat(amt).toFixed(2); 
			           }
			        else{
				         var taxamt = ((parseFloat(amt).toFixed(2) * parseFloat(taxrate).toFixed(2)) / 100);
				         var netamt = Number(amt)+Number(taxamt);
				         document.getElementById('taxamt').value = parseFloat(taxamt).toFixed(2);
				         document.getElementById('netamt').value = parseFloat(netamt).toFixed(2);
			            }
		        }
			
		}
		
		function taxCalculate(tax){
			var grossamt = document.getElementById('vochamt').value;	
			if(tax == ''){
				   if(grossamt != ''){
			           document.getElementById('netamt').value = parseFloat(grossamt).toFixed(2);
				      }
				   else{
					   document.getElementById('netamt').value = ''; 
				      }
			       document.getElementById('taxamt').value = '';
			}
			else{
				if(grossamt == ''){
					document.getElementById('taxamt').value = '';
					document.getElementById('netamt').value = '';
						
				}
				else{
			var taxamt = ((parseFloat(grossamt).toFixed(2) * parseFloat(tax).toFixed(2)) / 100);
			var currentnetamt= Number(grossamt)+Number(taxamt);
			document.getElementById('taxamt').value = parseFloat(taxamt).toFixed(2);
			document.getElementById('netamt').value = parseFloat(currentnetamt).toFixed(2);
				}
			 }
			}
		
	</script>
</body>
</html>