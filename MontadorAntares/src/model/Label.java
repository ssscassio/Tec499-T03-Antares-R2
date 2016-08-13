/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author ssscassio
 */
public class Label {
    private String label;
    private int address;
    
    public Label(String label, int address){
        this.label =label;
        this.address = address;
    }
    
    public String getLabelName(){
        return this.label;
    }

<<<<<<< HEAD
    public int getAddress() {
        return address;
    }

    public void setAddress(int adress) {
        this.address = adress;
    }
    
    
=======
>>>>>>> origin/master
}
