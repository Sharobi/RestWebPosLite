package com.sharobi.webpos.vfd;

/*
 *This Display class can use to show string(text) on a VFD Customer Display and etc.
 *This class accept only String inputs.
 *This source code implemented to use with a device which has SERIAL socket.
 *Before use this class you have to install serialport.dll and RXTXcomm.jar
 *For that you can download mfz-rxtx-2.2-20081207-win-x86.zip free on internet.
 *Unzip and follow instructions.
 *Visit http://velozit.blogspot.com for more details.
 *This demo is by gayan liyanaarachchi
 *Need to have a serial port on developing pc.
 *Design for EPSON ESC/POS command mode. 
 * 
 */

import gnu.io.*;                                      //import from RXTXcomm.jar
import java.io.*;
import java.util.Enumeration;
import java.util.logging.Level;
//import java.util.logging.Logger;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.http.HttpSession;

import com.sharobi.webpos.base.controller.OrderController;
import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.util.Constants;



/**
 *
 * @author All Open Source Developers
 * @version 1.0.0.0
 * @since 2014/12/22
 * @see instructions before start.
 */
public class Display {

    static  Enumeration       portList;
    static CommPortIdentifier portId;
    static SerialPort	      serialPort;
    static OutputStream       outputStream;
    static boolean	      outputBufferEmptyFlag = false;
    String  defaultPort = "COM4";
    
    @SuppressWarnings("SleepWhileInLoop")
    
    public Display(String comPort){
    	this.defaultPort = comPort;
    }
 public boolean StartDisplay() {
    
    boolean portFound = false;
    
    portList = CommPortIdentifier.getPortIdentifiers();
    while (portList.hasMoreElements()) {
	    portId = (CommPortIdentifier) portList.nextElement();
 
	    if (portId.getPortType() == CommPortIdentifier.PORT_SERIAL) {
 
		 if (portId.getName().equals(defaultPort)) {
		    System.out.println("Found port " + defaultPort);
                    portFound = true;
 
		    try {
			serialPort = (SerialPort) portId.open("SimpleWrite", 2000);
                        
		    } catch (PortInUseException e) {
			System.out.println("Port is offline now.");
                        continue;
		    } 
 
		    try {
			outputStream = serialPort.getOutputStream();
                     
		    } catch (IOException e) {
                   
                    }
 
		    try {
			serialPort.setSerialPortParams(9600, 
						       SerialPort.DATABITS_8, 
						       SerialPort.STOPBITS_1, 
						       SerialPort.PARITY_NONE);
                        System.out.println("Display is online now");
		    } catch (UnsupportedCommOperationException e) {
                          
                    }
	
 
		    try {
		    	serialPort.notifyOnOutputEmpty(true);
		    } catch (Exception e) {
			System.out.println("Error setting event notification");
			System.out.println(e.toString());
			//System.exit(-1);
		    }
 
                    
		    try {
		       Thread.sleep(100);                          // Be sure data is xferred before closing
		    } catch (Exception e) {}
		    
		} 
	    } 
	} 
 
	if (!portFound) {
	    System.out.println("port " + defaultPort + " not found.");
	    return false;
	} 
	return true;
}   
public void ClearDisplay(){
        try{
        outputStream.write(ESCPOS.SELECT_DISPLAY);
        outputStream.write(ESCPOS.VISOR_CLEAR);
        outputStream.write(ESCPOS.VISOR_HOME);
        outputStream.flush();
        }
        catch(IOException e){
        
        }
}
public void PrintFirstLine(String text){
    try{
    ClearDisplay();
    if(text.length()>20)            //Display can hold only 20 characters per line.Most of displays have 2 lines.
        text=text.substring(0,20);
    outputStream.write(text.getBytes());
    outputStream.flush();
   
    }
    catch(IOException r){
    }
    
}
public void PrintSecondLine(String text){
    try{
    outputStream.write(ESCPOS.SELECT_DISPLAY);
    outputStream.write(ESCPOS.Down_Line);
    outputStream.write(ESCPOS.Left_Line);
    if(text.length()>20)
        text=text.substring(0,20);
        outputStream.write(text.getBytes());
        outputStream.flush();
    }
    catch(IOException y){
        System.out.println("Failed to print second line because of :"+y);
    }
}
public void ShowGreeting(){
    String text1="*****Thank You******";                              // 20 characters
    String text2="     Visit Again     ";                              //20 characters
    ClearDisplay();
    PrintFirstLine(text1);
    PrintSecondLine(text2);
        try {
            Thread.sleep(100);                                   //Greeting will dislpay 5 seconds.
        } catch (InterruptedException ex) {
            LogManager.getLogger(Display.class).debug(ex);
        }
        ClearDisplay();
}
    public void init(){
    try{
     outputStream.write(ESCPOS.Anim);
    }
    catch(IOException i){}
}

public void close(){
     serialPort.close();
     //System.exit(1);
   
}
    

/*public static void main(String[] args) {
 new Display().vfdClient("Arun", "dude");
}*/

	public  void vfdClient(String comPort,String row1,String row2) {
		
		try {
			Display display = new Display(comPort);
			if(display.StartDisplay())
				{
				System.out.println("Row1:"+row1+":Row2:"+row2);
				display.PrintFirstLine(row1);
				display.PrintSecondLine(row2);
				try {
					Thread.sleep(100); // wait 5 seconds.otherwise unable to see above
										// outputs.
				} catch (InterruptedException ex) {
					LogManager.getLogger(Display.class).debug(ex);
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//display.close(); 
	}
public  void vfdpayClient(String comPort,String row1,String row2) {
		
		try {
			Display display = new Display(comPort);
			if(display.StartDisplay())
			{
				System.out.println("Row1:"+row1+":Row2:"+row2);
				display.PrintFirstLine(row1);
				display.PrintSecondLine(row2);
				try {
					Thread.sleep(1000); // wait 5 seconds.otherwise unable to see above
										// outputs.
				} catch (InterruptedException ex) {
					LogManager.getLogger(Display.class).debug(ex);
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//display.close(); 
	}
	
	public  void vfdWelcome(String comPort) {
		
		try {
			Display display = new Display(comPort);
			if(display.StartDisplay())
			{
				display.PrintFirstLine("WELCOME TO");
				display.PrintSecondLine("SARAVANAA");
				try {
					Thread.sleep(1000); // wait 5 seconds.otherwise unable to see above
										// outputs.
				} catch (InterruptedException ex) {
					LogManager.getLogger(Display.class).debug(ex);
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	


}
