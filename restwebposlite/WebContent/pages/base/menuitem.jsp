<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:if test="${empty menuItems}">no items</c:if>
<c:if test="${!empty menuItems}">
	<c:forEach items="${menuItems}" var="item" varStatus="status">
		<c:if test="${fn:containsIgnoreCase(item.promotionFlag, 'Y') }">
			<c:set var="discount" scope="page" value="${item.promotionValue}" />
		</c:if>
		<c:if test="${fn:containsIgnoreCase(item.promotionFlag, 'N') }">
			<c:set var="discount" scope="page" value="0.0" />
		</c:if>
		<c:if test="${fn:containsIgnoreCase(item.production, 'Y') }">
			<c:if test="${css=='nosidemenu'}">
				<div class="table-holder" style="width: 14%;">
			</c:if>
			<c:if test="${css!='nosidemenu'}">
				<div class="table-holder" style="width: 20%;">
			</c:if>
			<c:if test="${sessionScope.loggedinStore.itemWithImage=='Y'}">
			<div class="postable " style="height: 125px; background-color: #fff;" onclick="javascript:additemtoOrder(${item.id }, &quot;${item.name }&quot;,${item.price }, ${discount },${item.vat },${item.serviceTax },'${item.promotionFlag}',${item.promotionValue })">
				<div>
					<c:if test="${fn:containsIgnoreCase(item.promotionFlag, 'Y') }">
						<%--                                			<div style="font-size: 0.5em">${item.promotionValue }%&nbsp;off</div> --%>
						<span style="font-size: 0.5em">${item.promotionValue }%&nbsp;off</span>
					</c:if>
					<c:if test="${fn:containsIgnoreCase(item.promotionFlag, 'Y') }">
						<span style="font-size: 0.6em; text-decoration: line-through;">${item.price }</span>${item.price-(item.price*item.promotionValue)/100 }
                            		</c:if>
					<c:if test="${fn:containsIgnoreCase(item.promotionFlag, 'N') }">
						<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${item.price }" />
					</c:if>
				</div>
				<div style="height: 70px; padding: 1px;">
					<c:choose>
						<c:when test="${item.imagepath=='failure'}">
							<img id="Mitemimg" src="${pageContext.request.contextPath}/assets/images/menu/a/noimage.png" class="img-thumbnail" style="height: 100%; padding: 2px; width: 100%;">
						</c:when>
						<c:otherwise>
							<img id="Mitemimg" src="${item.imagepath}" class="img-thumbnail" style="height: 100%; padding: 2px; width: 100%;">
						</c:otherwise>
					</c:choose>

				</div>
				<div style=" font-size: .6em; margin-right: 5px; margin-top: 0px;height: 37px;overflow: hidden;">
					<div style="font-size: 12px; font-weight: bold;line-height: 13px;">${item.name}</div>
					<%-- <c:if test="${fn:containsIgnoreCase(item.promotionFlag, 'Y') }">
                            			<span style="font-size: 0.6em; text-decoration: line-through;">${item.price }</span>${item.price-(item.price*item.promotionValue)/100 }
                            		</c:if>
                            		<c:if test="${fn:containsIgnoreCase(item.promotionFlag, 'N') }">
										<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${item.price }"/>
									</c:if> --%>

				</div>
				<br style="clear: both;">
			</div>
			</c:if>
			<c:if test="${sessionScope.loggedinStore.itemWithImage!='Y'}">
			     <div class="postable menucathead" style="height: 84px; background-color: #bebebe;" onclick="javascript:additemtoOrder(${item.id }, &quot;${item.name }&quot;,${item.price }, ${discount },${item.vat },${item.serviceTax },'${item.promotionFlag}',${item.promotionValue })">
		      					<div style="height: 70px;padding: 1px;">
                               		<div style="font-size:13px; font-weight:bold;line-height: 13px;">${item.name}</div>
                               		<c:if test="${fn:containsIgnoreCase(item.promotionFlag, 'Y') }">
                               			<div style="font-size: 0.8em">${item.promotionValue }%&nbsp;off</div>
                               		</c:if>
                               	</div>
                            	<div style="float: right;font-size: 1em;margin-right: 5px;margin-top: -5px;position: relative;">
                            		<c:if test="${fn:containsIgnoreCase(item.promotionFlag, 'Y') }">
                            			<span style="font-size: 0.8em; text-decoration: line-through; ">${item.price }</span>${item.price-(item.price*item.promotionValue)/100 }
                            		</c:if>
                            		<c:if test="${fn:containsIgnoreCase(item.promotionFlag, 'N') }">
										<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${item.price }"/>
									</c:if>
                             		
                             	</div>
                             	<br style="clear:both;">
		      				</div>
			</c:if>
			
			</div>
		</c:if>
		<c:if test="${fn:containsIgnoreCase(item.production, 'N') }">
			<c:if test="${css=='nosidemenu'}">
				<div class="table-holder" style="width: 14%;">
			</c:if>
			<c:if test="${css!='nosidemenu'}">
				<div class="table-holder" style="width: 20%;">
			</c:if>
			<c:if test="${sessionScope.loggedinStore.itemWithImage=='Y'}">
			<div class="postable " style="height: 84px; opacity: 0.6; cursor: auto; background-color: #fff;">
				<div>
					<c:if test="${fn:containsIgnoreCase(item.promotionFlag, 'Y') }">
						<%--                                			<div style="font-size: 0.5em">${item.promotionValue }%&nbsp;off</div> --%>
						<span style="font-size: 0.5em">${item.promotionValue }%&nbsp;off</span>
					</c:if>
					<c:if test="${fn:containsIgnoreCase(item.promotionFlag, 'Y') }">
						<span style="font-size: 0.6em; text-decoration: line-through;">${item.price }</span>${item.price-(item.price*item.promotionValue)/100 }
                            		</c:if>
					<c:if test="${fn:containsIgnoreCase(item.promotionFlag, 'N') }">
						<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${item.price }" />
					</c:if>
				</div>
				<div style="height: 70px; padding: 1px;">
					<c:choose>
						<c:when test="${item.imagepath=='failure'}">
							<img id="Mitemimg" src="${pageContext.request.contextPath}/assets/images/menu/a/noimage.png" class="img-thumbnail" style="height: 100%; padding: 2px; width: 100%;">
						</c:when>
						<c:otherwise>
							<img id="Mitemimg" src="${item.imagepath}" class="img-thumbnail" style="height: 100%; padding: 2px; width: 100%;">
						</c:otherwise>
					</c:choose>
				</div>
				<div style="float: right; font-size: 1em; margin-right: 5px; margin-top: 0px; position: relative;height: 37px;overflow: hidden;">
					<div style="font-size: 12px; font-weight: bold;line-height: 13px;">${item.name}</div>
				</div>
				<br style="clear: both;">
			</div>
			</c:if>
			<c:if test="${sessionScope.loggedinStore.itemWithImage!='Y'}">
			<div class="postable menucathead" style="height: 84px; background-color: #bebebe;" onclick="javascript:additemtoOrder(${item.id }, &quot;${item.name }&quot;,${item.price }, ${discount },${item.vat },${item.serviceTax },'${item.promotionFlag}',${item.promotionValue })">
		      					<div style="height: 70px;padding: 1px;">
                               		<div style="font-size:13px; font-weight:bold;line-height: 13px;">${item.name}</div>
                               		<c:if test="${fn:containsIgnoreCase(item.promotionFlag, 'Y') }">
                               			<div style="font-size: 0.8em">${item.promotionValue }%&nbsp;off</div>
                               		</c:if>
                               	</div>
                            	<div style="float: right;font-size: 1em;margin-right: 5px;margin-top: -5px;position: relative;">
                            		<c:if test="${fn:containsIgnoreCase(item.promotionFlag, 'Y') }">
                            			<span style="font-size: 0.8em; text-decoration: line-through; ">${item.price }</span>${item.price-(item.price*item.promotionValue)/100 }
                            		</c:if>
                            		<c:if test="${fn:containsIgnoreCase(item.promotionFlag, 'N') }">
										<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${item.price }"/>
									</c:if>
                             		
                             	</div>
                             	<br style="clear:both;">
		      				</div>
			</c:if>
			
			</div>
		</c:if>

	</c:forEach>
</c:if>
