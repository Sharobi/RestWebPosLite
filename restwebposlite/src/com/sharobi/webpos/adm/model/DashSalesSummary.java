package com.sharobi.webpos.adm.model;

import java.io.Serializable;
public class DashSalesSummary implements Serializable {
  private static final long serialVersionUID = 1L;
  private Double totSale;
  private Integer noofOrder;
  private Integer noofCust;
  private Double totPurchase;
  private Double totPaidAmt;
  private Double noofPaidOrder;
  private Double totCreditAmt;
  private Double noofCreditOrder;
  
  public Double getTotSale() {
    return totSale;
  }
  public void setTotSale(Double totSale) {
    this.totSale = totSale;
  }
  public Integer getNoofOrder() {
    return noofOrder;
  }
  public void setNoofOrder(Integer noofOrder) {
    this.noofOrder = noofOrder;
  }
  public Integer getNoofCust() {
    return noofCust;
  }
  public void setNoofCust(Integer noofCust) {
    this.noofCust = noofCust;
  }
  public Double getTotPurchase() {
    return totPurchase;
  }
  public void setTotPurchase(Double totPurchase) {
    this.totPurchase = totPurchase;
  }
  
  public Double getTotPaidAmt() {
    return totPaidAmt;
  }
  public void setTotPaidAmt(Double totPaidAmt) {
    this.totPaidAmt = totPaidAmt;
  }
  public Double getNoofPaidOrder() {
    return noofPaidOrder;
  }
  public void setNoofPaidOrder(Double noofPaidOrder) {
    this.noofPaidOrder = noofPaidOrder;
  }
  public Double getTotCreditAmt() {
    return totCreditAmt;
  }
  public void setTotCreditAmt(Double totCreditAmt) {
    this.totCreditAmt = totCreditAmt;
  }
  public Double getNoofCreditOrder() {
    return noofCreditOrder;
  }
  public void setNoofCreditOrder(Double noofCreditOrder) {
    this.noofCreditOrder = noofCreditOrder;
  }
  @Override
  public String toString() {
    return "DashSalesSummary [totSale=" + totSale + ", noofOrder=" + noofOrder + ", noofCust=" + noofCust
        + ", totPurchase=" + totPurchase + ", totPaidAmt=" + totPaidAmt + ", noofPaidOrder=" + noofPaidOrder
        + ", totCreditAmt=" + totCreditAmt + ", noofCreditOrder=" + noofCreditOrder + "]";
  }
  
  
  
  
}
