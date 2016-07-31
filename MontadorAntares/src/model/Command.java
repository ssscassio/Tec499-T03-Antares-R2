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
    
    public Command(int lineIndex, String command){
        this.lineIndex = lineIndex;
        this.command = command;
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
        this.command = this.command.replace(" ", "-");
        this.params = this.command.split("-");

    }
    
    @Override
    public String toString(){
        return this.lineIndex + " " +this.command;
    }
}
