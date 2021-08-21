package com.sharobi.webpos.adm.model;

public class CommonResultSetMapper {
  private String startDate;
  private String endDate;
  private int storeId;
  public String getStartDate() {
    return startDate;
  }
  public void setStartDate(String startDate) {
    this.startDate = startDate;
  }
  public String getEndDate() {
    return endDate;
  }
  public void setEndDate(String endDate) {
    this.endDate = endDate;
  }
  public int getStoreId() {
    return storeId;
  }
  public void setStoreId(int storeId) {
    this.storeId = storeId;
  }
  @Override
  public String toString() {
    return "CommonResultSetMapper [startDate=" + startDate + ", endDate=" + endDate + ", storeId=" + storeId + "]";
  }
  

}
