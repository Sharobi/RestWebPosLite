package com.sharobi.webpos.inv.model;

import java.util.List;

public class PurchaseOrderForm {
	private List<PurchaseOrderFB> purchaseOrderFbList;

	public List<PurchaseOrderFB> getPurchaseOrderFbList() {
		return purchaseOrderFbList;
	}

	public void setPurchaseOrderFbList(List<PurchaseOrderFB> purchaseOrderFbList) {
		this.purchaseOrderFbList = purchaseOrderFbList;
	}
}
