/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package assemblerAntares;

import controller.InstructionController;
import controller.RegisterController;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author KHAICK O. BRITO
 */
public class AssemblerAntares {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        RegisterController rc= new RegisterController();
        InstructionController ic = new InstructionController();
        
        rc.loadRegisterSet();
        ic.loadInstructionSet();
        
       
    
    
    }
    
}
