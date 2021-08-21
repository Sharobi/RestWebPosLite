function clickonSubmenu(itemid,itemname){
	alert(itemname);
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + "/recipe/getIngredientDetailsOfMenuItem.htm?itemid=" + itemid , function(response) {
				try {
					reponseObj = JSON.parse(response);

					var generatedHtml = "";
					var tableline="<div>Item Name: "+itemname+"</div><br/><table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;'><thead><th></th><th style='text-align:center;'>Metric Amt.</th><th style='text-align:center;'>Unit</th><th style='text-align:center;'>Ingredient Name</th><th style='text-align:center;'>Cooking Amt</th><th style='text-align:center;'>Unit</th>";
					var headerline="<tbody style='color:#fff; padding:1px;' >";
					var footerline="</tbody></table>";
					var createdrowline="";
					for(var i=0;i<reponseObj.length;i++)
					{
						var orderitem=reponseObj[i];
						var disc1=0.0;
						var begintrline="";
						var firsttdline="";
						var secondtdline="";
						var thirdtdline="";
						var trbgColor="#222222";
						//alert(orderitem.id);
						begintrline="<tr id='rowsplit_"+orderitem.item.id+"' style='background:"+trbgColor+"; padding:2px;'>";
						var chk="<td style='padding:1px;'>"+orderitem.item.id+"</td>";
						firsttdline="<td align='center' style='padding:1px;'>"+orderitem.metricAmount+"</td>";
						secondtdline="<td align='center'  onclick='javascript:selectRowSplit("+orderitem.id+")' style='padding:1px;cursor:pointer;max-width: 250px !important;word-wrap:break-word;'>"+orderitem.metricUnit.unit+"</td>";
						thirdtdline="<td valign='middle' align='center' style='padding:3px;'>"+orderitem.inventoryItem.name+"</td>";
						var fourthtdline="<td  style='padding:1px;text-align: center;'>"+orderitem.cookingAmount+"</td>";
						var fifthtdline="<td style='padding:1px;text-align: center;'>"+orderitem.cookingUnit.unit+"</td>";
//						var sixthtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(orderitem.rate*orderitem.quantityOfItem-disc1).toFixed(2)+"</td>";
//						var seventhhtdline="";
//						var eighthtdline="";
						/*if(vattaxText.length!=0)
							{
							seventhhtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(orderitem.vat).toFixed(2)+"</td>";
							}
						if(servicetaxText.length!=0)
							{
							eighthtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(orderitem.serviceTax).toFixed(2)+"</td>";
							}*/
						
						var endtrline="</tr>";
						createdrowline+=begintrline+chk+firsttdline+secondtdline+thirdtdline+fourthtdline+fifthtdline+endtrline;
						
					}
					generatedHtml=tableline+headerline+createdrowline+footerline;
//					generatedHtml=tableline+headerline+footerline;
//					alert(generatedHtml);
					$('#ingredientdetails').html(generatedHtml);

					
				} catch (e) {
					//alert(e);
				}

			}, null);
		}