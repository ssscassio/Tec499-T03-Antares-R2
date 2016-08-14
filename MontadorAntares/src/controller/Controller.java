/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Command;
import model.Instruction;
import model.Label;

/**
 *
 * @author ssscassio
 */
public class Controller {

    private RegisterController rc = new RegisterController();
    private InstructionController ic = new InstructionController();

    private ArrayList<Command> assembly;
    
    private Map<String,Label> labels = new HashMap<String, Label>();
    
    //Single Instance
    private static Controller controller = null;

    private int lastAdress = 1;
    private Controller() {

    }

    public static Controller getInstance() {
        if (controller == null) {
            controller = new Controller();
        }
        return controller;
    }

    public void readAssembly(String assemblyNameTxt) {
        this.assembly = new ArrayList();
        int i = 1;
        try {
            FileReader file = new FileReader(assemblyNameTxt);
            BufferedReader fileBuf = new BufferedReader(file);
            String row = fileBuf.readLine();
            while (row != null) {
                if(!row.trim().equals("")){
                    controller.removeCommentsOnAssembly();
                    this.assembly.add(new Command(i,row.trim().toLowerCase()));//Trim para remover espaços no inicio e no fim da linha
                }
                row = fileBuf.readLine();
                i++;
            }
            file.close();
        } catch (IOException ex) {
            System.err.printf("Erro na abertura do arquivo: %s. \n", ex.getMessage());
        }

    }

    public String convertToBinary() throws Exception{
        String finalBinary = new String();
        for(Command command : this.assembly){
            String binary = "";
            if(!labels.containsKey(command.getCommand())){//Instrução
                try {
                    binary = convert(command);
                    finalBinary += binary+"\n";
                } catch (Exception ex) {
                    throw new Exception("Erro na linha: " + command.getLineIndex() +"; " + ex.getMessage());
                }
            }else{ //Label

            
            }
        }
        return finalBinary;
    }

