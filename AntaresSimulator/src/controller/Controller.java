/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.ArrayList;
import model.Word;

/**
 *
 * @author ssscassio
 */
public class Controller {
    private ArrayList<Word> virtualMemory;
    private int $sp;
    private int $gp;
    private int $fp;
    
    private RegisterController rc = new RegisterController();
    private InstructionController ic = new InstructionController();
    
    Controller(){
        readInstructionSet();
    }

    private void readInstructionSet() {
   
    
    }
    
}
