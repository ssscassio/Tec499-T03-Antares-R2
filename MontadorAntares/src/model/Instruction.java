package model;

import java.text.DecimalFormat;

/**
 * Created by Wanderson on 31/07/16.
 */
public class Instruction {

    private String mnemonic;
    private String type; // Tipo R, I ou J
    private int numRegis;
    private int numConst;
    private int opCode;
    private int function;

    public Instruction(String mnemonic, String type, int numRegis, int numConst, int opCode, int function){
        this.mnemonic = mnemonic;
        this.type = type;
        this.numRegis = numRegis;
        this.numConst = numConst;
        this.opCode = opCode;
        this.function = function;
    }

    public int getNumRegis(){
        return this.numRegis;
    }
    
    public int getNumConst(){
        return this.numConst;
    }
    
    public String getMnemonic(){
        return this.mnemonic;
    }
    
    public String getType(){
        return this.type;
    }
    
    public String getOpcode(){
        DecimalFormat df = new DecimalFormat("000000");
        String aux = Integer.toBinaryString(this.opCode);
        return df.format(Integer.parseInt(aux.toString()));
    }
    
    public String getFunction(){
        DecimalFormat df = new DecimalFormat("000000");
        String aux = Integer.toBinaryString(this.function);
        return df.format(Integer.parseInt(aux.toString()));
    }
    

}