    private String convert(Command command) throws Exception{
        String binary = "";
        Instruction instruc = command.getInstruction();
        switch(instruc.getMnemonic()){
            case "add": case "addu": case "sub": case "subu": case "and":
            case "nor": case "or":  case "xor": case "mul": case "sllv":
            case "srav": case "srlv": case "movn": case "movz": case "stl":
            case "sltu":
                binary = (instruc.getOpcode()+ rc.registerBinaryValue(command.getFields()[2])+
                       rc.registerBinaryValue(command.getFields()[3]) + rc.registerBinaryValue(command.getFields()[1]) +"00000"+ instruc.getFunction() );
                break;
            case "mfhi": case "mflo":
                binary = (instruc.getOpcode()+ "0000000000" + rc.registerBinaryValue(command.getFields()[1]) +"00000"+ instruc.getFunction() );                
                break;
            case "mthi": case "mtlo":
                binary = (instruc.getOpcode()+ rc.registerBinaryValue(command.getFields()[1])+ "0000000000"  +"00000"+ instruc.getFunction() );                
                break;
            case "seb": case "seh": case "div": case "divu": case "madd": 
            case "maddu": case "msub": case "msubu": case "mult": case "multu":
                binary = (instruc.getOpcode()+ rc.registerBinaryValue(command.getFields()[1])+ rc.registerBinaryValue(command.getFields()[2])+  instruc.getFunction() );                
                break;
            case "clz": case "clo":
                binary = (instruc.getOpcode()+ rc.registerBinaryValue(command.getFields()[2])+ rc.registerBinaryValue(command.getFields()[1]) + rc.registerBinaryValue(command.getFields()[1])+ "00000" + instruc.getFunction() );                
                break;
            case "addi": case "andi": case "ori": case "xori": case "slti":
                binary = ( instruc.getOpcode() + rc.registerBinaryValue(command.getFields()[2]) +
                        rc.registerBinaryValue(command.getFields()[1]) +
                        convertImediateToBinary(Integer.parseInt(command.getFields()[3]), false));
                break;
            case "addiu": case "sltiu":
                binary = ( instruc.getOpcode() + rc.registerBinaryValue(command.getFields()[2]) + rc.registerBinaryValue(command.getFields()[1]) + convertImediateToBinary(Integer.parseInt(command.getFields()[3]), true));
                break;
            case "rotrv" :
                binary = (instruc.getOpcode()+ rc.registerBinaryValue(command.getFields()[2])+
                       rc.registerBinaryValue(command.getFields()[3]) + rc.registerBinaryValue(command.getFields()[1]) + instruc.getFunction() );
                break;
            case "rotr" :
                binary = (instruc.getOpcode()+"00001"+ rc.registerBinaryValue(command.getFields()[2])+
                       rc.registerBinaryValue(command.getFields()[1]) + convertShiftAmmount(Integer.parseInt(command.getFields()[3])) + instruc.getFunction() );
                break;
            case "sll": case "sra": case "srl":
                binary = (instruc.getOpcode()+ "00000" + rc.registerBinaryValue(command.getFields()[2]) +rc.registerBinaryValue(command.getFields()[1])+ convertShiftAmmount(Integer.parseInt(command.getFields()[3]))+instruc.getFunction());
                break;
            case "bne": case "beq":
                binary = (instruc.getOpcode() + rc.registerBinaryValue(command.getFields()[1]) + rc.registerBinaryValue(command.getFields()[2]) + defAddress(command.getAddress(),labels.get(command.getFields()[3]).getAddress()));
                break;
            case "beqz": case "bnez":
                binary = (instruc.getOpcode() + rc.registerBinaryValue(command.getFields()[1]) + "00000" + defAddress(command.getAddress(),labels.get(command.getFields()[2]).getAddress()));
                break;
            case "j": case "jal":
                binary = (instruc.getOpcode() + defAddress(command.getAddress(), labels.get(command.getFields()[1]).getAddress()));
                break;
            case "jalr":
                binary = ("000000" + rc.registerBinaryValue(command.getFields()[1]) + "00000" + rc.registerBinaryValue(command.getFields()[2]) + "00000" + instruc.getOpcode());
                break;
            case "jr":
                binary = ("000000" + rc.registerBinaryValue(command.getFields()[1]) + "0000000000" + "00000" + instruc.getOpcode());
            case "lui":
                String imediate16bits = convertShiftAmmount(Integer.parseInt(command.getFields()[2]));
                for(int i =1; imediate16bits.length()-1<15; i++){ //o imediato deve ter 16 bits
                    imediate16bits = "0"+imediate16bits;
                }
                binary = instruc.getOpcode()+ "00000" + rc.registerBinaryValue(command.getFields()[1])+ imediate16bits;
                break;
            case "li": case "la":case "move":case "negu":case "not":
                binary = pseudoConvert(command);
                break;
        }
        return binary;
    }
    
    private String defAddress(int actualAddress, int nextAddress){
        int result = nextAddress - actualAddress;
        String binaryAddress = convertImediateToBinary(result, false);
        return binaryAddress;
    }
    
    private String pseudoConvert(Command command) throws Exception {
        String binary = "";
        Instruction instruc = command.getInstruction();
        switch(instruc.getMnemonic()){

            case "li":
                //addi
                Instruction instructionAux1 = ic.getInstruction("addi");
                binary = ( instructionAux1.getOpcode() +
                        rc.registerBinaryValue("$zero") +
                        rc.registerBinaryValue(command.getFields()[1]) +
                        convertImediateToBinary(Integer.parseInt(command.getFields()[2]), false));
                break;
            case "la":
                //code lui
                int aux = labels.get(command.getFields()[2]).getAddress();
                String labelAdress = Integer.toString(aux);
                String binaryAdress = convertImediateToBinary(Integer.parseInt(labelAdress), false);
                Instruction instructionAux2 = ic.getInstruction("lui");
                binary = instructionAux2.getOpcode()+ "00000" + rc.registerBinaryValue("$t0")+ binaryAdress;

                //code ori
                Instruction instructionAux3 = ic.getInstruction("ori");
                binary = binary + "\n" + ( instructionAux3.getOpcode() + rc.registerBinaryValue(command.getFields()[1]) +
                        rc.registerBinaryValue("$t0") +
                        convertImediateToBinary(Integer.parseInt(labelAdress), false));
                break;
            case "move":
                //add
                Instruction instructionAux4 = ic.getInstruction("add");

                binary = (instructionAux4.getOpcode()+
                        rc.registerBinaryValue(command.getFields()[2])+
                        rc.registerBinaryValue("$zero") +
                        rc.registerBinaryValue(command.getFields()[1]) +"00000"+
                        instructionAux4.getFunction());
                break;
            case "negu":
                //subu
                Instruction instructionAux5 = ic.getInstruction("subu");
                binary = (instructionAux5.getOpcode()+
                        rc.registerBinaryValue("$zero")+
                        rc.registerBinaryValue(command.getFields()[2])+
                        rc.registerBinaryValue(command.getFields()[1]) +
                       "00000"+
                        instructionAux5.getFunction() );

                break;
            case "not":
                //nor
                Instruction instructionAux6 = ic.getInstruction("nor");
                binary = (instructionAux6.getOpcode()+
                        rc.registerBinaryValue(command.getFields()[2])+
                        rc.registerBinaryValue("$zero") +
                        rc.registerBinaryValue(command.getFields()[1]) +
                        "00000"+
                        instructionAux6.getFunction() );
        }
        return binary;
    }
    private String convertShiftAmmount(Integer ammount){
        ammount = ammount % 32;
        DecimalFormat df = new DecimalFormat("00000");
        String aux = Integer.toBinaryString(ammount);
        return df.format(Integer.parseInt(aux.toString()));        
    }
    
