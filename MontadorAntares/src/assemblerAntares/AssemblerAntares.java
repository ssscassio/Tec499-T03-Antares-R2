/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package assemblerAntares;

import controller.Controller;
import java.util.Scanner;
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
        Controller controller = Controller.getInstance();
        System.out.println("Antares Assembler Tec-499\n\n");
        //assemblyChoice();
        controller.readAssembly("teste.asm");
        //controller.removeCommentsOnAssembly();
        try {
            controller.verifySyntax();
            controller.convertToBinary();
        } catch (Exception ex) {
            System.err.println(ex.getMessage());
        }
        
        
     
    }
    
    private static void assemblyChoice(){
        Controller controller = Controller.getInstance();
        Scanner reader = new Scanner(System.in);
        System.out.println("Insira o nome do arquivo .asm:");   
        String assembly = reader.next();
        controller.readAssembly(assembly); 
    }
    
}
