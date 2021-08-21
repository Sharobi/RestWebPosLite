/**
 * 
 */
function CustomBrowserXMLObject() {
	var ieVersions = new Array([ "Microsoft.XmlDom", "Microsoft.XMLHTTP" ], [ "MSXML.DOMDocument", "Microsoft.XMLHTTP" ], [ "Msxml2.DOMDocument", "MSXML2.XMLHTTP" ]);
	var xmlHttp = null;
	var xmlDoc = null;
	var client = "";

	function initialize() {
		if (window.ActiveXObject) {// IE Older 5.0+ - 7.0
			var i, len = ieVersions.length;
			for (i = 0; i < len; i++) {
				try {
					xmlDoc = new ActiveXObject(ieVersions[i][0]);
					xmlHttp = new ActiveXObject(ieVersions[i][1]);
					client = "ie";
					break;
				} catch (e1) {
				}
			}
		} else if (window.XMLHttpRequest) {// Firefox, Opera 8.0+, Safari, Chrome
			xmlHttp = new XMLHttpRequest();
			xmlDoc = document.implementation.createDocument("", "", null);
			client = navigator.userAgent.toLowerCase().indexOf('chrome') > -1 ? "chrome" : "mozilla";
		} else {
			client = "Unknown Client";
		}
	}

	this.callAjax = function(	url,
								callbackSuccess,
								callbackFail) {
		if (xmlHttp == null) {
			initialize();
		}
		xmlHttp.open("GET", url, true);
		xmlHttp.setRequestHeader("Content-Type", "text/plain;charset=UTF-8");
		xmlHttp.send(null);
		xmlHttp.onreadystatechange = function() {
			if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
				callbackSuccess(xmlHttp.responseText);
			} else if (xmlHttp.readyState != 4) {
				if (callbackFail != null) {
					callbackFail(xmlHttp.readyState);
				}
			}
		};
	};
	
	this.callAjaxPost = function(url,jdata,callbackSuccess,callbackFail) {
		if (xmlHttp == null) {
			initialize();
			}
		xmlHttp.open("POST", url, true);
		xmlHttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
		//xmlHttp.setRequestHeader("token", "commonJs.token");
		xmlHttp.send(JSON.stringify(jdata));
		xmlHttp.onreadystatechange = function() {
			if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
				callbackSuccess(xmlHttp.responseText);
			} else if (xmlHttp.readyState != 4) {
				if (callbackFail != null) {
					callbackFail(xmlHttp.readyState);
				}
			}
		};
	};
	this.getXMLHttpObject = function() {
		if (xmlHttp == null) {
			initialize();
		}
		return xmlHttp;
	};

	this.getXMLDocObject = function(url) {
		if (xmlDoc == null) {
			initialize();
		}
		return xmlDoc;
	};

	this.getClient = function() {
		if (xmlDoc == null) {
			initialize();
		}
		return client;
	};
}