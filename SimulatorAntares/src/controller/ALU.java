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
    
    /* ArithMetics Functions */
    
    public void add(String rs, String rt, String rd){
        int aux =  c.registers.get(rs).getData() +  c.registers.get(rt).getData();
        c.registers.get(rd).setIntData(aux);
    }
    
    public void addi(String rs, String rd, String imm){
        if(imm.charAt(0) =='1'){
            imm = createPattern(16, '1') + imm;
        }
        int bin = this.convertImediate(imm, false);
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
    
    public void seb(String rd, String rt){
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
    
    public void seh(String rd, String rt){
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
    
    /* Logic Functions */
    
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
    
    /* Div and Mult Functions */
    
    public void div(String rs, String rt){
        c.LO.setIntData(c.registers.get(rs).getData() / c.registers.get(rt).getData());
        c.HI.setIntData(c.registers.get(rs).getData() % c.registers.get(rt).getData());
    }
    
    public void divu(String rs, String rt){
        c.LO.setIntData(c.registers.get(rs).getUnsignedData() / c.registers.get(rt).getUnsignedData());
        c.HI.setIntData(c.registers.get(rs).getUnsignedData() % c.registers.get(rt).getUnsignedData());
    }
    
    public void madd(String rs, String rt){
        long sum1 = c.registers.get(rs).getData() * c.registers.get(rt).getData();
        String aux2 = c.HI.getBinaryData() + c.LO.getBinaryData();
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
        c.HI.setData(hi);
        c.HI.setData(lo);
    
    }
    
    public void maddu(String rs, String rt){
        long sum1 = c.registers.get(rs).getUnsignedData() * c.registers.get(rt).getUnsignedData();
        String aux2 = c.HI.getBinaryData() + c.LO.getBinaryData();

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
        c.HI.setData(hi);
        c.LO.setData(lo);
    }
    
    public void msub(String rs, String rt){
        long sum1 = c.registers.get(rs).getData() * c.registers.get(rt).getData();
        String aux2 = c.HI.getBinaryData() + c.LO.getBinaryData();
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
        c.HI.setData(hi);
        c.LO.setData(lo);
    
    }
    
    public void msubu(String rs, String rt){
        long sum1 = c.registers.get(rs).getUnsignedData() * c.registers.get(rt).getUnsignedData();
        String aux2 = c.HI.getBinaryData() + c.LO.getBinaryData();

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
        c.HI.setData(hi);
        c.LO.setData(lo);
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
        c.LO.setData(resultString.substring(32, 64));
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
        c.HI.setData(hi);
        c.LO.setData(lo);
    
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
        c.HI.setData(hi);
        c.LO.setData(lo);
    
    }
    
    /* Shift Functions */
    
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
    
    /* Branch and Jump Functions */
    
    public void beq(String rs, String rt, String offset){
        if(offset.charAt(0) =='1'){
            offset = createPattern(16, '1') + offset;
        }
        int aux = convertImediate(offset, false);
        aux = aux <<2;
        if(c.registers.get(rs).getBinaryData().equals(c.registers.get(rt).getBinaryData())){
            c.PC.setIntData(c.PC.getData() + aux);
        }
    }
    
    public void bne(String rs, String rt, String offset){
        if(offset.charAt(0) =='1'){
            offset = createPattern(16, '1') + offset;
        }
        int aux = convertImediate(offset, false);
        aux = aux <<2;
        if(!c.registers.get(rs).getBinaryData().equals(c.registers.get(rt).getBinaryData())){
            c.PC.setIntData(c.PC.getData() + aux);
        }
    }
    
    public void j(String target){
        String aux = c.PC.getBinaryData().substring(0,4) + target + "00";
        c.PC.setData(aux);
    }
    
    public void jal(String target){
       c.registers.get("11111").setIntData(c.PC.getData());
       String aux2 = c.PC.getBinaryData().substring(0,4) + target + "00";
       c.PC.setData(aux2); 
    }
    
    public void jalr(String rs, String rd){
        c.registers.get(rd).setIntData(c.PC.getData() + 8 );
        c.PC.setData(c.registers.get(rs).getBinaryData()); 
    }
    
    public void jr(String rs){
        c.PC.setData(c.registers.get(rs).getBinaryData()); 
    }
    
    /* Conditional Functions */
    
    public void movn(String rs, String rt, String rd){
        if(c.registers.get(rt).getData() != 0){
            c.registers.get(rd).setData(c.registers.get(rs).getBinaryData());
        }
    }
    
    public void movz(String rs, String rt, String rd){
        if(c.registers.get(rt).getData() == 0){
            c.registers.get(rd).setData(c.registers.get(rs).getBinaryData());
        }
    }
    
    public void slt(String rs, String rt, String rd){
        if(c.registers.get(rs).getData() < c.registers.get(rt).getData()){
            c.registers.get(rd).setIntData(1);
        }else{
            c.registers.get(rd).setIntData(0);
        }
    }
    
    public void slti(String rs, String rt, String imm){
        if(imm.charAt(0) =='1'){
            imm = createPattern(16, '1') + imm;
        }
        int aux = convertImediate(imm, false);
        if(c.registers.get(rs).getData() < aux){
            c.registers.get(rt).setIntData(1);
        }else{
            c.registers.get(rt).setIntData(0);
        }
    }
    
    public void sltiu(String rs, String rt, String imm){
        if(imm.charAt(0) =='1'){
            imm = createPattern(16, '1') + imm;
        }
        int aux = convertImediate(imm, false);
        if(c.registers.get(rs).getUnsignedData() < aux){
            c.registers.get(rt).setIntData(1);
        }else{
            c.registers.get(rt).setIntData(0);
        }
    }
    
    public void sltu(String rs, String rt, String rd){
        if(c.registers.get(rs).getUnsignedData() < c.registers.get(rt).getUnsignedData()){
            c.registers.get(rd).setIntData(1);
        }else{
            c.registers.get(rd).setIntData(0);
        }
    }
    
    /* Acc Access Functions*/
    
    public void mfhi(String rd){
        c.registers.get(rd).setData(c.HI.getBinaryData());
    }
    
    public void mflo(String rd){
        c.registers.get(rd).setData(c.LO.getBinaryData());
    }
    
    public void mthi(String rs){
         c.HI.setData(c.registers.get(rs).getBinaryData());     
    }
    
    public void mtlo(String rs){
         c.LO.setData(c.registers.get(rs).getBinaryData());     
    }
    
    /* Load and Store Functions*/
    
    public void lw(String base, String rt, String offset){
        if(offset.charAt(0) =='1'){
            offset = createPattern(16, '1') + offset;
        }
        int aux = convertImediate(offset, false);

        int aux2 = c.registers.get(base).getData() + aux;  // Base + offset
        c.registers.get(rt).setData(c.memory[aux2/4].getData());
        
    }
    
    public void lh(String base, String rt, String offset){
        if(offset.charAt(0) =='1'){
            offset = createPattern(16, '1') + offset;
        }
        int aux = convertImediate(offset, false);

        int aux2 = c.registers.get(base).getData() + aux;  // Base + offset
        String aux3 = c.memory[aux2/4].getData();
        aux3 = aux3.substring(16,32);
        if(aux3.charAt(0) =='1'){
            aux3 = createPattern(16, '1') + aux3;
        }
        c.registers.get(rt).setData(aux3);       
    }
    
    public void lb(String base, String rt, String offset){
        if(offset.charAt(0) =='1'){
            offset = createPattern(16, '1') + offset;
        }
        int aux = convertImediate(offset, false);

        int aux2 = c.registers.get(base).getData() + aux;  // Base + offset
        String aux3 = c.memory[aux2/4].getData();
        aux3 = aux3.substring(24,32);
        if(aux3.charAt(0) =='1'){
            aux3 = createPattern(24, '1') + aux3;
        }
        c.registers.get(rt).setData(aux3);       
    }
    
    public void sw(String base, String rt, String offset){
        if(offset.charAt(0) =='1'){
            offset = createPattern(16, '1') + offset;
        }
        int aux = convertImediate(offset, false);
        int aux2 = c.registers.get(base).getData() + aux;  // Base + offset
        c.memory[aux2/4].setData(c.registers.get(rt).getBinaryData());
        
    }
    
    public void sh(String base, String rt, String offset){
        if(offset.charAt(0) =='1'){
            offset = createPattern(16, '1') + offset;
        }
        int aux = convertImediate(offset, false);
        int aux2 = c.registers.get(base).getData() + aux;  // Base + offset
        
        String aux3 = c.registers.get(rt).getBinaryData();
        aux3 = aux3.substring(16,32);
        if(aux3.charAt(0) =='1'){
            aux3 = createPattern(16, '1') + aux3;
        }
        
        c.memory[aux2/4].setData(aux3);    
    }
    
    public void sb(String base, String rt, String offset){
        if(offset.charAt(0) =='1'){
            offset = createPattern(16, '1') + offset;
        }
        int aux = convertImediate(offset, false);
        int aux2 = c.registers.get(base).getData() + aux;  // Base + offset
        
        String aux3 = c.registers.get(rt).getBinaryData();
        aux3 = aux3.substring(24,32);
        if(aux3.charAt(0) =='1'){
            aux3 = createPattern(24, '1') + aux3;
        }
        
        c.memory[aux2/4].setData(aux3);    
    }
    
    /*Auxiliar Functions*/
    private int convertImediate(String imm, boolean unsigned){
        return unsigned? (int) Long.parseUnsignedLong(imm, 2):(int) Long.parseLong(imm, 2);
    }
    
    private String createPattern(int count, char c){
        StringBuilder pattern = new StringBuilder();
        for(int i=0; i<count; i++) {
            pattern.append(c);
        }
        return pattern.toString();
    }
}