package model;

/**
 * Created by Wanderson on 31/07/16.
 */
public class Instruction {

    private String type; // Tipo R, I ou J
    private int opcode;
    private String mnemonic;
    private int function;

    public Instruction(){}

    public int getOpcode() {
        return this.opcode;
    }
    
    public String getMnemonic(){
        return this.mnemonic;
    }
    
    public int getFunction(){
        return this.function;
    }
    

}
