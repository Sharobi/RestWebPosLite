package com.sharobi.webpos.rm.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class EstimateDailyProd implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private EstimateType estimateType;
	private int storeId;
	private String date;
	private double total;
	private String approved;
	private String approvedBy;
	private String requisitionPoStatus;
	private String requisitionPoStatusBy;
	private String fgStockInStatus;
	private String fgStockInStatusBy;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private List<EstimateDailyProdItem> estimateDailyProdItems;
	private String dateText;
	private Date requisitionPoDate;
	private Date fgStockInDate;
	private int poId;
	private int fgStockInId;
	private int rawStockOutId;
	private int estimatedQuantity;
	private double totalEstimatedQty;
	private double totalStockInQty;
	private String rawStockOutStatus;
	private String rawStockOutStatusBy;
	

	private Date rawStockOutDate;


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	
	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

	public String getApproved() {
		return approved;
	}

	public void setApproved(String approved) {
		this.approved = approved;
	}

	public int getStoreId() {
		return storeId;
	}

	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}

	public String getApprovedBy() {
		return approvedBy;
	}

	public void setApprovedBy(String approvedBy) {
		this.approvedBy = approvedBy;
	}

	public String getRequisitionPoStatus() {
		return requisitionPoStatus;
	}

	public void setRequisitionPoStatus(String requisitionPoStatus) {
		this.requisitionPoStatus = requisitionPoStatus;
	}

	public String getRequisitionPoStatusBy() {
		return requisitionPoStatusBy;
	}

	public void setRequisitionPoStatusBy(String requisitionPoStatusBy) {
		this.requisitionPoStatusBy = requisitionPoStatusBy;
	}

	public String getFgStockInStatus() {
		return fgStockInStatus;
	}

	public void setFgStockInStatus(String fgStockInStatus) {
		this.fgStockInStatus = fgStockInStatus;
	}

	public String getFgStockInStatusBy() {
		return fgStockInStatusBy;
	}

	public void setFgStockInStatusBy(String fgStockInStatusBy) {
		this.fgStockInStatusBy = fgStockInStatusBy;
	}

	public String getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public String getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}

	public String getUpdatedBy() {
		return updatedBy;
	}

	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}

	public String getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(String updatedDate) {
		this.updatedDate = updatedDate;
	}

	public EstimateType getEstimateType() {
		return estimateType;
	}

	public void setEstimateType(EstimateType estimateType) {
		this.estimateType = estimateType;
	}

	public List<EstimateDailyProdItem> getEstimateDailyProdItems() {
		return estimateDailyProdItems;
	}

	public void setEstimateDailyProdItems(
			List<EstimateDailyProdItem> estimateDailyProdItems) {
		this.estimateDailyProdItems = estimateDailyProdItems;
	}

	public String getDateText() {
		return dateText;
	}

	public void setDateText(String dateText) {
		this.dateText = dateText;
	}

	public Date getRequisitionPoDate() {
		return requisitionPoDate;
	}

	public void setRequisitionPoDate(Date requisitionPoDate) {
		this.requisitionPoDate = requisitionPoDate;
	}

	public Date getFgStockInDate() {
		return fgStockInDate;
	}

	public void setFgStockInDate(Date fgStockInDate) {
		this.fgStockInDate = fgStockInDate;
	}

	public int getPoId() {
		return poId;
	}

	public void setPoId(int poId) {
		this.poId = poId;
	}

	public int getFgStockInId() {
		return fgStockInId;
	}

	public void setFgStockInId(int fgStockInId) {
		this.fgStockInId = fgStockInId;
	}

	public int getEstimatedQuantity() {
		return estimatedQuantity;
	}

	public void setEstimatedQuantity(int estimatedQuantity) {
		this.estimatedQuantity = estimatedQuantity;
	}

	public double getTotalEstimatedQty() {
		return totalEstimatedQty;
	}

	public void setTotalEstimatedQty(double totalEstimatedQty) {
		this.totalEstimatedQty = totalEstimatedQty;
	}

	public double getTotalStockInQty() {
		return totalStockInQty;
	}

	public void setTotalStockInQty(double totalStockInQty) {
		this.totalStockInQty = totalStockInQty;
	}

	public String getRawStockOutStatus() {
		return rawStockOutStatus;
	}

	public void setRawStockOutStatus(String rawStockOutStatus) {
		this.rawStockOutStatus = rawStockOutStatus;
	}

	public String getRawStockOutStatusBy() {
		return rawStockOutStatusBy;
	}

	public void setRawStockOutStatusBy(String rawStockOutStatusBy) {
		this.rawStockOutStatusBy = rawStockOutStatusBy;
	}

	public Date getRawStockOutDate() {
		return rawStockOutDate;
	}

	public void setRawStockOutDate(Date rawStockOutDate) {
		this.rawStockOutDate = rawStockOutDate;
	}

	public int getRawStockOutId() {
		return rawStockOutId;
	}

	public void setRawStockOutId(int rawStockOutId) {
		this.rawStockOutId = rawStockOutId;
	}

	@Override
	public String toString() {
		return "EstimateDailyProd [id=" + id + ", estimateType=" + estimateType + ", storeId=" + storeId + ", date="
				+ date + ", total=" + total + ", approved=" + approved + ", approvedBy=" + approvedBy
				+ ", requisitionPoStatus=" + requisitionPoStatus + ", requisitionPoStatusBy=" + requisitionPoStatusBy
				+ ", fgStockInStatus=" + fgStockInStatus + ", fgStockInStatusBy=" + fgStockInStatusBy + ", deleteFlag="
				+ deleteFlag + ", createdBy=" + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy
				+ ", updatedDate=" + updatedDate + ", estimateDailyProdItems=" + estimateDailyProdItems + ", dateText="
				+ dateText + ", requisitionPoDate=" + requisitionPoDate + ", fgStockInDate=" + fgStockInDate + ", poId="
				+ poId + ", fgStockInId=" + fgStockInId + ", rawStockOutId=" + rawStockOutId + ", estimatedQuantity="
				+ estimatedQuantity + ", totalEstimatedQty=" + totalEstimatedQty + ", totalStockInQty="
				+ totalStockInQty + ", rawStockOutStatus=" + rawStockOutStatus + ", rawStockOutStatusBy="
				+ rawStockOutStatusBy + ", rawStockOutDate=" + rawStockOutDate + "]";
	}
	
	
}
