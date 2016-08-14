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
         //controller.readBinaryFile("binary.txt");
         controller.setRegistersDefaultValue();
         int i = 101;
         Set<String> keys = controller.registers.keySet();
        for (String key : keys) {
            controller.registers.get(key).setIntData(i+=15);
            
            System.err.println(controller.registers.get(key).getBinaryData());
            System.err.println(controller.registers.get(key).getUnsignedData());
            System.err.println(controller.registers.get(key).getData());
        }
        controller.registers.get("$zero").setIntData(0);
        
        controller.PC.setIntData(100);
        /*
        alu.jal("00000000000000001110000100");
        */ controller.registers.get("$s0").setIntData(4);
        controller.registers.get("$s1").setIntData(100);
        alu.slti("$s0","$s1","0000000000000100");
                /*
        /*System.out.println(controller.registers.get("$s0").getBinaryData());
        alu.slt("$s1", "$s2", "$s0");
        /*
        alu.srl("$s1", "$s0", "00011");
        System.out.println(controller.registers.get("$s0").getBinaryData());
        /*alu.madd("$s1", "$s0");
        */
        
        System.out.println("PC: " + controller.PC.getBinaryData() +"\n" +
                           "$s0:"+ controller.registers.get("$s0").getBinaryData()+"\n"+
                            "$s1:"+ controller.registers.get("$s1").getBinaryData()+"\n"+
                            "$s2:"+ controller.registers.get("$s2").getBinaryData());

    }
    
}
