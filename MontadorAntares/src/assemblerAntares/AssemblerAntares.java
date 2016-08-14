/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package assemblerAntares;

import controller.Controller;

import java.io.IOException;
import java.util.Scanner;

/**
 *
 * @author KHAICK O. BRITO
 */
public class AssemblerAntares {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        //O CÓDIGO QUE ESTAVA AQUI AGORA ESTÁ NA CLASSE FileChooser, no metodo readAsm.
Controller controller = Controller.getInstance();
        System.out.println("Antares Assembler Tec-499\n\n");
        controller.readAssembly("teste.asm");
        controller.removeCommentsOnAssembly();
        try {
            controller.verifySyntax();
            String binary = controller.convertToBinary();
//            System.out.print("\n \n"+binary);
//            writeBinary(path, fileName, binary);
        } catch (Exception ex) {
            System.err.println(ex.getMessage());
        }
//        FileChooser fileChooser = new FileChooser();
//        fileChooser.show();
    }
}
