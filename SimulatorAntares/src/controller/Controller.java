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
    
    public static Map<String, Register> registers;// Key = 00100, Value = Value of register
    
    public Map<String, String> registersMap; // Key = $a0  Value = 00100 
    
    //Special Registers
    public Register LO;
    public Register HI;
    public Register PC;
    private Word[] memory;
    private int intructionsLimiter;
    private ALU alu;
    
    private Controller(){
        memory = new Word[1600];
        registers = new HashMap<String, Register>();
        registersMap = new HashMap<String, String>();
        alu = ALU.getInstance();
        this.loadRegisterSet();
        HI = new Register();
        LO = new Register();
        PC = new Register();
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
                registersMap.put(parts[0],aux );
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
    
    
    /**
     Instruction Control
     **/
    public void readBinaryFile(String binarytxt) {
    try {
            int i = 0;
            FileReader file;
            file = new FileReader(binarytxt);
            BufferedReader fileBuf = new BufferedReader(file);
            String row = fileBuf.readLine();
            while(row != null){
                Word w = new Word();
                w.setData(row);
                memory[i] = w;
                row = fileBuf.readLine();
                i++;
            }
            this.intructionsLimiter = i;
            
            file.close();
        } catch (FileNotFoundException ex) {
           System.err.println(ex.getMessage());
        } catch (IOException ex) {
           System.err.println(ex.getMessage());
        } 
    }
    
    public void fetch(){   
        // Se quiser simular passo a passo, mudar a condição de execução de cada um dos for(Colocar Leitura dentro do for)
        //for(Pc = 0; PC < InstructionsLimiter; PC=+4
        for(PC.setIntData(0) ; PC.getData() < this.intructionsLimiter*4; this.PC.setIntData(this.PC.getData() + 4)){
            this.decodeOperands(memory[PC.getData()/4].getData());
        }
    }
    
    public void decodeOperands(String row){
        String opcode = row.substring(0, 6);
        String[] params = new String[4];
        String function ="";
        switch(opcode){
            case "000000": case "011100": //R Instructions
                params[0] = row.substring(6, 11);
                params[1] = row.substring(11, 16);
                params[2] = row.substring(16, 21);
                params[3] = row.substring(21, 26);
                function = row.substring(26,32);
            break;
            case "000010": case "000011": //J Instructions
                params[0] = row.substring(6, 32);
            break;
            default:
                params[0] = row.substring(6, 11);
                params[1] = row.substring(11, 16);
                params[2] = row.substring(16, 32);    
        }
        
        System.out.println(row);
        System.err.println(opcode + " " + params[0] + " " + params[1] + " " + params[2] +" " + params[3] +" "+ function);

        this.execInstruction(opcode, params, function);  
    }
    
    public void execInstruction(String opcode, String[] params, String function){

        switch(opcode){
            case "000000": //SPECIAL
                switch(function){
                    case "100000":
                        alu.add(params[0], params[1], params[2]);
                        break;
                    case "100001":
                        alu.addu(params[0], params[1], params[2]);
                        break;
                    case "100010":
                        alu.sub(params[0], params[1], params[2]);
                        break;
                    case "100011":
                        alu.subu(params[0], params[1], params[2]);
                        break;
                    case "100100":
                        alu.and(params[0], params[1], params[2]);
                        break;
                    case "100111":
                        alu.nor(params[0], params[1], params[2]);
                        break;
                    case "100101":
                        alu.or(params[0], params[1], params[2]);
                        break;
                    case "100110":
                        alu.xor(params[0], params[1], params[2]);
                        break;
                    case "011010":
                        alu.div(params[0], params[1]);
                        break;
                    case "011011":
                        alu.divu(params[0], params[1]);
                        break;
                    case "011000":
                        alu.mult(params[0], params[1]);
                        break;
                    case "011001":
                        alu.multu(params[0], params[1]);
                        break;
                    case "000010":
                        switch(params[0]){
                            case "00001":
                               alu.rotr(params[1], params[2], params[3]);
                               break;
                            case "00000":
                               alu.srl(params[1], params[2], params[3]);
                               break; 
                        }
                        break;
                    case "000110":
                        switch(params[3]){
                            case "00001":
                                alu.rotrv(params[0], params[1], params[2]);
                                break;
                            case "00000":
                                alu.srlv(params[0], params[1], params[2]);
                                break;
                        }
                        break;
                    case "000000":
                        alu.sll(params[1], params[2], params[3]);
                        break;
                    case "000100":
                        alu.sllv(params[0], params[1], params[2]);
                        break;
                    case "000011":
                        alu.sra(params[1], params[2], params[3]);
                        break;
                    case "000111":
                        alu.srav(params[0], params[1], params[2]);
                        break;
                    case "001001":
                        alu.jalr(params[0], params[2]);
                        break;
                    case "001000":
                        alu.jr(params[0]);
                        break;
                    case "001011":
                        alu.movn(params[0], params[1], params[2]);
                        break;
                    case "001010":
                        alu.movz(params[0], params[1], params[2]);
                        break;
                    case "101010":
                        alu.slt(params[0], params[1], params[2]);
                        break;
                    case "101011":
                        alu.sltu(params[0], params[1], params[2]);
                        break;                        
                    case "010000":
                        alu.mfhi(params[2]);
                        break;
                    case "010010":
                        alu.mflo(params[2]);
                        break;
                    case "010001":
                        alu.mthi(params[0]);
                        break;
                    case "010011":
                        alu.mtlo(params[0]);
                        break;
                  }
                break;
            case "011100": //SPECIAL 2
                switch(function){
                    case "100000":
                        alu.clz(params[0], params[1], params[2]);
                        break;
                    case "100001":
                        alu.clo(params[0], params[1], params[2]);
                        break;                        
                    case "000000":
                        alu.madd(params[0], params[1]);
                        break;                        
                    case "000001":
                        alu.maddu(params[0], params[1]);
                        break;                        
                    case "000100":
                        alu.msub(params[0], params[1]);
                        break;                        
                    case "000101":
                        alu.msubu(params[0], params[1]);
                        break;
                    case "000010":
                        alu.mul(params[0], params[1], params[2]);
                        break;
                   
                }
                break;
            case "011111"://Special 3
                switch(params[3]){
                    case "10000":
                        alu.seb(params[1], params[2]);
                        break;
                    case "11000":
                        alu.seh(params[1], params[2]);
                        break;
                }
                break;
            case "001000":
                alu.addi(params[0], params[1], params[2]);
                break;
            case "001001":
                alu.addiu(params[0], params[1], params[2]);
                break;
            case "001111":
                alu.lui(params[1], params[2]);
                break;
            case "001100":
                alu.andi(params[0], params[1], params[2]);
                break;
            case "001101":
                alu.ori(params[0], params[1], params[2]);
                break;
            case "001110":
                alu.xori(params[0], params[1], params[2]);
                break;
            case "000100":
                alu.beq(params[0], params[1], params[2]);
                break;
            case "000101":
                alu.bne(params[0], params[1], params[2]);
                break;
            case "000010":
                alu.j(params[0]);
                break;
            case "000011":
                alu.jal(params[0]);
                break;
            case "001010":
                alu.slti(params[0], params[1], params[2]);
                break;
            case "001011":
                alu.sltiu(params[0], params[1], params[2]);
                break;
        }
    
    }
    /**
     End Instruction Control
     **/
    
}
