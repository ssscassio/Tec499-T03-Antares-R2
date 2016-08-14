/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.math.BigInteger;
import java.text.DecimalFormat;
import sun.awt.X11.XConstants;

/**
 *
 * @author ssscassio
 */
public class Register {
    String data;
    
    public Register(int data){

    }
    
    public Register(){
            this.data = "00000000000000000000000000000000";
    }
    
    public int getUnsignedData(){
        
        return (int) Long.parseLong(data, 2);
    }
    
    public int getData(){
        int result = 0;
        for(int i = data.length() -1; i>0; i--){
            if(data.charAt(i) == '1'){
                result += Math.pow(2, 31-i);
            }
        }
        return result;
    }
    public void setIntData(int data){
        if(data<0){
            this.data = Integer.toBinaryString(data);
        }else{
            DecimalFormat df = new DecimalFormat("00000000000000000000000000000000");
            String aux = Integer.toBinaryString(data);
            this.data = df.format(  new BigInteger(aux) );           
        }
     }
    
    public void setData(String data){
        this.data = data;
    }
    
    public String getBinaryData(){
        return this.data;
    }
}
