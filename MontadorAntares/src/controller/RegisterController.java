/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import config.DefaultConfig;
import java.io.*;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Register;

/**
 *
 * @author ssscassio
 */
public class RegisterController {
    
    private Map<String,Register> registers = new HashMap<String,Register>();
    
    public RegisterController(){
    
    }
    
    public void loadRegisterSet(){
        try{
            DefaultConfig conf = DefaultConfig.getInstance();
            FileReader file =  new FileReader(conf.REGISTER_SET_FILE);
            BufferedReader fileBuf = new BufferedReader(file);
            String row = fileBuf.readLine();
            while(row != null){
                String[] parts = row.split(" ");
                Register r = new Register(parts[0], Integer.parseInt(parts[1]));
                this.registers.put(parts[0], r);
                row = fileBuf.readLine();
            }
            file.close();
        } catch (IOException ex) {
            System.err.printf("Erro na abertura do arquivo: %s. \n", ex.getMessage());
        }
    
    }
}
