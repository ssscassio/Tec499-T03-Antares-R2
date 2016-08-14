/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.math.BigInteger;
import java.text.DecimalFormat;

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
        c.registers.get(rd).setIntData(aux);
    }
    
    public void ori(String rs, String rt, String imm){
        int aux = c.registers.get(rs).getData() | convertImediate(imm, false);       
        c.registers.get(rt).setIntData(aux);
    }
    
    public void xor (String rs, String rt, String rd){
        int aux = (c.registers.get(rs).getData() ^ c.registers.get(rt).getData());
        
        c.registers.get(rd).setIntData(aux);
    }
    
    public void xori(String rs, String rt, String imm){
        int aux = c.registers.get(rs).getData() ^ convertImediate(imm, false);  
        c.registers.get(rt).setIntData(aux);
    }
    
    public void div(String rs, String rt){
        c.$LO.setIntData(c.registers.get(rs).getData() / c.registers.get(rt).getData());
        c.$HI.setIntData(c.registers.get(rs).getData() % c.registers.get(rt).getData());
    }
    
    public void divu(String rs, String rt){
        c.$LO.setIntData(c.registers.get(rs).getUnsignedData() / c.registers.get(rt).getUnsignedData());
        c.$HI.setIntData(c.registers.get(rs).getUnsignedData() % c.registers.get(rt).getUnsignedData());
    }
    
    public void madd(String rs, String rt){
        long sum1 = c.registers.get(rs).getData() * c.registers.get(rt).getData();
        String aux2 = c.$HI.getBinaryData() + c.$LO.getBinaryData();
        long sum2 =  Long.parseLong(aux2, 2);
        long data = sum1 + sum2;
        String resultString;
        
        if(data<0){
            resultString = Long.toBinaryString(data);
        }else{
            DecimalFormat df = new DecimalFormat(createPattern(64, '0'));
            String aux = Long.toBinaryString(data);
            resultString = df.format(  new BigInteger(aux) );           
        }
        
        String lo,hi ="";
        hi = resultString.substring(0, 32);
        lo = resultString.substring(32, 64);
        c.$HI.setData(hi);
        c.$LO.setData(lo);
    
    }
    
    public void maddu(String rs, String rt){
        long sum1 = c.registers.get(rs).getUnsignedData() * c.registers.get(rt).getUnsignedData();
        String aux2 = c.$HI.getBinaryData() + c.$LO.getBinaryData();

        long sum2 = 0;
        for(int i = aux2.length() -1; i>0; i--){
            if(aux2.charAt(i) == '1'){
                sum2 += Math.pow(2, 63-i);
            }
        }

        long data = sum1 + sum2;
        String resultString;
        
        if(data<0){
            resultString = Long.toBinaryString(data);
        }else{
            DecimalFormat df = new DecimalFormat(createPattern(64, '0'));
            String aux = Long.toBinaryString(data);
            resultString = df.format(  new BigInteger(aux) );           
        }
        
        String lo,hi ="";
        hi = resultString.substring(0, 32);
        lo = resultString.substring(32, 64);
        c.$HI.setData(hi);
        c.$LO.setData(lo);
    }
    
    public void msub(String rs, String rt){
        long sum1 = c.registers.get(rs).getData() * c.registers.get(rt).getData();
        String aux2 = c.$HI.getBinaryData() + c.$LO.getBinaryData();
        long sum2 =  Long.parseLong(aux2, 2);
        long data = sum2 - sum1;
        String resultString;
        
        if(data<0){
            resultString = Long.toBinaryString(data);
        }else{
            DecimalFormat df = new DecimalFormat(createPattern(64, '0'));
            String aux = Long.toBinaryString(data);
            resultString = df.format(  new BigInteger(aux) );           
        }
        
        String lo,hi ="";
        hi = resultString.substring(0, 32);
        lo = resultString.substring(32, 64);
        c.$HI.setData(hi);
        c.$LO.setData(lo);
    
    }
    
    public void subbu(String rs, String rt){
        long sum1 = c.registers.get(rs).getUnsignedData() * c.registers.get(rt).getUnsignedData();
        String aux2 = c.$HI.getBinaryData() + c.$LO.getBinaryData();

        long sum2 = 0;
        for(int i = aux2.length() -1; i>0; i--){
            if(aux2.charAt(i) == '1'){
                sum2 += Math.pow(2, 63-i);
            }
        }

        long data = sum2 - sum1;
        String resultString;
        
        if(data<0){
            resultString = Long.toBinaryString(data);
        }else{
            DecimalFormat df = new DecimalFormat(createPattern(64, '0'));
            String aux = Long.toBinaryString(data);
            resultString = df.format(  new BigInteger(aux) );           
        }
        
        String lo,hi ="";
        hi = resultString.substring(0, 32);
        lo = resultString.substring(32, 64);
        c.$HI.setData(hi);
        c.$LO.setData(lo);
    }
    
    public void mul(String rs, String rt, String rd){
        long data = c.registers.get(rs).getData() * c.registers.get(rt).getData();
        
        String resultString;
        
        if(data<0){
            resultString = Long.toBinaryString(data);
        }else{
            DecimalFormat df = new DecimalFormat(createPattern(64, '0'));
            String aux = Long.toBinaryString(data);
            resultString = df.format(  new BigInteger(aux) );           
        }
        c.registers.get(rd).setData(resultString.substring(32, 64));
    }
    
    public void mult(String rs, String rt){
        long data = c.registers.get(rs).getData() * c.registers.get(rt).getData();
        String resultString;
        
        if(data<0){
            resultString = Long.toBinaryString(data);
        }else{
            DecimalFormat df = new DecimalFormat(createPattern(64, '0'));
            String aux = Long.toBinaryString(data);
            resultString = df.format(  new BigInteger(aux) );           
        }
        
        String lo,hi ="";
        hi = resultString.substring(0, 32);
        lo = resultString.substring(32, 64);
        c.$HI.setData(hi);
        c.$LO.setData(lo);
    
    }
    
    public void multu(String rs, String rt){
        long data = c.registers.get(rs).getUnsignedData() * c.registers.get(rt).getUnsignedData();
        String resultString;
        
        if(data<0){
            resultString = Long.toBinaryString(data);
        }else{
            DecimalFormat df = new DecimalFormat(createPattern(64, '0'));
            String aux = Long.toBinaryString(data);
            resultString = df.format(  new BigInteger(aux) );           
        }
        
        String lo,hi ="";
        hi = resultString.substring(0, 32);
        lo = resultString.substring(32, 64);
        c.$HI.setData(hi);
        c.$LO.setData(lo);
    
    }
    
    public void rotr(String rt, String rd, String sa){
        int rotrCount = convertImediate(sa, false);
        int data = c.registers.get(rt).getData();
        c.registers.get(rd).setIntData(Integer.rotateRight(data, rotrCount));
    }
    
    public void rotrv(String rs, String rt, String rd){
        String rotation = c.registers.get(rs).getBinaryData();
        rotation = rotation.substring(28, 32);
        int rotrCount = convertImediate(rotation, false);
        int data = c.registers.get(rt).getData();
        c.registers.get(rd).setIntData(Integer.rotateRight(data, rotrCount));
    }
    
    public void sll (String rt, String rd, String sa){
        int shiftCount = convertImediate(sa, false);
        int data = c.registers.get(rt).getData();
        c.registers.get(rd).setIntData(data<<shiftCount);
    }
    
    public void sllv (String rs, String rt, String rd){
        String shift = c.registers.get(rs).getBinaryData();
        shift = shift.substring(28, 32);
        int shiftCount = convertImediate(shift, false);
        int data = c.registers.get(rt).getData();
        c.registers.get(rd).setIntData(data<<shiftCount);
    }
    
    public void sra(String rt, String rd, String sa){
        int shiftCount = convertImediate(sa, false);
        
        int data = c.registers.get(rt).getData();
        c.registers.get(rd).setIntData(data>>shiftCount);
    }
    
    public void srav (String rs, String rt, String rd){
        String shift = c.registers.get(rs).getBinaryData();
        shift = shift.substring(28, 32);
        int shiftCount = convertImediate(shift, false);
        int data = c.registers.get(rt).getData();
        c.registers.get(rd).setIntData(data>>shiftCount);
    }
    
    public void srl(String rt, String rd, String sa){
        int shiftCount = convertImediate(sa, false);
        int data = c.registers.get(rt).getData();
        c.registers.get(rd).setIntData(data>>>shiftCount);
    }
    
    public void srlv (String rs, String rt, String rd){
        String shift = c.registers.get(rs).getBinaryData();
        shift = shift.substring(28, 32);
        int shiftCount = convertImediate(shift, false);
        int data = c.registers.get(rt).getData();
        c.registers.get(rd).setIntData(data>>>shiftCount);
    }
    
    /*Auxiliar Functions*/
    private int convertImediate(String imm, boolean unsigned){
        return unsigned? Integer.parseUnsignedInt(imm, 2):Integer.parseInt(imm,2);
    }
    
    private String createPattern(int count, char c){
        StringBuilder pattern = new StringBuilder();
        for(int i=0; i<count; i++) {
            pattern.append(c);
        }
        return pattern.toString();
    }
}
