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
    private ArrayList<String> staticMemory = new ArrayList<String>();
    private Map<String, Label> labels = new HashMap<String, Label>();

    private int GP = 16384;
    
    //Single Instance
    private static Controller controller = null;
    private ArrayList<String> dataRows = new ArrayList<>();

    private int actualAddress = 0;
    private boolean is_data = false;

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
                if (!row.trim().equals("")) {
                    controller.removeCommentsOnAssembly();
                    if (row.contains(".data"))
                        is_data = true;
                    else if(row.contains(".text"))
                        is_data = false;
                    else if(is_data) {
                        dataRows.add(row);
                    }
                    else
                        this.assembly.add(new Command(i, row.trim().toLowerCase()));//Trim para remover espaços no inicio e no fim da linha
                }
                row = fileBuf.readLine();
                i++;
            }
            file.close();
        } catch (IOException ex) {
            System.err.printf("Erro na abertura do arquivo: %s. \n", ex.getMessage());
        }

    }
    
    public String convertToBinary() throws Exception {
        String finalBinary = "";
        int i = 0;
        for (Command command : this.assembly) {
            String binary = "";
            if (!labels.containsKey(command.getCommand())) {//Instrução
                try {
                    binary = convert(command);
                    finalBinary+=binary+"\n";
                } catch (Exception ex) {
                    throw new Exception("Erro na linha: " + command.getLineIndex() + "; " + ex.getMessage());
                }
                System.err.println(binary);
            } else { //Label

            }
        }
        return finalBinary;
    }

    //>>>>>>>>>>>>>>>>>>>> FALTA CRIAR A INSTRUÇÃO LUI <<<<<<<<<<<<<<<<<

    private String convert(Command command) throws Exception {
        String binary = "";
        Instruction instruc = command.getInstruction();
        switch (instruc.getMnemonic()) {
            case "add":
            case "addu":
            case "sub":
            case "subu":
            case "and":
            case "nor":
            case "or":
            case "xor":
            case "sllv":
            case "srav":
            case "srlv":
            case "movn":
            case "movz":
            case "stl":
            case "sltu":
                binary = (instruc.getOpcode()+ rc.registerBinaryValue(command.getFields()[2])
                        + rc.registerBinaryValue(command.getFields()[3]) + rc.registerBinaryValue(command.getFields()[1]) + "00000" + instruc.getFunction());
                break;
            case "mul":
                binary = (instruc.getOpcode()+ rc.registerBinaryValue(command.getFields()[2])
                        + rc.registerBinaryValue(command.getFields()[3]) + rc.registerBinaryValue(command.getFields()[1]) + "00000" + instruc.getFunction());
                break;
            case "mfhi":
            case "mflo":
                binary = (instruc.getOpcode() + "0000000000" + rc.registerBinaryValue(command.getFields()[1]) + "00000" + instruc.getFunction());
                break;
            case "mthi":
            case "mtlo":
                binary = (instruc.getOpcode() + rc.registerBinaryValue(command.getFields()[1]) + "0000000000" + "00000" + instruc.getFunction());
                break;
            case "seb":
            case "seh":
                binary = (instruc.getFunction() + "00000" + rc.registerBinaryValue(command.getFields()[2]) + rc.registerBinaryValue(command.getFields()[1]) + instruc.getOpcode());
                break;
            case "div":
            case "divu":
            case "madd":
            case "maddu":
            case "msub":
            case "msubu":
            case "mult":
            case "multu":
                binary = (instruc.getOpcode() + rc.registerBinaryValue(command.getFields()[1]) + rc.registerBinaryValue(command.getFields()[2]) + instruc.getFunction());
                break;
            case "clz":
            case "clo":
                binary = (instruc.getOpcode() + rc.registerBinaryValue(command.getFields()[2]) + rc.registerBinaryValue(command.getFields()[1]) + rc.registerBinaryValue(command.getFields()[1]) + "00000" + instruc.getFunction());
                break;
            case "addi":
            case "andi":
            case "ori":
            case "xori":
            case "slti":
                binary = (instruc.getOpcode() + rc.registerBinaryValue(command.getFields()[2])
                        + rc.registerBinaryValue(command.getFields()[1])
                        + convertImediateToBinary(Integer.parseInt(command.getFields()[3]), false));
                break;
            case "addiu":
            case "sltiu":
                binary = (instruc.getOpcode() + rc.registerBinaryValue(command.getFields()[2]) + rc.registerBinaryValue(command.getFields()[1]) + convertImediateToBinary(Integer.parseInt(command.getFields()[3]), true));
                break;
            case "rotrv":
                binary = (instruc.getOpcode() + rc.registerBinaryValue(command.getFields()[2])
                        + rc.registerBinaryValue(command.getFields()[3]) + rc.registerBinaryValue(command.getFields()[1]) + instruc.getFunction());
                break;
            case "rotr":
                binary = (instruc.getOpcode() + "00001" + rc.registerBinaryValue(command.getFields()[2])
                        + rc.registerBinaryValue(command.getFields()[1]) + convertShiftAmmount(Integer.parseInt(command.getFields()[3])) + instruc.getFunction());
                break;
            case "sll":
            case "sra":
            case "srl":
                binary = (instruc.getOpcode() + "00000" + rc.registerBinaryValue(command.getFields()[2]) + rc.registerBinaryValue(command.getFields()[1]) + convertShiftAmmount(Integer.parseInt(command.getFields()[3])) + instruc.getFunction());
                break;
            case "bne":
            case "beq":
                binary = (instruc.getOpcode() + rc.registerBinaryValue(command.getFields()[1]) + rc.registerBinaryValue(command.getFields()[2]) + defAddress(command.getAddress(), labels.get(command.getFields()[3]).getAddress()));
                break;
            case "j":
            case "jal":
                binary = (instruc.getOpcode() +  convertToBinary26bits(labels.get(command.getFields()[1]).getAddress()));
                break;
            case "jalr":
                String[] aux = command.getFields();
                if(aux.length == 3)
                    binary = ("000000" + rc.registerBinaryValue(command.getFields()[1]) + "00000" + rc.registerBinaryValue(command.getFields()[2]) + "00000" + instruc.getFunction());
                else
                    binary = ("000000" + rc.registerBinaryValue(command.getFields()[1] + "00000" + rc.registerBinaryValue("ra") + "00000" + instruc.getFunction()));
                break;
            case "jr":
                binary = ("000000" + rc.registerBinaryValue(command.getFields()[1]) + "0000000000" + "00000" + instruc.getFunction());
                break;
            case "lui":
                String imediate16bits = convertShiftAmmount(Integer.parseInt(command.getFields()[2]));
                for (int i = 1; imediate16bits.length() - 1 < 15; i++) { //o imediato deve ter 16 bits
                    imediate16bits = "0" + imediate16bits;
                }
                binary = instruc.getOpcode() + "00000" + rc.registerBinaryValue(command.getFields()[1]) + imediate16bits;
                break;
            case "li":
            case "la":
            case "move":
            case "negu":
            case "not":
            case "beqz":
            case "bnez":
                binary = pseudoConvert(command);
                break;
            case "lw":
            case "lb":
            case "lh":
            case "sb":
            case "sw":
            case "sh":
                binary = (instruc.getOpcode() + rc.registerBinaryValue(command.getFields()[3]) + rc.registerBinaryValue(command.getFields()[1]) + convertImediateToBinary(Integer.parseInt(command.getFields()[2]), true));
                break;
            
        }
        return binary;
    }

    private String convertToBinary26bits(int index) {
        DecimalFormat df = new DecimalFormat("00000000000000000000000000");
        String aux = Integer.toBinaryString(index);
        return df.format(Integer.parseInt(aux.toString()));
    }

    private String defAddress(int actualAddress, int nextAddress) {
        int result = (nextAddress - 1) - actualAddress;
        String binaryAddress = convertImediateToBinary(result, false);
        return binaryAddress;
    }

    private String pseudoConvert(Command command) throws Exception {
        String binary = "";
        Instruction instruc = command.getInstruction();
        switch (instruc.getMnemonic()) {
            case "li":
                //addi
                Instruction instructionAux1 = ic.getInstruction("addiu");
                binary = (instructionAux1.getOpcode()
                        + rc.registerBinaryValue("$zero")
                        + rc.registerBinaryValue(command.getFields()[1])
                        + convertImediateToBinary(Integer.parseInt(command.getFields()[2]), true));
                break;
            case "la":
                //code lui
                int aux = labels.get(command.getFields()[2]).getAddress();
                String labelAdress = Integer.toString(aux);
                String binaryAdress = convertImediateToBinary(Integer.parseInt(labelAdress), false);
                Instruction instructionAux2 = ic.getInstruction("lui");
                binary = instructionAux2.getOpcode() + "00000" + rc.registerBinaryValue("$t0") + binaryAdress;

                //code ori
                Instruction instructionAux3 = ic.getInstruction("ori");
                binary = binary + "\n" + (instructionAux3.getOpcode() + rc.registerBinaryValue(command.getFields()[1])
                        + rc.registerBinaryValue("$t0")
                        + convertImediateToBinary(Integer.parseInt(labelAdress), false));
                break;
            case "move":
                //add
                Instruction instructionAux4 = ic.getInstruction("addu");

                binary = (instructionAux4.getOpcode()
                        + rc.registerBinaryValue("$zero")
                        +rc.registerBinaryValue(command.getFields()[2]) 
                        + rc.registerBinaryValue(command.getFields()[1]) + "00000"
                        + instructionAux4.getFunction());
                break;
            case "negu":
                //subu
                Instruction instructionAux5 = ic.getInstruction("subu");
                binary = (instructionAux5.getOpcode()
                        + rc.registerBinaryValue("$zero")
                        + rc.registerBinaryValue(command.getFields()[2])
                        + rc.registerBinaryValue(command.getFields()[1])
                        + "00000"
                        + instructionAux5.getFunction());

                break;
            case "not":
                //nor
                Instruction instructionAux6 = ic.getInstruction("nor");
                binary = (instructionAux6.getOpcode()
                        + rc.registerBinaryValue(command.getFields()[2])
                        + rc.registerBinaryValue("$zero")
                        + rc.registerBinaryValue(command.getFields()[1])
                        + "00000"
                        + instructionAux6.getFunction());
                break;
            case "beqz":
                Instruction instructionAux7 = ic.getInstruction("beq");
                binary = (instructionAux7.getOpcode() + rc.registerBinaryValue(command.getFields()[1]) + rc.registerBinaryValue("$zero") + defAddress(command.getAddress(), labels.get(command.getFields()[2]).getAddress()));
                break;
            case "bnez":
                Instruction instructionAux8 = ic.getInstruction("bne");
                binary = (instructionAux8.getOpcode() + rc.registerBinaryValue(command.getFields()[1]) + rc.registerBinaryValue("$zero") + defAddress(command.getAddress(), labels.get(command.getFields()[2]).getAddress()));
                break;
        }

        return binary;
    }

    private String convertShiftAmmount(Integer ammount) {
        ammount = ammount % 32;
        DecimalFormat df = new DecimalFormat("00000");
        String aux = Integer.toBinaryString(ammount);
        return df.format(Integer.parseInt(aux.toString()));
    }

    private String convertImediateToBinary(Integer imediate, Boolean unsigned) {
        if (unsigned) {
            if (imediate < 0) {
                imediate *= -1;
            }
            DecimalFormat df = new DecimalFormat("0000000000000000");
            String aux = Integer.toBinaryString(imediate);
            return df.format(Integer.parseInt(aux.toString()));
        } else {
            if (imediate >= 0) {
                DecimalFormat df = new DecimalFormat("000000000000000");
                String aux = Integer.toBinaryString(imediate);
                return "0" + df.format(Integer.parseInt(aux.toString()));
            } else {
                imediate *= -1;
                imediate = (1 << 16) - imediate;
                String aux = Integer.toBinaryString(imediate);
                return aux.toString();
            }
        }
    }

    public void removeCommentsOnAssembly() {
        ArrayList<Command> aux = new ArrayList();
        for (Command command : this.assembly) {
            String row = command.getCommand();
            row.replace(";", "#");
            int comment = row.indexOf("#");

            if (comment == -1) {
                aux.add(new Command(command.getLineIndex(), row));
            } else if (comment == 0) {
                continue;
            } else {
                aux.add(new Command(command.getLineIndex(), row.substring(0, comment)));
            }
        }
        this.assembly = aux;
    }

    public void verifySyntax() throws Exception {
        for (Command command : this.assembly) {
            command.splitFields();
        }

        for (Command command : this.assembly) {
            String fields[] = command.getFields();
            String instruction = fields[0];
            if (instruction.contains(":")) { //Label
                instruction = instruction.replace(":", "");
                if (labels.containsKey(instruction)) {
                    //Erro, duas declarações para a mesma label;
                    throw new Exception("Erro na linha: " + command.getLineIndex() + "; A label '" + instruction + "' ja foi declarada");
                } else {
                    command.setAddress(actualAddress);
                    command.changeLabel(instruction);
                    Label l = new Label(instruction, actualAddress);
                    this.labels.put(instruction, l);
                }
            } else { //Instruction
                try {
                    Instruction instruc = ic.getInstruction(instruction);
                    int i;
                    for (i = 1; i < instruc.getNumRegis() + 1; i++) {
                        if (!rc.checkContains(fields[i])) {
                            throw new Exception(" Verifique o nome do registrador!");
                        }
                    }
                    for (; i < instruc.getNumConst() + instruc.getNumRegis() + 1; i++) {
                        if (fields[i] == null) {
                            throw new Exception("Constante ou Label não encontrado!");
                        } else if (rc.checkContains(fields[i])) {
                            throw new Exception("O parametro '" + i + "' deve ser uma constante ou label!");
                        } else if (fields[i].contains("$")) {
                            throw new Exception("O parametro caractere '$' é exclusivo para registradores!");
                        }
                    }
                    command.setInstruction(instruc);
                    command.setAddress(actualAddress);
                    switch (instruc.getMnemonic()) {
                        case "la":
                            actualAddress += 2;
                            break;
                        case "li":
                        case "move":
                        case "negu":
                        case "not":
                            actualAddress++;
                            break;
                        default:
                            actualAddress++;
                            break;
                    }
                } catch (Exception ex) {
                    //Erro, Instrução inexistente.
                    throw new Exception("Erro na linha: " + command.getLineIndex() + "; " + ex.getMessage());
                }

            }
        }
        initData();
    }

    //trata os dados do .data
    public void initData() {
        String row = "";

        for(int i = 0; i<dataRows.size(); i++){
            row = dataRows.get(i);

            if(row.contains(".space")){
                String[] operators;
                row = row.replace("\t", "");
                operators = row.split(" ");
                String labelName = operators[0].replace(":", "");
                String valor = operators[2];

                Label label = new Label(labelName, this.GP);
                labels.put(labelName, label);
                int x = Integer.parseInt(valor);
                this.GP = GP + x;
            }
            else if (row.contains(".word")) {
                String[] operators;
                row = row.replace("\t", "");
                operators = row.split(".word");
                operators[0].replace("."," ");
                operators[0] = operators[0].replace(" ", "");
                String labelName = operators[0].replace(":", "");
                operators[1]= operators[1].replace(" ", "");
                String[] valor = operators[1].split(",");
                
                for(int j = 0; j < valor.length; GP+=4){
                    String data = convertWord(valor[j]);
                    this.staticMemory.add(data);
                }
                Label label = new Label(labelName, GP);
                labels.put(labelName, label);

            }
        }

    }    
    //converte o valores do .word para binário de 32 bits.
    public String convertWord(String valor){
            String aux = convertShiftAmmount(Integer.parseInt(valor));
            while (aux.length()-1 <31){
                aux = "0"+aux;
            }
        return aux;
    }
}
