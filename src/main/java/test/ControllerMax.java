package test;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.StringTokenizer;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class ControllerMax {
    @RequestMapping(value="/")
    public ModelAndView in(){
        ModelAndView mv = new ModelAndView("/index","command","LOGIN SUCCESS, ");
        return mv;
    }

    @RequestMapping(value = "/uploadVote", method = RequestMethod.POST)
        public @ResponseBody
        result uploadVotePost(@RequestBody Vote vote) throws SQLException {
    	
    	java.sql.Date start_date = null;
    	java.sql.Date end_date = null;
    	SimpleDateFormat bartDateFormat =  new SimpleDateFormat("yyyy-MM-dd");  
    	try {  
            java.util.Date date1 = bartDateFormat.parse(vote.start_time);  
            java.util.Date date2 = bartDateFormat.parse(vote.end_time);  
            start_date = new java.sql.Date(date1.getTime());
            end_date = new java.sql.Date(date2.getTime());
           }  
           catch (Exception ex) {  
            System.out.println(ex.getMessage());  
            return new result("fail");
           }
    	db_connect connector = new db_connect();
    	String action1 = "insert into vote (title, text, start_time, end_time) values ('"+ vote.title +"' , '"+ vote.text +"' , '"+ start_date +"' , '"+ end_date +"');";
    	int vote_id = -1;
    	try{
            	vote_id = connector.db_insert(action1);
        }catch(Exception e){
            System.out.println("failed!");
            e.printStackTrace();
        }   
    	
    	String[] joiners = vote.joiner.split(",");
        for (int i = 0; i < joiners.length; i++){
        	String action2 = "insert into joiner (vote_id, name) values ('"+ vote_id +"','"+ joiners[i] +"');";
        	try{
            	connector.db_insert(action2);
        	}catch(Exception e){
            System.out.println("failed!");        
            e.printStackTrace();
            return new result("fail");
        	}   
        }
            connector.db_close();
            return new result("success");
        }


    @RequestMapping( value = "/getVote", method = RequestMethod.GET )
    public @ResponseBody
    Vector<Vote> getVote() {
	db_connect connector = new db_connect();
	HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
	String ip="";
	try {
		ip = getIpAddr(request);
	} catch (Exception e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	}
    String action = "select * from vote where start_time <= CURDATE() and end_time >= CURDATE() ;";
    ResultSet rs = connector.db_query(action);
    Vector<Vote> allVote = new Vector<Vote>();
    try{
    	while( rs.next() ) {
    		Vote vote = new Vote(rs.getInt("id"),rs.getString("title"),rs.getString("text"));		
    		allVote.add(vote);
    	}
    }catch(SQLException se){
        System.out.println("sql failed!");
        se.printStackTrace();
    }catch(Exception e){
        System.out.println("failed!");
        e.printStackTrace();
    }
    try{
    	for (int i = 0; i < allVote.size(); i++) {
    		String action2 = "select * from joiner where vote_id = "+allVote.get(i).id+";";
    		ResultSet rs2 = connector.db_query(action2);
    		Vector<Joiner> joiners = new Vector<Joiner>();
        	while( rs2.next() ) {
        		Joiner joiner = new Joiner(rs2.getInt("id"),rs2.getString("name"),rs2.getInt("number"));
        		joiners.add(joiner);
        	}
        	String action3 = "select * from voter where ip = '"+ ip +"' and vote_id = '"+ allVote.get(i).id +"';";
    		ResultSet rs3 = connector.db_query(action3);
    		if (rs3.next()==false) {
    			allVote.get(i).haveVote = false;
        	}
    		else {
    			allVote.get(i).haveVote = true;
    		}
        	allVote.get(i).joiners = joiners;
    	}
    	
    }catch(SQLException se){
        System.out.println("sql failed!");
        se.printStackTrace();
    }catch(Exception e){
        System.out.println("failed!");
        e.printStackTrace();
    }
    
    connector.db_close();
		return allVote;
}
    @RequestMapping(value = "/voteFor", method = RequestMethod.POST)
    public @ResponseBody
    result votePost(@RequestBody Push push) throws SQLException {
	db_connect connector = new db_connect();
	HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
	String ip="";
	try {
		ip = getIpAddr(request);
	} catch (Exception e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	}
	System.out.println(ip);
	String action1 = "select * from voter where ip = '"+ ip +"';";
	try{
        	ResultSet rs1 = connector.db_query(action1);
        	if (rs1.next()==false) {
        		String action2 = "insert into voter (vote_id, joiner_id, ip) values ( "+ push.vote_id +","+ push.joiner_id +",'"+ ip +"' );";
        		String action3 = "update joiner set number = number + 1 where id="+ push.joiner_id +";";
        		connector.db_insert(action2);
        		connector.db_insert(action3);
        	}
        	else {
        		return new result("fail");
        	}
    }catch(Exception e){
        System.out.println("failed!");
        e.printStackTrace();
    }  
        connector.db_close();
        return new result("success");
    }
    
    public static String getIpAddr(HttpServletRequest request) throws Exception{
    	String ip = request.getHeader("X-Real-IP");
    	if (!StringUtils.isBlank(ip) && !"unknown".equalsIgnoreCase(ip)) {
    	return ip;
    	}
    	ip = request.getHeader("X-Forwarded-For");
    	if (!StringUtils.isBlank(ip) && !"unknown".equalsIgnoreCase(ip)) {
    	int index = ip.indexOf(',');
    	if (index != -1) {
    	return ip.substring(0, index);
    	} else {
    	return ip;
    	}
    	} else {
    	return request.getRemoteAddr();
    	}
    	}

    @RequestMapping(value = "/moreJoiner", method = RequestMethod.POST)
    public @ResponseBody
    result moreJoiner(@RequestBody Push push) throws SQLException {
	db_connect connector = new db_connect();
	String[] joiners = push.joiner_id.split(",");
    for (int i = 0; i < joiners.length; i++){
    	String action2 = "insert into joiner (vote_id, name) values ('"+ push.vote_id +"','"+ joiners[i] +"');";
    	try{
        	connector.db_insert(action2);
    	}catch(Exception e){
        System.out.println("failed!");        
        e.printStackTrace();
        return new result("fail");
    	}   
    }
        connector.db_close();
        return new result("success");
    }


}
