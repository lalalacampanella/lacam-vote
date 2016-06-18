package test;

import java.io.Serializable;

public class Record implements Serializable {
    public String name;  
    public int record;  	
  
    public Record() {  
        // do nothing  
    }

	public Record( String name, int record) {
		this.name = name;
		this.record = record;
	}  
}
