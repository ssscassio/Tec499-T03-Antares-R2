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
    private int adress;
    
    public Label(String label, int adress){
        this.label =label;
        this.adress = adress;
    }
    
    public String getLabelName(){
        return this.label;
    }
}
