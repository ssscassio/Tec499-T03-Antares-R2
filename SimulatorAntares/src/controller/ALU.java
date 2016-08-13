/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

/**
 *
 * @author ssscassio
 */
public class ALU {
 
    private static Controller c = Controller.getInstance();
    

    private static void add(String rs, String rt, String rd){
        int aux =  c.registers.get(rs) +  c.registers.get(rt);
        c.registers.put(rd, aux);
    }
    
    private static void addi(String rs, String rd, int imm){
        int aux = c.registers.get(rs) + imm;
        c.registers.put(rd, aux);
    }
}
