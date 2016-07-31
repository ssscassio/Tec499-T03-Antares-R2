/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.text.DecimalFormat;

/**
 *
 * @author ssscassio
 */
public class Register {
    
    private String simbol;
    private int value;
    
    public Register(String simbol, int value){
        this.simbol = simbol;
        this.value = value;
    }

    public String getSimbol(){
        return this.simbol;
    }
    public int getValue(){
        return this.value;
    }
    
    public String getBinaryValue(){
        DecimalFormat df = new DecimalFormat("00000");
        String aux = Integer.toBinaryString(value);
        return df.format(Integer.parseInt(aux.toString()));
    }
   
    
    
}
