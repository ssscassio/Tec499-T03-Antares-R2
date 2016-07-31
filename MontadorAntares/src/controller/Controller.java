/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
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
                    Label l = new Label(instruction, lastAdress);
                    this.labels.put(instruction, l);
                }            
            }else{ //Instruction               
                try{
                    Instruction instruc = ic.getInstruction(instruction);
                    int i;
                    for(i = 1; i < instruc.getNumRegis()+1; i++){
                        if(!rc.checkContains(fields[i])){
                            throw new Exception("Erro na linha: " + command.getLineIndex()+"; Verifique o nome do registrador!");
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
                }catch(Exception ex){
                    //Erro, Instrução inexistente.
                    throw new Exception("Erro na linha: " + command.getLineIndex() +"; " + ex.getMessage());
                }
                
            } 
        }
        
        
    }
}
