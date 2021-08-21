function startCooking(orderid,orderitemid,starttime)
{
	//alert('orderid:'+orderid+'orderitemid:'+orderitemid+'starttime:'+starttime);
	//alert(starttime.substring(0,4));
	var starTime=starttime.substring(0,5);
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/kitchen/startcooking/" + orderid +"/"+ orderitemid+"/" + starTime +".htm", function(response) {
		//alert(response);
		location.href=BASE_URL+'/kitchen/loadkitchenitem.htm';
	}, null);
}
function stopCooking(orderid,orderitemid,endtime,starttime)
{
	//alert('orderid:'+orderid+'orderitemid:'+orderitemid+'starttime:'+endtime);
	//alert(endtime.substring(0,4));
	if(starttime.length==0)
		{
		openalertnoStartModal();
		}
	else{
	var endTime=endtime.substring(0,5);
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/kitchen/stopcooking/" + orderid +"/"+ orderitemid+"/" + endTime +".htm", function(response) {
		//alert(response);
		location.href=BASE_URL+'/kitchen/loadkitchenitem.htm';
	}, null);
	}
}
function kitchenOut(orderid,orderitemid,starttime,endtime)
{
	//alert('orderid:'+orderid+'orderitemid:'+orderitemid+'starttime:'+starttime.length+'endtime:'+endtime.length);
	if(starttime.length==0)
		{
		openalertnoStartModal();
		}
	else if(endtime.length==0)
		{
		openalertnoEndModal();
		}
	else{
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/kitchen/kitchenout/" + orderid +"/"+ orderitemid +".htm", function(response) {
		//alert(response);
		location.href=BASE_URL+'/kitchen/loadkitchenitem.htm';
	}, null);
	}
}