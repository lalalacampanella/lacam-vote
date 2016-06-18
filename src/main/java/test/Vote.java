package test;
import java.util.Vector;

public class Vote {
	public int id;
    public String title;
    public String text;
    public String start_time;
    public String end_time;
    public String joiner;
    public Boolean haveVote;
    public Vector<Joiner> joiners;

    public Vote() {
        // do nothing
    }
    public Vote(int id, String title, String text){
    	this.id = id;
    	this.title = title;
    	this.text = text;
    }

}