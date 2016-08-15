/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package config;

/**
 *
 * @author ssscassio
 */
public class DefaultConfig {
   
    public final String REGISTER_SET_FILE = "register_set.txt";
    public final String INSTRUCTION_SET_FILE = "instruction_set.txt";
    
    //Single Instance
    private static DefaultConfig config = null;
    
    private DefaultConfig() {
		
    }
    
    public static DefaultConfig getInstance() {
		if (config == null) config = new DefaultConfig();
		return config;
    }
}
