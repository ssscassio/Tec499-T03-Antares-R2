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
    
    private static ALU aluInstance = null;
   
    private ALU(){
    
    }
    
    public static ALU getInstance(){
        if(aluInstance == null){
            aluInstance = new ALU();          
        }
        return aluInstance;
    }
    
    public void add(String rs, String rt, String rd){
        int aux =  c.registers.get(rs).getData() +  c.registers.get(rt).getData();
        c.registers.get(rd).setIntData(aux);
    }
    
    public void addi(String rs, String rd, String imm){
        int bin = Integer.parseInt(imm, 2);
        int aux = c.registers.get(rs).getData() + bin;
        c.registers.get(rd).setIntData(aux);
    }
    
    public void addiu(String rs, String rd, String imm){
        int bin = Integer.parseUnsignedInt(imm, 2);
        int aux = c.registers.get(rs).getUnsignedData() + bin;
        c.registers.get(rd).setIntData(aux);
    }
    
    public void addu(String rs, String rt, String rd){//Verificar questão de ser Unsigned
        int aux =  c.registers.get(rs).getUnsignedData() +  c.registers.get(rt).getUnsignedData();
        c.registers.get(rd).setIntData(aux);
    }
    
    public void clz(String rs, String rt, String rd){
        String aux = c.registers.get(rs).getBinaryData();
        int count =  0;
        for(int i=0; i<=aux.length();i++){
            char ch = aux.charAt(i);
            String x1 = String.valueOf(ch);
            if(x1.equalsIgnoreCase("0")){
                    count++;
            }
        }
        if(count !=0)
            c.registers.get(rd).setIntData(count);
        else
            c.registers.get(rt).setIntData(32);
    }
    
    public void clo(String rs, String rt, String rd){
        String aux = c.registers.get(rs).getBinaryData();
        int count =  0;
        for(int i=0; i<=aux.length();i++){
            char ch = aux.charAt(i);
            String x1 = String.valueOf(ch);
            if(x1.equalsIgnoreCase("1")){
                    count++;
            }
        }
        if(count !=0)
            c.registers.get(rd).setIntData(count);
        else
            c.registers.get(rt).setIntData(32);
        
        
    }
    
    public void lui(String rd, String imm){
        imm = imm + "0000000000000000";
        c.registers.get(rd).setData(imm);
    }
    
    public void seb(String rt, String rd){
        String rtValue = c.registers.get(rt).getBinaryData();
        rtValue = rtValue.substring(24, 32);
        char Sign = rtValue.charAt(0);
        if(Sign == '0'){
            rtValue = "000000000000000000000000"+rtValue;
        }else if(Sign == '1'){
            rtValue = "111111111111111111111111"+rtValue;
        }
        c.registers.get(rd).setData(rtValue);
    }
    
    public void seh(String rt, String rd){
        String rtValue = c.registers.get(rt).getBinaryData();
        rtValue = rtValue.substring(16, 32);
        char Sign = rtValue.charAt(0);
        if(Sign == '0'){
            rtValue = "0000000000000000"+rtValue;
        }else if(Sign == '1'){
            rtValue = "1111111111111111"+rtValue;
        }
        c.registers.get(rd).setData(rtValue);
    }
    
    public void sub(String rs, String rt, String rd){
        int aux = c.registers.get(rs).getData() - c.registers.get(rt).getData();
        c.registers.get(rd).setIntData(aux);
    }
    
    public void subu(String rs, String rt, String rd){
        int aux = c.registers.get(rs).getUnsignedData() - c.registers.get(rt).getUnsignedData();
        c.registers.get(rd).setIntData(aux);
    }
    
    public void and(String rs, String rt, String rd){
        int aux = c.registers.get(rs).getData() & c.registers.get(rt).getData();
        c.registers.get(rd).setIntData(aux);
    
    }
    
    public void andi(String rs, String rt, String imm){
        int aux = c.registers.get(rs).getData() & convertImediate(imm, false);
        
        c.registers.get(rt).setIntData(aux);
    }
    
    public void nor (String rs, String rt, String rd){
        int aux = ~(c.registers.get(rs).getData() | c.registers.get(rt).getData());
        c.registers.get(rd).setIntData(aux);
    }
    
    public void or (String rs, String rt, String rd){
        int aux = (c.registers.get(rs).getData() | c.registers.get(rt).getData());
        System.out.println(c.registers.get(rs).getData() + " | " + c.registers.get(rt).getData()
            + " = " + aux);
        c.registers.get(rd).setIntData(aux);
    }
    /*Auxiliar Functions*/
    private int convertImediate(String imm, boolean unsigned){
        return unsigned? Integer.parseUnsignedInt(imm, 2):Integer.parseInt(imm,2);
    }
}
