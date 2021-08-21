package com.sharobi.webpos.adm.model;

import java.io.Serializable;

public class DashSalesSummaryOrderType implements Serializable {
  private static final long serialVersionUID = 1L;
  private String orderType;
  private Double saleAmt;
  public String getOrderType() {
    return orderType;
  }
  public void setOrderType(String orderType) {
    this.orderType = orderType;
  }
  public Double getSaleAmt() {
    return saleAmt;
  }
  public void setSaleAmt(Double saleAmt) {
    this.saleAmt = saleAmt;
  }
  @Override
  public String toString() {
    return "DashSalesSummaryOrderType [orderType=" + orderType + ", saleAmt=" + saleAmt + "]";
  }


}
