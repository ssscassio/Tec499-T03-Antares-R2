/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.HashMap;
import java.util.Map;
import model.Register;

/**
 *
 * @author ssscassio
 */
public class RegisterController {
    private Map<String, Register> registers;
    
    public RegisterController(){
        this.registers = new HashMap<>();
        readRegisterSet();
    }

    private void readRegisterSet() {
        
        
    }
}
