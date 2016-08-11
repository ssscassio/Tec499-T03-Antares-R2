/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.HashMap;
import java.util.Map;
import model.Instruction;
import model.Register;

/**
 *
 * @author ssscassio
 */
public class InstructionController {
    
    private Map<String,Register> registers = new HashMap<String,Register>();
    
    public InstructionController(){
        readInstructionSet();
    
    }

    private void readInstructionSet() {
    
    
    }
}
