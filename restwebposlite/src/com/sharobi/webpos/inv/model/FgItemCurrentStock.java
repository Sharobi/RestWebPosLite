package com.sharobi.webpos.inv.model;

public class FgItemCurrentStock {
  private Integer itemId;
  private String name;
  private String unit;
  private Integer curStock;
  private double rate;
  public Integer getItemId() {
    return itemId;
  }
  public void setItemId(Integer itemId) {
    this.itemId = itemId;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public String getUnit() {
    return unit;
  }
  public void setUnit(String unit) {
    this.unit = unit;
  }
  public Integer getCurStock() {
    return curStock;
  }
  public void setCurStock(Integer curStock) {
    this.curStock = curStock;
  }
 
  
  public double getRate() {
    return rate;
  }
  public void setRate(double rate) {
    this.rate = rate;
  }
  @Override
  public String toString() {
    return "FgItemCurrentStock [itemId=" + itemId + ", name=" + name + ", unit=" + unit + ", curStock=" + curStock
        + ", rate=" + rate + "]";
  }
  
  

}
