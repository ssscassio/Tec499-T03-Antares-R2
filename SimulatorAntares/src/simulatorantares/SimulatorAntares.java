/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package simulatorantares;

import controller.ALU;
import controller.Controller;
import java.util.Random;
import java.util.Set;
import model.Register;

/**
 *
 * @author ssscassio
 */
public class SimulatorAntares {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
   
        Controller controller = Controller.getInstance();
        ALU alu = ALU.getInstance();
        controller.readBinaryFile("binary.txt");
        controller.setRegistersDefaultValue();
        controller.fetch();
        
        //Inicio Deletar depois, só para teste
        int i = 101; 
        Set<String> keys = controller.registers.keySet();
        for (String key : keys) { 
            controller.registers.get(key).setIntData(i+=15);
            
        }
        controller.registers.get("00000").setIntData(0); 
        
        controller.PC.setIntData(0);
        
    }
    
}
