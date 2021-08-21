package com.sharobi.webpos.adm.model;

import java.io.Serializable;

public class DashPaymentSummary implements Serializable {
  private static final long serialVersionUID = 1L;
  private Double paidAmt;
  private Double unpaidAmt;
  private Double refundAmt;
  private Double cancelAmt;
  private Double creditAmt;
  public Double getPaidAmt() {
    return paidAmt;
  }
  public void setPaidAmt(Double paidAmt) {
    this.paidAmt = paidAmt;
  }
  public Double getUnpaidAmt() {
    return unpaidAmt;
  }
  public void setUnpaidAmt(Double unpaidAmt) {
    this.unpaidAmt = unpaidAmt;
  }
  public Double getRefundAmt() {
    return refundAmt;
  }
  public void setRefundAmt(Double refundAmt) {
    this.refundAmt = refundAmt;
  }
  public Double getCancelAmt() {
    return cancelAmt;
  }
  public void setCancelAmt(Double cancelAmt) {
    this.cancelAmt = cancelAmt;
  }
  
  public Double getCreditAmt() {
    return creditAmt;
  }
  public void setCreditAmt(Double creditAmt) {
    this.creditAmt = creditAmt;
  }
  @Override
  public String toString() {
    return "DashPaymentSummary [paidAmt=" + paidAmt + ", unpaidAmt=" + unpaidAmt + ", refundAmt=" + refundAmt
        + ", cancelAmt=" + cancelAmt + ", creditAmt=" + creditAmt + "]";
  }
  
  
  
  
}
