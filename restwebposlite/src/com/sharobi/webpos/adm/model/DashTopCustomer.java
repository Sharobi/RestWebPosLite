package com.sharobi.webpos.adm.model;

import java.io.Serializable;

public class DashTopCustomer implements Serializable {
  private static final long serialVersionUID = 1L;
  private String custName;
  private String custPhone;
  private String custEmail;
  private Double amtSpent;
  public String getCustName() {
    return custName;
  }
  public void setCustName(String custName) {
    this.custName = custName;
  }
  public String getCustPhone() {
    return custPhone;
  }
  public void setCustPhone(String custPhone) {
    this.custPhone = custPhone;
  }
  public String getCustEmail() {
    return custEmail;
  }
  public void setCustEmail(String custEmail) {
    this.custEmail = custEmail;
  }
  public Double getAmtSpent() {
    return amtSpent;
  }
  public void setAmtSpent(Double amtSpent) {
    this.amtSpent = amtSpent;
  }
  @Override
  public String toString() {
    return "DashTopCustomer [custName=" + custName + ", custPhone=" + custPhone + ", custEmail=" + custEmail
        + ", amtSpent=" + amtSpent + "]";
  }
  
  
  

}
