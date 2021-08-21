package com.sharobi.webpos.adm.model;

import java.io.Serializable;

public class DashSalesSummaryPaymentType implements Serializable {
  private static final long serialVersionUID = 1L;
  private String paymentType;
  private Double amt;
  public String getPaymentType() {
    return paymentType;
  }
  public void setPaymentType(String paymentType) {
    this.paymentType = paymentType;
  }
  public Double getAmt() {
    return amt;
  }
  public void setAmt(Double amt) {
    this.amt = amt;
  }
  @Override
  public String toString() {
    return "DashSalesSummaryPaymentType [paymentType=" + paymentType + ", amt=" + amt + "]";
  }
  


}
