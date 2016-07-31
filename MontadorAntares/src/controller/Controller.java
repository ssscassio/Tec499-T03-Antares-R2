/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

/**
 *
 * @author ssscassio
 */
public class Controller {

    private RegisterController rc = new RegisterController();
    private InstructionController ic = new InstructionController();

    private ArrayList<String> assembly;
    
    //Single Instance
    private static Controller controller = null;

    private Controller() {

    }

    public static Controller getInstance() {
        if (controller == null) {
            controller = new Controller();
        }
        return controller;
    }

    public void readAssembly(String assemblyNameTxt) {
        this.assembly = new ArrayList();
        try {
            FileReader file = new FileReader(assemblyNameTxt);
            BufferedReader fileBuf = new BufferedReader(file);
            String row = fileBuf.readLine();
            while (row != null) {
                this.assembly.add(row);
                row = fileBuf.readLine();
            }
            file.close();
        } catch (IOException ex) {
            System.err.printf("Erro na abertura do arquivo: %s. \n", ex.getMessage());

        }
    }

}
