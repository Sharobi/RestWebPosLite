package com.sharobi.webpos.adm.model;

import java.io.Serializable;

public class DashTopItem implements Serializable {
  private static final long serialVersionUID = 1L;
  private String itemName;
  private Double qty;
  public String getItemName() {
    return itemName;
  }
  public void setItemName(String itemName) {
    this.itemName = itemName;
  }
  public Double getQty() {
    return qty;
  }
  public void setQty(Double qty) {
    this.qty = qty;
  }
  @Override
  public String toString() {
    return "DashTopItem [itemName=" + itemName + ", qty=" + qty + "]";
  }
  

}
