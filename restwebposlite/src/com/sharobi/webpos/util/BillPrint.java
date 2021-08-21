/**
 * 
 */
package com.sharobi.webpos.util;

import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.awt.print.PageFormat;
import java.awt.print.Printable;
import java.awt.print.PrinterException;
import java.io.IOException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.imageio.ImageIO;

import org.apache.commons.lang3.text.WordUtils;

import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.base.service.StoreService;

/**
 * @author habib
 *
 */
public class BillPrint implements Printable{
	
	SimpleDateFormat df = new SimpleDateFormat();
	String receiptDetailLine;
	public static final String pspace = "               ";// 15-spaces
	Object[] printData = null;
	int storeId;
	private BufferedImage image;
	StoreService storeService=new StoreService();
	//StoreAddressDAOImpl addressDAOImpl = new StoreAddressDAOImpl();

	public int print(Graphics graphics, PageFormat pageFormat, int pageIndex)
			throws PrinterException {

		try {
			df.applyPattern("dd/MM/yyyy HH:mm:ss");
			String strText = null;
			final String LF = "\n";// text string to output
			int lineStart; // start index of line in textarea
			int lineEnd; // end index of line in textarea
			int lineNumber;
			int lineCount;
			final String SPACE = "          ";// 10 spaces
			final String SPACES = "         ";// 9
			final String uline = "________________________________________";
			final String dline = "----------------------------------------";
			String greetings = "THANKS FOR YOUR VISIT";
			receiptDetailLine = "asdasdasda";
			Object[] dataToPrnt = null;

			Graphics2D g2d = (Graphics2D) graphics;
			Graphics2D g2dKotTxt = (Graphics2D) graphics;
			Graphics2D g2dResTitle = (Graphics2D) graphics;
			Graphics2D g2dDateTime = (Graphics2D) graphics;
			Graphics2D g2dResTable = (Graphics2D) graphics;
			Graphics2D g2dItemTitle = (Graphics2D) graphics;
			Graphics2D g2dItem = (Graphics2D) graphics;
			Graphics2D g2dNoPersons = (Graphics2D) graphics;
			Graphics2D g2dAddress = (Graphics2D) graphics;

			Store store =storeService.getStoreById(storeId);
			int kotResTitlFont = store.getKotResTitleFont();
			int kotTxtFont = store.getKotTextFont();
			int kotDateTimeFont = store.getKotDateTimeFont();
			int kotItemFont = store.getKotItemFont();
			int kotItemTitlFont = store.getKotItemTitleFont();
			int kotResTableFont = store.getKotTableFont();
			int kotNoPersonFont = store.getKotNoOfPersonFont();

			Font font = new Font("MONOSPACED", Font.BOLD, 10);
			Font fontKotTxt = new Font("MONOSPACED", Font.BOLD, kotTxtFont);
			Font fontResTitle = new Font("MONOSPACED", Font.BOLD,
					kotResTitlFont);
			Font fontDateTime = new Font("MONOSPACED", Font.BOLD,
					kotDateTimeFont);
			Font fontResTable = new Font("MONOSPACED", Font.BOLD,
					kotResTableFont);
			Font fontItemTitle = new Font("MONOSPACED", Font.BOLD,
					kotItemTitlFont);
			Font fontItem = new Font("MONOSPACED", Font.BOLD, kotItemFont);
			Font fontNoOfPerson = new Font("MONOSPACED", Font.BOLD,
					kotNoPersonFont);

			if (pageIndex < 0 || pageIndex >= 1) {
				return Printable.NO_SUCH_PAGE;
			}

			// Get Print Data
			dataToPrnt = getPrintData();

			// String kot = (String) dataToPrnt[0];
			String strName = (String) dataToPrnt[0];
			System.out.println("str name: " + strName);
			String address = (String) dataToPrnt[1];
			String emailId = (String) dataToPrnt[2];
			String phNumber = (String) dataToPrnt[3];

			String vatRegNo = (String) dataToPrnt[4];
			String serviceTaxNo = (String) dataToPrnt[5];
			String invoice = (String) dataToPrnt[6];
			String dateTable = (String) dataToPrnt[7];

			Map<Integer, List<String>> itemsMap = (Map<Integer, List<String>>) dataToPrnt[8];
			int length = itemsMap.size();
			System.out.println("map length is..." + length);
			Set<Integer> keys = itemsMap.keySet();
			List<String> nonVatItem = (List<String>) dataToPrnt[9];
			String nonVatItemText = nonVatItem.get(0);
			String nonVatItemAmt = nonVatItem.get(1);

			List<String> vatItem = (List<String>) dataToPrnt[10];
			String vatItemText = vatItem.get(0);
			String vatItemAmt = vatItem.get(1);

			List<String> totalAmt = (List<String>) dataToPrnt[11];
			String totalAmtTxt = totalAmt.get(0);
			String totalAmtVal = totalAmt.get(1);

			List<String> vatAmtLst = (List<String>) dataToPrnt[12];
			String vatAmtTxt = vatAmtLst.get(0);
			String vatAmtVal = vatAmtLst.get(1);

			List<String> serviceTaxLst = (List<String>) dataToPrnt[13];
			String servceTaxTxt = serviceTaxLst.get(0);
			String servceTaxVal = serviceTaxLst.get(1);

			List<String> dscntLst = (List<String>) dataToPrnt[14];
			String dscntTxt = dscntLst.get(0);
			String dscntVal = dscntLst.get(1);

			List<String> grossLst = (List<String>) dataToPrnt[15];
			String grossTxt = grossLst.get(0);
			String grossVal = grossLst.get(1);
			
			String tableNo = (String) dataToPrnt[16];
			
			List<String> paidAmtLst = (List<String>) dataToPrnt[17];
			String paidAmtTxt = paidAmtLst.get(0);
			String paidAmtVal = paidAmtLst.get(1);
			
			List<String> amtToPayLst = (List<String>) dataToPrnt[18];
			String amtToPayTxt = amtToPayLst.get(0);
			String amtToPayVal = amtToPayLst.get(1);

			// int length=keys.size();
			// Print Table
			int space = 10;
			int y = 20;
			/*
			 * g2dKotTxt.translate(pageFormat.getImageableX(),
			 * pageFormat.getImageableY());
			 * 
			 * g2dKotTxt.setFont(fontKotTxt); g2dKotTxt.drawString(kot, 0, y);
			 */

			try {
				image = ImageIO.read(new URL(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+"/image/store/get?name="+ store.getId()));

				if (image != null) {
					int w = image.getWidth();
					int h = image.getHeight();
					BufferedImage img = new BufferedImage(w, h,
							BufferedImage.TYPE_INT_ARGB); // Graphics2D g2dImage
															// =
					img.createGraphics();

					g2d.drawImage(image, 37 + w / 2, y-10, null); //
					y = y + h+5;
				}
				// g2d.setPaint(Color.red);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			y = y + space;
			g2dResTitle.translate(pageFormat.getImageableX(),
					pageFormat.getImageableY());
			g2dResTitle.setFont(fontResTitle);
			g2dResTitle.drawString(strName, 0, y);

			y = y + space + 10;
			g2d.translate(pageFormat.getImageableX(),
					pageFormat.getImageableY());
			g2d.setFont(font);
			g2d.drawString(address, 0, y);

			y = y + space;
			g2d.translate(pageFormat.getImageableX(),
					pageFormat.getImageableY());
			g2d.setFont(font);
			g2d.drawString(emailId, 0, y);

			y = y + space;
			g2d.translate(pageFormat.getImageableX(),
					pageFormat.getImageableY());
			g2d.setFont(font);
			g2d.drawString(phNumber, 0, y);

			y = y + space;
			g2d.translate(pageFormat.getImageableX(),
					pageFormat.getImageableY());
			g2d.setFont(font);
			g2d.drawString(vatRegNo, 0, y);

			y = y + space;
			g2d.translate(pageFormat.getImageableX(),
					pageFormat.getImageableY());
			g2d.setFont(font);
			g2d.drawString(serviceTaxNo, 0, y);

			y = y + space + 10;
			g2dDateTime.translate(pageFormat.getImageableX(),
					pageFormat.getImageableY());
			g2dDateTime.setFont(fontDateTime);
			g2dDateTime.drawString(invoice, 0, y);

			y = y + space;
			g2dDateTime.translate(pageFormat.getImageableX(),
					pageFormat.getImageableY());
			g2dDateTime.setFont(fontDateTime);
			g2dDateTime.drawString(dateTable, 0, y);

			y = y + space;
			g2dDateTime.translate(pageFormat.getImageableX(),
					pageFormat.getImageableY());
			g2dDateTime.setFont(fontDateTime);
			g2dDateTime.drawString(tableNo, 0, y);

			y = y + space;
			g2dItemTitle.translate(pageFormat.getImageableX(),
					pageFormat.getImageableY());
			g2dItemTitle.setFont(fontItemTitle);
			// g2dItemTitle.drawString(thrStrng, 0, y);

			/*
			 * String mod[][] = new String[][] { { "ITEM NAME", "QTY" }, {
			 * "Ceaser Salad", "1" }, { "MANCHOW SOUP", "10" }, {
			 * "Tomato Shorba", "4" }, { "Chicken Tikka W", "2" } };
			 */

			String mod[][][] = new String[length + 2][length + 2][length + 2];
			mod[0][0][0] = "Item Name";
			mod[0][0][1] = "Qty";
			mod[0][0][2] = "Amount";

			int j = 1;
			Iterator<Integer> iterateKeys = keys.iterator();
			while (iterateKeys.hasNext()) {

				Integer itemId = (Integer) iterateKeys.next();
				System.out.println("item id is::  " + itemId);
				List<String> itemLst = itemsMap.get(itemId);
				String itemName = itemLst.get(0);
				String quantity = itemLst.get(1);
				System.out.println("item quantity is::  " + quantity);
				String totalPriceByItem = itemLst.get(2);

				while (j < (mod.length - 1)) {
					mod[j][0][0] = itemName;
					mod[j][0][1] = quantity;
					mod[j][0][2] = totalPriceByItem;
					break;
				}
				j = j + 1;
			}
			mod[j][0][0] = "";
			mod[j][0][1] = ".............";
			mod[j][0][2] = "";

			int cH = 0;
			y = y + space;

			for (int i = 0; i < 1; i++) {
				String itemname = mod[i][0][0];
				String quantity = mod[i][0][1];
				String totalPriceByItem = mod[i][0][2];
				cH = (y) + (10 * i); // shifting drawing line
				if (i != (mod.length - 1)) {
					g2dItemTitle.drawString(itemname, 00, cH);
					g2dItemTitle.drawString(quantity, 121, cH);
					g2dItemTitle.drawString(totalPriceByItem, 155, cH);
				}

			}
			y = y + 5;

			g2dItem.translate(pageFormat.getImageableX(),
					pageFormat.getImageableY());
			g2dItem.setFont(fontItem);

			int d3 = 6;
			int d4 = 2 * d3;

			int bx = 160;

			for (int i = 1; i < mod.length; i++) { // items
				String itemname = mod[i][0][0];
				String quantity = mod[i][0][1];
				String totalPriceByItem = mod[i][0][2];
				cH = (y) + (15 * i); // shifting drawing line
				if (i != (mod.length - 1)) {
					int length1 = itemname.length();
					if (length1 <= 20) {
						g2dItem.drawString(itemname, 00, cH);
						g2dItem.drawString(quantity, 131, cH);

						if (totalPriceByItem.length() > 6) // d4
							g2dItem.drawString(totalPriceByItem, bx - d4, cH);
						else if (totalPriceByItem.length() > 5) // d3
							g2dItem.drawString(totalPriceByItem, bx - d3, cH);
						else
							g2dItem.drawString(totalPriceByItem, bx, cH);

					} else {
						String temp = WordUtils.wrap(itemname, 20);
						String split1[] = temp.split("\\n");

						g2dItem.drawString(split1[0], 00, cH);
						g2dItem.drawString(quantity, 131, cH);
						// g2dItem.drawString(totalPriceByItem, 160, cH);

						if (totalPriceByItem.length() > 6) // d4
							g2dItem.drawString(totalPriceByItem, bx - d4, cH);
						else if (totalPriceByItem.length() > 5) // d3
							g2dItem.drawString(totalPriceByItem, bx - d3, cH);
						else
							g2dItem.drawString(totalPriceByItem, bx, cH);

						for (int k = 1; k < split1.length; k++) {

							cH = (y + 10) + (15 * i);
							String name2 = split1[k];
							g2dItem.drawString(name2, 00, cH);
							g2dItem.drawString("", 130, cH);
							g2dItem.drawString("", 170, cH);
							y = y + 10;
						}

					}
				}
			}

			g2d.translate(pageFormat.getImageableX(),
					pageFormat.getImageableY());
			g2d.setFont(font);

			g2d.drawString("...................................", 00, cH);
			// g2d.drawString("", 170, cH);

			cH = cH + 15;
			g2d.drawString(nonVatItemText, 00, cH);
			// g2d.drawString(nonVatItemAmt, bx, cH);

			if (nonVatItemAmt.length() > 6) // d4
				g2dItem.drawString(nonVatItemAmt, bx - d4, cH);
			else if (nonVatItemAmt.length() > 5) // d3
				g2dItem.drawString(nonVatItemAmt, bx - d3, cH);
			else
				g2dItem.drawString(nonVatItemAmt, bx, cH);

			cH = cH + 10;
			g2d.drawString(vatItemText, 00, cH);
			// g2d.drawString(vatItemAmt, bx, cH);
			if (vatItemAmt.length() > 6) // d4
				g2dItem.drawString(vatItemAmt, bx - d4, cH);
			else if (vatItemAmt.length() > 5) // d3
				g2dItem.drawString(vatItemAmt, bx - d3, cH);
			else
				g2dItem.drawString(vatItemAmt, bx, cH);

			cH = cH + 10;
			g2d.drawString(totalAmtTxt, 00, cH);
			// g2d.drawString(totalAmtVal, bx, cH);
			if (totalAmtVal.length() > 6) // d4
				g2dItem.drawString(totalAmtVal, bx - d4, cH);
			else if (totalAmtVal.length() > 5) // d3
				g2dItem.drawString(totalAmtVal, bx - d3, cH);
			else
				g2dItem.drawString(totalAmtVal, bx, cH);

			cH = cH + 10;
			g2d.drawString(vatAmtTxt, 00, cH);
			// g2d.drawString(vatAmtVal, bx, cH);
			if (vatAmtVal.length() > 6) // d4
				g2dItem.drawString(vatAmtVal, bx - d4, cH);
			else if (vatAmtVal.length() > 5) // d3
				g2dItem.drawString(vatAmtVal, bx - d3, cH);
			else
				g2dItem.drawString(vatAmtVal, bx, cH);

			cH = cH + 10;
			g2d.drawString(servceTaxTxt, 00, cH);
			// g2d.drawString(servceTaxVal, bx, cH);
			if (servceTaxVal.length() > 6) // d4
				g2dItem.drawString(servceTaxVal, bx - d4, cH);
			else if (servceTaxVal.length() > 5) // d3
				g2dItem.drawString(servceTaxVal, bx - d3, cH);
			else
				g2dItem.drawString(servceTaxVal, bx, cH);

			cH = cH + 10;
			g2d.drawString(dscntTxt, 00, cH);
			// g2d.drawString(dscntVal, bx, cH);
			if (dscntVal.length() > 6) // d4
				g2dItem.drawString(dscntVal, bx - d4, cH);
			else if (dscntVal.length() > 5) // d3
				g2dItem.drawString(dscntVal, bx - d3, cH);
			else
				g2dItem.drawString(dscntVal, bx, cH);

			g2dItemTitle.translate(pageFormat.getImageableX(),
					pageFormat.getImageableY());
			g2dItemTitle.setFont(fontItemTitle);

			cH = cH + 20;
			g2dItemTitle.drawString(grossTxt, 00, cH);
			// g2dItemTitle.drawString(grossVal, 168, cH);

			if (grossVal.length() > 6) // d4
				g2dItem.drawString(grossVal, bx - d4 - 5, cH);
			else if (grossVal.length() > 5) // d3
				g2dItem.drawString(grossVal, bx - d3 - 5, cH);
			else
				g2dItem.drawString(grossVal, bx - 5, cH);
			
			cH = cH + 10;
			g2d.drawString("...................................", 00, cH);
			
			cH = cH + 15; // print paid amount
			g2dItemTitle.drawString(paidAmtTxt, 00, cH);
			
			if (paidAmtVal.length() > 6) // d4
				g2dItemTitle.drawString(paidAmtVal, bx - d4 - 5, cH);
			else if (paidAmtVal.length() > 5) // d3
				g2dItemTitle.drawString(paidAmtVal, bx - d3 - 5, cH);
			else
				g2dItemTitle.drawString(paidAmtVal, bx - 5, cH);
			
			cH = cH + 10; // print amount to pay
			g2dItemTitle.drawString(amtToPayTxt, 00, cH);
			
			if (amtToPayVal.length() > 6) // d4
				g2dItemTitle.drawString(amtToPayVal, bx - d4 - 5, cH);
			else if (amtToPayVal.length() > 5) // d3
				g2dItemTitle.drawString(amtToPayVal, bx - d3 - 5, cH);
			else
				g2dItemTitle.drawString(amtToPayVal, bx - 5, cH);

			cH = cH + 25;
			g2d.drawString("Thank you. Visit us again.  ", 00, cH);

			Calendar cal = Calendar.getInstance();
	    	cal.getTime();
	    	SimpleDateFormat sdf = new SimpleDateFormat("hh:mm a");
	    	String currentTime=sdf.format(cal.getTime());
	    	
			cH = cH + 40;
			g2d.drawString(currentTime, 00, cH);
			
			/*//draw image start
			
			cH = cH + 10;
			
			try {
	            image = ImageIO.read(new URL(
	                    "http://localhost:8080/Restaurant/rest/image/store/get?name=33"));
	            int w = image.getWidth();
		        int h = image.getHeight();
		        BufferedImage img = new BufferedImage(
		                w, h, BufferedImage.TYPE_INT_ARGB);
		        //Graphics2D g2dImage = img.createGraphics();
		        g2d.drawImage(image, 00, cH, null);
		       // g2d.setPaint(Color.red);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
			
			//draw image end
*/		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return Printable.PAGE_EXISTS;
	}

	public void setPrintData(Object[] data, int storeId) {

		this.printData = data;
		this.storeId = storeId;

	}

	public Object[] getPrintData() {

		return printData;

	}

}
