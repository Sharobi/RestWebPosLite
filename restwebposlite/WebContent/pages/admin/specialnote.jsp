<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
							<div class="modal fade" data-backdrop="static" id="specialnoteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">Add Special Note for ${itemnameforspnote}</h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="overflow-y:auto;">
                                        		<div class="panel panel-default" style="background:#404040;">
													<div class="panel-body" style="max-height:300px;">
                										<div class="table-responsive">
                											<input type="hidden" id="itemidforspnote" value="${itemidforspnote}">
                											<c:if test="${empty allsplnoteTree.menucategory }">No item found!</c:if>
                											<c:if test="${! empty allsplnoteTree }">
                											<table class="table table-striped table-bordered" style="color:#FFF;  border:1px solid #222222;">
                												<c:forEach items="${allsplnoteTree.menucategory}" var="menucategory">
                                    								<c:forEach items="${menucategory.menucategory}" var="menusubcategory">
                                    									<c:forEach items="${menusubcategory.items}" var="menuitems">
                                    										<tr style="background:#404040; color:#FFF;">
                                    											
                                    											<td>${menuitems.name}</td>
                                    											<td>
                                    												<c:if test="${fn:containsIgnoreCase(menuitems.specialNote, 'Y') }">
                                    												<input type="checkbox" name="spnote" checked="checked" value="${menuitems.id}" />
                                    												</c:if>
                                    												<c:if test="${fn:containsIgnoreCase(menuitems.specialNote, 'N') }">
                                    												<input type="checkbox" name="spnote" value="${menuitems.id}" />
                                    												</c:if>
                                    											</td>
                                    										</tr>
                                    									</c:forEach>
                                    								</c:forEach>
                                    							</c:forEach>
                											</table>
                											</c:if>
                										</div>
                									</div>
                								</div>
                                        	</div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal">CANCEL</button>
                                            <c:if test="${! empty allsplnoteTree.menucategory }">
                                            <button type="button" onclick="javascript:addspecialNote();" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success">SAVE</button>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
 