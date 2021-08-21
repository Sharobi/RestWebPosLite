/**
 * 
 */
package com.sharobi.webpos.base.model;

import java.io.Serializable;

/**
 * @author habib
 * 
 */
public class Store implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String ip;
	private Double latitude;
	private Double longitude;
	private String storeName;
	private String chainName;
	private String nameSearch;
	private String detailsSearch;
	private String address;
	private String phoneNo;
	private String mobileNo;
	private String emailId;
	private String status;
	private String city;
	private String state;
	private String country;
	private String category;
	private String url;
	private String operatingSystem;
	private String ram;
	private String currency;
	private String activeFlag;
	private int restaurantId;
	private Double quality;
	private String openTime;
	private String closeTime;
	private int deliveryTime;
	private String workingHours;
	private Double minOrderAmt;
	private String freeDelivery;
	private String license;
	private String promotionDesc;
	private double promotionValue;
	private String promotionFlag;
	private String openTimeWeekend;
	private String closeTimeWeekend;
	private String openTimeHoliday;
	private String closeTimeHoliday;
	private String tableFlag;
	private String parcelFlag;
	private String homeDeliveryFlag;
	private String dataSource;
	private String mpayment;
	private String kitchenPrint = "N";
	private String kitchenPrintPreview;
	private String cashPayment;
	private String creditPayment;
	private String stockStatus;
	private int stockPeriod;
	private String fromDes;
	private String toDes;
	private int kotResTitleFont;
	private int kotTextFont;
	private int kotDateTimeFont;
	private int kotTableFont;
	private int kotItemTitleFont;
	private int kotItemFont;
	private int kotNoOfPersonFont;
	private String posmanualPrint;
	private String billPrint;
	private String vatRegNo;
	private String serviceTaxNo;
	private String poPrintServer;
	private String parcelServiceTax;
	private String parcelVat;
	private String roundOffTotalAmtStatus;
	private String kitchenPrintBt;
	private String billPrintBt;
	private int kotCount;
	private String discountPercentage;
	private String vatTaxText;
	private String serviceTaxText;
	private double vatAmt;
	private double serviceTaxAmt;
	private String parcelAddress;
	private String multiOrderTable;
	private String creditSale;
	private String customerDisplay;
	private String parcelText;
	private String kotPrintType;
	private String doubleRoundOff;
	private String tableScreen;
	private String softKey;
	private String menuCollapsable;
	private String billSplit;
	private String isPax;
	private String printPaidBill;
	private String cashDrawerCode;
	private String itemWithImage;
	private String mobBillPrint;
	private String printBillPaperSize;
	private String gstText;
    private String gstRegNo;
    private String serviceChargeText;        
    private Double serviceChargeRate;
    private String serviceChargeFlag;
    private String deliveryBoyFlag;
    private int billCount; // new added 22th march 2018
    private String simpleIm; // new added 28th May 2018  flag for normal  Inventory    
    private String ordSucc; // new added 28th May 2018 flag for Order success pop-up in order-taking page
	
    private String isBarcode; // new added 29th Oct 2018 for Code base item search in order taking page
    private String is_account;
    private String isRefund;
    private String advOrder;//flag for Advance order feature in admin
    private String isProvideReason; 
    private String displayCurrentStockMenu;
    private String negativeStockBilling;
    
	public String getGstText() {
		return gstText;
	}

	public void setGstText(String gstText) {
		this.gstText = gstText;
	}

	public String getGstRegNo() {
		return gstRegNo;
	}

	public void setGstRegNo(String gstRegNo) {
		this.gstRegNo = gstRegNo;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public Double getLatitude() {
		return latitude;
	}

	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}

	public Double getLongitude() {
		return longitude;
	}

	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getChainName() {
		return chainName;
	}

	public void setChainName(String chainName) {
		this.chainName = chainName;
	}

	public String getNameSearch() {
		return nameSearch;
	}

	public void setNameSearch(String nameSearch) {
		this.nameSearch = nameSearch;
	}

	public String getDetailsSearch() {
		return detailsSearch;
	}

	public void setDetailsSearch(String detailsSearch) {
		this.detailsSearch = detailsSearch;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getOperatingSystem() {
		return operatingSystem;
	}

	public void setOperatingSystem(String operatingSystem) {
		this.operatingSystem = operatingSystem;
	}

	public String getRam() {
		return ram;
	}

	public void setRam(String ram) {
		this.ram = ram;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public String getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
	}

	public int getRestaurantId() {
		return restaurantId;
	}

	public void setRestaurantId(int restaurantId) {
		this.restaurantId = restaurantId;
	}

	public Double getQuality() {
		return quality;
	}

	public void setQuality(Double quality) {
		this.quality = quality;
	}

	public String getOpenTime() {
		return openTime;
	}

	public void setOpenTime(String openTime) {
		this.openTime = openTime;
	}

	public String getCloseTime() {
		return closeTime;
	}

	public void setCloseTime(String closeTime) {
		this.closeTime = closeTime;
	}

	public int getDeliveryTime() {
		return deliveryTime;
	}

	public void setDeliveryTime(int deliveryTime) {
		this.deliveryTime = deliveryTime;
	}

	public String getWorkingHours() {
		return workingHours;
	}

	public void setWorkingHours(String workingHours) {
		this.workingHours = workingHours;
	}

	public Double getMinOrderAmt() {
		return minOrderAmt;
	}

	public void setMinOrderAmt(Double minOrderAmt) {
		this.minOrderAmt = minOrderAmt;
	}

	public String getFreeDelivery() {
		return freeDelivery;
	}

	public void setFreeDelivery(String freeDelivery) {
		this.freeDelivery = freeDelivery;
	}

	public String getLicense() {
		return license;
	}

	public void setLicense(String license) {
		this.license = license;
	}

	public String getPromotionDesc() {
		return promotionDesc;
	}

	public void setPromotionDesc(String promotionDesc) {
		this.promotionDesc = promotionDesc;
	}

	public double getPromotionValue() {
		return promotionValue;
	}

	public void setPromotionValue(double promotionValue) {
		this.promotionValue = promotionValue;
	}

	public String getPromotionFlag() {
		return promotionFlag;
	}

	public void setPromotionFlag(String promotionFlag) {
		this.promotionFlag = promotionFlag;
	}

	public String getOpenTimeWeekend() {
		return openTimeWeekend;
	}

	public void setOpenTimeWeekend(String openTimeWeekend) {
		this.openTimeWeekend = openTimeWeekend;
	}

	public String getCloseTimeWeekend() {
		return closeTimeWeekend;
	}

	public void setCloseTimeWeekend(String closeTimeWeekend) {
		this.closeTimeWeekend = closeTimeWeekend;
	}

	public String getOpenTimeHoliday() {
		return openTimeHoliday;
	}

	public void setOpenTimeHoliday(String openTimeHoliday) {
		this.openTimeHoliday = openTimeHoliday;
	}

	public String getCloseTimeHoliday() {
		return closeTimeHoliday;
	}

	public void setCloseTimeHoliday(String closeTimeHoliday) {
		this.closeTimeHoliday = closeTimeHoliday;
	}

	public String getTableFlag() {
		return tableFlag;
	}

	public void setTableFlag(String tableFlag) {
		this.tableFlag = tableFlag;
	}

	public String getParcelFlag() {
		return parcelFlag;
	}

	public void setParcelFlag(String parcelFlag) {
		this.parcelFlag = parcelFlag;
	}

	public String getHomeDeliveryFlag() {
		return homeDeliveryFlag;
	}

	public void setHomeDeliveryFlag(String homeDeliveryFlag) {
		this.homeDeliveryFlag = homeDeliveryFlag;
	}

	public String getDataSource() {
		return dataSource;
	}

	public void setDataSource(String dataSource) {
		this.dataSource = dataSource;
	}

	public String getMpayment() {
		return mpayment;
	}

	public void setMpayment(String mpayment) {
		this.mpayment = mpayment;
	}

	public String getKitchenPrint() {
		return kitchenPrint;
	}

	public void setKitchenPrint(String kitchenPrint) {
		this.kitchenPrint = kitchenPrint;
	}

	public String getKitchenPrintPreview() {
		return kitchenPrintPreview;
	}

	public void setKitchenPrintPreview(String kitchenPrintPreview) {
		this.kitchenPrintPreview = kitchenPrintPreview;
	}

	public String getCashPayment() {
		return cashPayment;
	}

	public void setCashPayment(String cashPayment) {
		this.cashPayment = cashPayment;
	}

	public String getCreditPayment() {
		return creditPayment;
	}

	public void setCreditPayment(String creditPayment) {
		this.creditPayment = creditPayment;
	}

	public String getStockStatus() {
		return stockStatus;
	}

	public void setStockStatus(String stockStatus) {
		this.stockStatus = stockStatus;
	}

	public int getStockPeriod() {
		return stockPeriod;
	}

	public void setStockPeriod(int stockPeriod) {
		this.stockPeriod = stockPeriod;
	}

	public String getFromDes() {
		return fromDes;
	}

	public void setFromDes(String fromDes) {
		this.fromDes = fromDes;
	}

	public String getToDes() {
		return toDes;
	}

	public void setToDes(String toDes) {
		this.toDes = toDes;
	}

	public int getKotResTitleFont() {
		return kotResTitleFont;
	}

	public void setKotResTitleFont(int kotResTitleFont) {
		this.kotResTitleFont = kotResTitleFont;
	}

	public int getKotTextFont() {
		return kotTextFont;
	}

	public void setKotTextFont(int kotTextFont) {
		this.kotTextFont = kotTextFont;
	}

	public int getKotDateTimeFont() {
		return kotDateTimeFont;
	}

	public void setKotDateTimeFont(int kotDateTimeFont) {
		this.kotDateTimeFont = kotDateTimeFont;
	}

	public int getKotTableFont() {
		return kotTableFont;
	}

	public void setKotTableFont(int kotTableFont) {
		this.kotTableFont = kotTableFont;
	}

	public int getKotItemTitleFont() {
		return kotItemTitleFont;
	}

	public void setKotItemTitleFont(int kotItemTitleFont) {
		this.kotItemTitleFont = kotItemTitleFont;
	}

	public int getKotItemFont() {
		return kotItemFont;
	}

	public void setKotItemFont(int kotItemFont) {
		this.kotItemFont = kotItemFont;
	}

	public int getKotNoOfPersonFont() {
		return kotNoOfPersonFont;
	}

	public void setKotNoOfPersonFont(int kotNoOfPersonFont) {
		this.kotNoOfPersonFont = kotNoOfPersonFont;
	}

	public String getPosmanualPrint() {
		return posmanualPrint;
	}

	public void setPosmanualPrint(String posmanualPrint) {
		this.posmanualPrint = posmanualPrint;
	}

	public String getBillPrint() {
		return billPrint;
	}

	public void setBillPrint(String billPrint) {
		this.billPrint = billPrint;
	}

	public String getVatRegNo() {
		return vatRegNo;
	}

	public void setVatRegNo(String vatRegNo) {
		this.vatRegNo = vatRegNo;
	}

	public String getServiceTaxNo() {
		return serviceTaxNo;
	}

	public void setServiceTaxNo(String serviceTaxNo) {
		this.serviceTaxNo = serviceTaxNo;
	}

	public String getPoPrintServer() {
		return poPrintServer;
	}

	public void setPoPrintServer(String poPrintServer) {
		this.poPrintServer = poPrintServer;
	}

	public String getParcelServiceTax() {
		return parcelServiceTax;
	}

	public void setParcelServiceTax(String parcelServiceTax) {
		this.parcelServiceTax = parcelServiceTax;
	}

	public String getParcelVat() {
		return parcelVat;
	}

	public void setParcelVat(String parcelVat) {
		this.parcelVat = parcelVat;
	}

	public String getRoundOffTotalAmtStatus() {
		return roundOffTotalAmtStatus;
	}

	public void setRoundOffTotalAmtStatus(String roundOffTotalAmtStatus) {
		this.roundOffTotalAmtStatus = roundOffTotalAmtStatus;
	}

	public String getKitchenPrintBt() {
		return kitchenPrintBt;
	}

	public void setKitchenPrintBt(String kitchenPrintBt) {
		this.kitchenPrintBt = kitchenPrintBt;
	}

	public String getBillPrintBt() {
		return billPrintBt;
	}

	public void setBillPrintBt(String billPrintBt) {
		this.billPrintBt = billPrintBt;
	}

	public int getKotCount() {
		return kotCount;
	}

	public void setKotCount(int kotCount) {
		this.kotCount = kotCount;
	}

	public String getDiscountPercentage() {
		return discountPercentage;
	}

	public void setDiscountPercentage(String discountPercentage) {
		this.discountPercentage = discountPercentage;
	}

	public String getVatTaxText() {
		return vatTaxText;
	}

	public void setVatTaxText(String vatTaxText) {
		this.vatTaxText = vatTaxText;
	}

	public String getServiceTaxText() {
		return serviceTaxText;
	}

	public void setServiceTaxText(String serviceTaxText) {
		this.serviceTaxText = serviceTaxText;
	}

	public double getVatAmt() {
		return vatAmt;
	}

	public void setVatAmt(double vatAmt) {
		this.vatAmt = vatAmt;
	}

	public double getServiceTaxAmt() {
		return serviceTaxAmt;
	}

	public void setServiceTaxAmt(double serviceTaxAmt) {
		this.serviceTaxAmt = serviceTaxAmt;
	}

	public String getParcelAddress() {
		return parcelAddress;
	}

	public void setParcelAddress(String parcelAddress) {
		this.parcelAddress = parcelAddress;
	}

	public String getMultiOrderTable() {
		return multiOrderTable;
	}

	public void setMultiOrderTable(String multiOrderTable) {
		this.multiOrderTable = multiOrderTable;
	}

	public String getCreditSale() {
		return creditSale;
	}

	public void setCreditSale(String creditSale) {
		this.creditSale = creditSale;
	}

	public String getCustomerDisplay() {
		return customerDisplay;
	}

	public void setCustomerDisplay(String customerDisplay) {
		this.customerDisplay = customerDisplay;
	}

	public String getParcelText() {
		return parcelText;
	}

	public void setParcelText(String parcelText) {
		this.parcelText = parcelText;
	}

	public String getKotPrintType() {
		return kotPrintType;
	}

	public void setKotPrintType(String kotPrintType) {
		this.kotPrintType = kotPrintType;
	}

	public String getDoubleRoundOff() {
		return doubleRoundOff;
	}

	public void setDoubleRoundOff(String doubleRoundOff) {
		this.doubleRoundOff = doubleRoundOff;
	}

	public String getTableScreen() {
		return tableScreen;
	}

	public void setTableScreen(String tableScreen) {
		this.tableScreen = tableScreen;
	}

	public String getSoftKey() {
		return softKey;
	}

	public void setSoftKey(String softKey) {
		this.softKey = softKey;
	}

	public String getMenuCollapsable() {
		return menuCollapsable;
	}

	public void setMenuCollapsable(String menuCollapsable) {
		this.menuCollapsable = menuCollapsable;
	}

	public String getBillSplit() {
		return billSplit;
	}

	public void setBillSplit(String billSplit) {
		this.billSplit = billSplit;
	}

	public String getIsPax() {
		return isPax;
	}

	public void setIsPax(String isPax) {
		this.isPax = isPax;
	}

	public String getPrintPaidBill() {
		return printPaidBill;
	}

	public void setPrintPaidBill(String printPaidBill) {
		this.printPaidBill = printPaidBill;
	}

	public String getCashDrawerCode() {
		return cashDrawerCode;
	}

	public void setCashDrawerCode(String cashDrawerCode) {
		this.cashDrawerCode = cashDrawerCode;
	}
	
	public String getItemWithImage() {
		return itemWithImage;
	}

	public void setItemWithImage(String itemWithImage) {
		this.itemWithImage = itemWithImage;
	}

	public String getMobBillPrint() {
		return mobBillPrint;
	}

	public void setMobBillPrint(String mobBillPrint) {
		this.mobBillPrint = mobBillPrint;
	}
	
	public String getPrintBillPaperSize() {
		return printBillPaperSize;
	}

	public void setPrintBillPaperSize(String printBillPaperSize) {
		this.printBillPaperSize = printBillPaperSize;
	}
	
	

	public String getServiceChargeText() {
		return serviceChargeText;
	}

	public void setServiceChargeText(String serviceChargeText) {
		this.serviceChargeText = serviceChargeText;
	}

	public Double getServiceChargeRate() {
		return serviceChargeRate;
	}

	public void setServiceChargeRate(Double serviceChargeRate) {
		this.serviceChargeRate = serviceChargeRate;
	}

		
	public String getServiceChargeFlag() {
		return serviceChargeFlag;
	}

	public void setServiceChargeFlag(String serviceChargeFlag) {
		this.serviceChargeFlag = serviceChargeFlag;
	}
	

	public String getDeliveryBoyFlag() {
		return deliveryBoyFlag;
	}

	public void setDeliveryBoyFlag(String deliveryBoyFlag) {
		this.deliveryBoyFlag = deliveryBoyFlag;
	}
	
	public int getBillCount() {
		return billCount;
	}

	public void setBillCount(int billCount) {
		this.billCount = billCount;
	}
	public String getSimpleIm() {
		return simpleIm;
	}

	public void setSimpleIm(String simpleIm) {
		this.simpleIm = simpleIm;
	}

	public String getOrdSucc() {
		return ordSucc;
	}

	public void setOrdSucc(String ordSucc) {
		this.ordSucc = ordSucc;
	}

	public String getIsBarcode() {
		return isBarcode;
	}

	public void setIsBarcode(String isBarcode) {
		this.isBarcode = isBarcode;
	}

	

	public String getAdvOrder() {
		return advOrder;
	}

	public void setAdvOrder(String advOrder) {
		this.advOrder = advOrder;
	}

	

	public String getIsProvideReason() {
		return isProvideReason;
	}

	public void setIsProvideReason(String isProvideReason) {
		this.isProvideReason = isProvideReason;
	}

	
	public String getDisplayCurrentStockMenu() {
		return displayCurrentStockMenu;
	}

	public void setDisplayCurrentStockMenu(String displayCurrentStockMenu) {
		this.displayCurrentStockMenu = displayCurrentStockMenu;
	}

	
	public String getNegativeStockBilling() {
		return negativeStockBilling;
	}

	public void setNegativeStockBilling(String negativeStockBilling) {
		this.negativeStockBilling = negativeStockBilling;
	}

	
	public String getIs_account() {
		return is_account;
	}

	public void setIs_account(String is_account) {
		this.is_account = is_account;
	}

	
	public String getIsRefund() {
		return isRefund;
	}

	public void setIsRefund(String isRefund) {
		this.isRefund = isRefund;
	}

	@Override
	public String toString() {
		return "Store [id=" + id + ", ip=" + ip + ", latitude=" + latitude + ", longitude=" + longitude + ", storeName="
				+ storeName + ", chainName=" + chainName + ", nameSearch=" + nameSearch + ", detailsSearch="
				+ detailsSearch + ", address=" + address + ", phoneNo=" + phoneNo + ", mobileNo=" + mobileNo
				+ ", emailId=" + emailId + ", status=" + status + ", city=" + city + ", state=" + state + ", country="
				+ country + ", category=" + category + ", url=" + url + ", operatingSystem=" + operatingSystem
				+ ", ram=" + ram + ", currency=" + currency + ", activeFlag=" + activeFlag + ", restaurantId="
				+ restaurantId + ", quality=" + quality + ", openTime=" + openTime + ", closeTime=" + closeTime
				+ ", deliveryTime=" + deliveryTime + ", workingHours=" + workingHours + ", minOrderAmt=" + minOrderAmt
				+ ", freeDelivery=" + freeDelivery + ", license=" + license + ", promotionDesc=" + promotionDesc
				+ ", promotionValue=" + promotionValue + ", promotionFlag=" + promotionFlag + ", openTimeWeekend="
				+ openTimeWeekend + ", closeTimeWeekend=" + closeTimeWeekend + ", openTimeHoliday=" + openTimeHoliday
				+ ", closeTimeHoliday=" + closeTimeHoliday + ", tableFlag=" + tableFlag + ", parcelFlag=" + parcelFlag
				+ ", homeDeliveryFlag=" + homeDeliveryFlag + ", dataSource=" + dataSource + ", mpayment=" + mpayment
				+ ", kitchenPrint=" + kitchenPrint + ", kitchenPrintPreview=" + kitchenPrintPreview + ", cashPayment="
				+ cashPayment + ", creditPayment=" + creditPayment + ", stockStatus=" + stockStatus + ", stockPeriod="
				+ stockPeriod + ", fromDes=" + fromDes + ", toDes=" + toDes + ", kotResTitleFont=" + kotResTitleFont
				+ ", kotTextFont=" + kotTextFont + ", kotDateTimeFont=" + kotDateTimeFont + ", kotTableFont="
				+ kotTableFont + ", kotItemTitleFont=" + kotItemTitleFont + ", kotItemFont=" + kotItemFont
				+ ", kotNoOfPersonFont=" + kotNoOfPersonFont + ", posmanualPrint=" + posmanualPrint + ", billPrint="
				+ billPrint + ", vatRegNo=" + vatRegNo + ", serviceTaxNo=" + serviceTaxNo + ", poPrintServer="
				+ poPrintServer + ", parcelServiceTax=" + parcelServiceTax + ", parcelVat=" + parcelVat
				+ ", roundOffTotalAmtStatus=" + roundOffTotalAmtStatus + ", kitchenPrintBt=" + kitchenPrintBt
				+ ", billPrintBt=" + billPrintBt + ", kotCount=" + kotCount + ", discountPercentage="
				+ discountPercentage + ", vatTaxText=" + vatTaxText + ", serviceTaxText=" + serviceTaxText + ", vatAmt="
				+ vatAmt + ", serviceTaxAmt=" + serviceTaxAmt + ", parcelAddress=" + parcelAddress
				+ ", multiOrderTable=" + multiOrderTable + ", creditSale=" + creditSale + ", customerDisplay="
				+ customerDisplay + ", parcelText=" + parcelText + ", kotPrintType=" + kotPrintType
				+ ", doubleRoundOff=" + doubleRoundOff + ", tableScreen=" + tableScreen + ", softKey=" + softKey
				+ ", menuCollapsable=" + menuCollapsable + ", billSplit=" + billSplit + ", isPax=" + isPax
				+ ", printPaidBill=" + printPaidBill + ", cashDrawerCode=" + cashDrawerCode + ", itemWithImage="
				+ itemWithImage + ", mobBillPrint=" + mobBillPrint + ", printBillPaperSize=" + printBillPaperSize
				+ ", gstText=" + gstText + ", gstRegNo=" + gstRegNo + ", serviceChargeText=" + serviceChargeText
				+ ", serviceChargeRate=" + serviceChargeRate + ", serviceChargeFlag=" + serviceChargeFlag
				+ ", deliveryBoyFlag=" + deliveryBoyFlag + ", billCount=" + billCount + ", simpleIm=" + simpleIm
				+ ", ordSucc=" + ordSucc + ", isBarcode=" + isBarcode + ", is_account=" + is_account + ", isRefund="
				+ isRefund + ", advOrder=" + advOrder + ", isProvideReason=" + isProvideReason
				+ ", displayCurrentStockMenu=" + displayCurrentStockMenu + ", negativeStockBilling="
				+ negativeStockBilling + "]";
	}
    
	
	
	
          
	
	}

	
	
	

