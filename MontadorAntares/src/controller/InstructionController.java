/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import config.DefaultConfig;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import model.Instruction;

/**
 *
 * @author ssscassio
 */
public class InstructionController {
    
    private Map<String,Instruction> instructions = new HashMap<String,Instruction>();

    public InstructionController(){
       this.loadInstructionSet();
    }
    
    public Instruction getInstruction(String keyToVerify) throws Exception{
        if(instructions.containsKey(keyToVerify))
            return instructions.get(keyToVerify);
        else
            throw new Exception("Instrução '"+keyToVerify+"' não existe!");
    
    }
    public void loadInstructionSet(){
        try{
            DefaultConfig conf = DefaultConfig.getInstance();
            FileReader file =  new FileReader(conf.INSTRUCTION_SET_FILE);
            BufferedReader fileBuf = new BufferedReader(file);
            String row = fileBuf.readLine();
            while(row != null){
                String[] parts = row.split(" ");
                Instruction i = new Instruction(parts[0].toLowerCase(), parts[1].toLowerCase(), Integer.parseInt(parts[2]), Integer.parseInt(parts[3]),                        Integer.parseInt(parts[4]), Integer.parseInt(parts[5]));
                this.instructions.put(parts[0].toLowerCase(), i);                
                row = fileBuf.readLine();
            }
            file.close();
        } catch (IOException ex) {
            System.err.printf("Erro na abertura do arquivo: %s. \n", ex.getMessage());
        } 
    }
}
