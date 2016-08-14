/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import config.DefaultConfig;
import java.io.*;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import model.Register;
import model.Word;

/**
 *
 * @author ssscassio
 */
public class Controller {
   
    private static Controller controller = null;
    
    public Map<String, Register> registers;// Key = $s0, Value = Value of register
    
    public Map<String, String> registersMap; // Key = 00100  Value = $a0 
    
    private Word[] memory;
    
    private Controller(){
        memory = new Word[1600];
        registers = new HashMap<String, Register>();
        registersMap = new HashMap<String, String>();
        this.loadRegisterSet();
    }
    
    public static Controller getInstance(){
        if(controller == null){
            controller = new Controller();
        }
        
        return controller;
    }
    
    /**
     Registers Control
     **/
    public void setRegistersDefaultValue(){
        Set<String> keys = registersMap.keySet();
        for (String key : keys) {
            registers.put(registersMap.get(key), new Register());
        }
    }
    
    public void loadRegisterSet(){
        try{
            DefaultConfig conf = DefaultConfig.getInstance();
            FileReader file =  new FileReader(conf.REGISTER_SET_FILE);
            BufferedReader fileBuf = new BufferedReader(file);
            String row = fileBuf.readLine();
            while(row != null){
                String[] parts = row.split(" ");
                DecimalFormat df = new DecimalFormat("00000");
                String aux = Integer.toBinaryString(Integer.parseInt(parts[1]));
                aux =df.format(Integer.parseInt(aux.toString()));
                registersMap.put(aux, parts[0]);
                System.out.println(registersMap.get(aux));
                row = fileBuf.readLine();
            }
            file.close();
        } catch (IOException ex) {
            System.err.printf("Erro na abertura do arquivo: %s. \n", ex.getMessage());
        }
    
    }
    /**
     End Registers Control
     **/
    
    
    public void readBinaryFile(String binarytxt) {
    try {
            int i = 0;
            FileReader file;
            file = new FileReader(binarytxt);
            BufferedReader fileBuf = new BufferedReader(file);
            String row = fileBuf.readLine();
            while(row != null){
                System.out.println(row); 
                Word w = new Word();
                w.setData(row);
                row = fileBuf.readLine();
            }
            file.close();
        } catch (FileNotFoundException ex) {
           System.err.println(ex.getMessage());
        } catch (IOException ex) {
           System.err.println(ex.getMessage());
        }
        
    }
    
}