    private String convertImediateToBinary(Integer imediate, Boolean unsigned){
        if(unsigned){
            if(imediate < 0)
                imediate *= -1;
            DecimalFormat df = new DecimalFormat("0000000000000000");
            String aux = Integer.toBinaryString(imediate);
            return df.format(Integer.parseInt(aux.toString()));
        }else{
            if(imediate >= 0){
                DecimalFormat df = new DecimalFormat("000000000000000");
                String aux = Integer.toBinaryString(imediate);
                return "0"+df.format(Integer.parseInt(aux.toString()));
            }else{
                imediate*= -1;
                imediate = (1<<16) - imediate;
                String aux = Integer.toBinaryString(imediate);
                return aux.toString();
            }
        }
    }
    
    
    public void removeCommentsOnAssembly(){
        ArrayList<Command> aux = new ArrayList();
        for(Command command : this.assembly) {
            String row = command.getCommand();
            int comment = row.indexOf(";");
            
            if(comment == -1){
                aux.add(new Command(command.getLineIndex(), row));
            }
            else if(comment == 0){
                continue;
            }else{
                aux.add(new Command(command.getLineIndex(), row.substring(0, comment)));
            }    
        }
        this.assembly = aux;
    }

    public void verifySyntax() throws Exception{
        for(Command command : this.assembly){
            command.splitFields();
        }
        
        for(Command command : this.assembly){
            String fields[] = command.getFields();
            String instruction = fields[0];
            if(instruction.contains(":")){ //Label
                instruction = instruction.replace(":", "");
                if(labels.containsKey(instruction)){
                    //Erro, duas declarações para a mesma label;
                    throw new Exception("Erro na linha: " + command.getLineIndex() + "; A label '" + instruction + "' ja foi declarada");
                }else{
                    command.setAddress(lastAdress);
                    command.changeLabel(instruction);
                    Label l = new Label(instruction, lastAdress);
                    this.labels.put(instruction, l);
                }            
            }else{ //Instruction               
                try{
                    Instruction instruc = ic.getInstruction(instruction);
                    int i;
                    for(i = 1; i < instruc.getNumRegis()+1; i++){
                        if(!rc.checkContains(fields[i])){
                            throw new Exception(" Verifique o nome do registrador!");
                        }
                    }
                    for(; i < instruc.getNumConst()+instruc.getNumRegis()+1; i++){
                        if(fields[i] == null){
                            throw new Exception("Constante ou Label não encontrado!");
                        }else if(rc.checkContains(fields[i])){
                            throw new Exception("O parametro '" + i +"' deve ser uma constante ou label!");
                        }else if(fields[i].contains("$")){
                            throw new Exception("O parametro caractere '$' é exclusivo para registradores!");
                        }
                    }
                    command.setInstruction(instruc);
                    command.setAddress(lastAdress);
                    switch(instruc.getMnemonic()){
                        case "la": 
                            lastAdress+=2;
                            break;
                        case "li": case "move": case "negu": case "not":
                            lastAdress++;
                            break;
                        default:
                            lastAdress++;
                            break;
                    }
                }catch(Exception ex){
                    //Erro, Instrução inexistente.
                    throw new Exception("Erro na linha: " + command.getLineIndex() +"; " + ex.getMessage());
                }
                
            } 
        }
        
        
    }
}
