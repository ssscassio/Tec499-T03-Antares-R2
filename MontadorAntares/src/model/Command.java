/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.ArrayList;

/**
 *
 * @author ssscassio
 */
public class Command {
    private int lineIndex;
    private String[] params;
    private String command;
    private Instruction instruc;
    
    public Command(int lineIndex, String command){
        this.lineIndex = lineIndex;
        this.command = command;
    }
    
    public void setInstruction(Instruction i){
        this.instruc = i;
    }
    
    public void changeLabel(String label){
        this.command = label;
    }
    
    public Instruction getInstruction(){
        return instruc;
    }
    
    public int getLineIndex(){
        return this.lineIndex;
    }
    
    public String getCommand(){
        return this.command;
    }
    
    public String[] getFields(){
        return params;
    }
    
    public void splitFields(){  
        this.command = this.command.replace(",", "");
        this.command = this.command.trim();
        if(command.indexOf("(") != -1){
            command = this.command.replace("(", " ");
            command = this.command.replace(")", "");
        }
        this.params = this.command.split(" ");

    }
    
    @Override
    public String toString(){
        return this.lineIndex + " " +this.command;
    }
}
