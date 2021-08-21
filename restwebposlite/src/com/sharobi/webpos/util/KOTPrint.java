/**
 * 
 */
package com.sharobi.webpos.util;

import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.print.PageFormat;
import java.awt.print.Printable;
import java.awt.print.PrinterException;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.text.WordUtils;

import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.base.service.StoreService;

/**
 * @author habib
 *
 */
public class KOTPrint implements Printable{

	SimpleDateFormat df = new SimpleDateFormat();
	String receiptDetailLine;
	public static final String pspace = "               ";// 15-spaces
	Object[] printData = null;
	int storeId;
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

			Store store = storeService.getStoreById(storeId);
			int kotResTitlFont = store.getKotResTitleFont();
			int kotTxtFont = store.getKotTextFont();
			int kotDateTimeFont = store.getKotDateTimeFont();
			int kotItemFont = store.getKotItemFont();
			int kotItemTitlFont = store.getKotItemTitleFont();
			int kotResTableFont = store.getKotTableFont();
			int kotNoPersonFont = store.getKotNoOfPersonFont();

			Font font = new Font("MONOSPACED", Font.BOLD, 9);
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

			String kot = (String) dataToPrnt[0];
			String strName = (String) dataToPrnt[1];
			System.out.println("str name: " + strName);
			StringBuffer secnStrng = (StringBuffer) dataToPrnt[2];
			String secStrng = secnStrng.toString();
			System.out.println("secnd strng: " + secStrng);
			StringBuffer thrdStrng = (StringBuffer) dataToPrnt[3];
			String thrStrng = thrdStrng.toString();
			System.out.println("thrd strng: " + thrStrng);

			String noOfPerson = (String) dataToPrnt[4];

			Map<String, String> itemsMap = (Map<String, String>) dataToPrnt[5];
			int length = itemsMap.size();
			System.out.println("map length is..." + length);
			Set<String> keys = itemsMap.keySet();
			// int length=keys.size();
			// Print Table
			int space = 20;
			int y = 10;
			g2dKotTxt.translate(0,
					pageFormat.getImageableY());

			g2dKotTxt.setFont(fontKotTxt);
			g2dKotTxt.drawString(kot, 100, y);

			y = y + space;
			g2dResTitle.translate(pageFormat.getImageableX(),
					pageFormat.getImageableY());
			g2dResTitle.setFont(fontResTitle);
			g2dResTitle.drawString(strName, 0, y);

			y = y + space;
			g2dDateTime.translate(0, pageFormat.getImageableY());
			g2dDateTime.setFont(fontDateTime);
			g2dDateTime.drawString(secStrng, 0, y);

			y = y + space;
			g2dResTable.translate(0, pageFormat.getImageableY());
			g2dResTable.setFont(fontResTable);
			g2dResTable.drawString(thrStrng, 0, y);

			y = y + space;
			g2dNoPersons.translate(0, pageFormat.getImageableY());
			g2dNoPersons.setFont(fontNoOfPerson);
			g2dNoPersons.drawString(noOfPerson, 0, y);

			y = y + space - 10;
			g2dItemTitle.translate(0, pageFormat.getImageableY());
			g2dItemTitle.setFont(fontItemTitle);
			// g2dItemTitle.drawString(thrStrng, 0, y);

			/*
			 * String mod[][] = new String[][] { { "ITEM NAME", "QTY" }, {
			 * "Ceaser Salad", "1" }, { "MANCHOW SOUP", "10" }, {
			 * "Tomato Shorba", "4" }, { "Chicken Tikka W", "2" } };
			 */

			String mod[][] = new String[length + 2][length + 2];
			mod[0][0] = "ITEM NAME";
			mod[0][1] = "QTY";

			int j = 1;
			Iterator<String> iterateKeys = keys.iterator();
			while (iterateKeys.hasNext()) {

				String itemName = (String) iterateKeys.next();
				System.out.println("item name is::  " + itemName);
				String quantity = itemsMap.get(itemName);
				System.out.println("item quantity is::  " + quantity);

				while (j < (mod.length - 1)) {
					mod[j][0] = itemName;
					mod[j][1] = quantity;
					break;
				}
				j = j + 1;
			}
			mod[j][0] = "";
			mod[j][1] = ".............";

			int cH = 0;
			y = y + space;

			for (int i = 0; i < 1; i++) {
				String itemname = mod[i][0];
				String quantity = mod[i][1];
				cH = (y) + (10 * i); // shifting drawing line
				if (i != (mod.length - 1)) {
					g2dItemTitle.drawString(itemname, 00, cH);
					g2dItemTitle.drawString(quantity, 170, cH);
				}

			}
			y = y + 10;

			g2dItem.translate(0, pageFormat.getImageableY());
			g2dItem.setFont(fontItem);

			for (int i = 1; i < mod.length; i++) {
				String itemname = mod[i][0];
				String quantity = mod[i][1];
				cH = (y) + (15 * i); // shifting drawing line
				if (i != (mod.length - 1)) {
					int length1 = itemname.length();
					if (length1 <= 24) {
						g2dItem.drawString(itemname, 00, cH);
						g2dItem.drawString(quantity, 180, cH);
					} else {
						String temp = WordUtils.wrap(itemname, 24);
						String split1[] = temp.split("\\n");

						g2dItem.drawString(split1[0], 00, cH);
						g2dItem.drawString(quantity, 180, cH);

						for (int k = 1; k < split1.length; k++) {

							cH = (y + 10) + (15 * i);
							String name2 = split1[k];
							g2dItem.drawString(name2, 00, cH);
							g2dItem.drawString("", 180, cH);
							y = y + 10;
						}

					}
				} else {
					g2dItem.drawString("", 00, cH);
					g2dItem.drawString("....", 50, cH);
				}

			}
		} catch (Exception e) {
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
