<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
<title>:. POS :: Recipe Ingredient :.</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
<!-- FONT AWESOME ICONS  -->
<link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/jquery-ui.css" rel="stylesheet" />
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
			<div class="row-fluid">
				<div class="col-sm-2">
					<div>
						<button type="button" class="btn btn-success">Recipe Ingredients</button>
					</div>
					<br />
					<div>
						<button type="button" class="btn btn-success">
							Estimate Daily<br /> Production
						</button>
					</div>
					<br />
					<div>
						<button type="button" class="btn btn-success">Requisition</button>
					</div>
					<br />
					<div>
						<button type="button" class="btn btn-success">Raw Stock In</button>
					</div>
					<br />
					<div>
						<button type="button" class="btn btn-success">Raw Stock Out</button>
					</div>
					<br />
					<div>
						<button type="button" class="btn btn-success">Raw Close</button>
					</div>
					<br />
					<div>
						<button type="button" class="btn btn-success">FG Stock In</button>
					</div>
					<br />
					<div>
						<button type="button" class="btn btn-success">FG Stock Out</button>
					</div>
					<br />
					<div>
						<button type="button" class="btn btn-success">FG Close</button>
					</div>
				</div>
				<div class="col-sm-4">
					<div class="info">Recipe Ingredients</div>

					<table id="recipeingredientlist" class="table table-bordered info" cellspacing="0" width="">
						<thead>
							<tr class="info">
								<th>Name</th>
								<th>Category</th>
								<th>Sub-Category</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${!empty allmenuforrm}">
								<c:forEach items="${allmenuforrm.menucategory}" var="item" varStatus="status">
									<c:forEach items="${item.menucategory }" var="itemSub">
										<c:forEach items="${itemSub.items }" var="itemSubDesc">
											<tr class="success" onclick="javascript:clickonSubmenu(${itemSubDesc.id},&quot;${itemSubDesc.name}&quot;)">
												<td>${itemSubDesc.name}</td>
												<td>${item.menuCategoryName}</td>
												<td>${itemSub.menuCategoryName}</td>
											</tr>
										</c:forEach>
									</c:forEach>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
				<div class="col-sm-6">
					<div id="ingredientdetails"></div>
				</div>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.10/js/jquery.dataTables.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.10/js/dataTables.bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/rm/recipeScript.js"></script>
	<script type="text/javascript">
	var BASE_URL="${pageContext.request.contextPath}";
		$(document).ready(function() {
// 			$('#recipeingredientlist').DataTable();
			 $('#recipeingredientlist').DataTable( {
		        "pagingType": "full"
		    } );
		});
		
	</script>
</body>
</html>