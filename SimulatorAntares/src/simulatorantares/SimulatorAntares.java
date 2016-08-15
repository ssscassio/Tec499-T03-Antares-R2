/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package simulatorantares;

import controller.ALU;
import controller.Controller;
import java.util.Random;
import java.util.Scanner;
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
        String leitura;
        System.out.println("##########  Antares R2 - Simulator  ##########\n\n");      
        Scanner leitor = new Scanner(System.in);
        System.out.println("Informe o caminho e nome do arquivo que deseja ler");
        leitura = leitor.next();
        int leitura2;
        System.out.println(controller.readBinaryFile(leitura));
        controller.setRegistersDefaultValue();

        do{
        System.out.println("### Antares R2 - Menu ###\n\n");
        System.out.println("1 - Simulação direta\n2 - Simulação passo a passo\n");
        leitura2 = leitor.nextInt();
        
        }while(leitura2 != 2 && leitura2 !=1);

        switch(leitura2){
            case 1:
                controller.fetch();         
                break;
            case 2:
                controller.fetchStepByStep();
                break;
        }
        
        System.out.println("Aperte a tecla 'ENTER' para ver a área de memória utilizada.\n");
        Scanner scanner = new Scanner( System.in );
        scanner.nextLine();
        controller.memoryStatus();
        
    }
    
}
