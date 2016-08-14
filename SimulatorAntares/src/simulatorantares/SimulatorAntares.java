/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package simulatorantares;

import controller.Controller;

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
         
         controller.readBinaryFile("binary.txt");
    }
    
}
