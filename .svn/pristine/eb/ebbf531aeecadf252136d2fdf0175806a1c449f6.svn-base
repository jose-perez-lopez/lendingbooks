package lendingbooks.user;

import java.util.Collection;
import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyService;

public class UserDAO {
		
	static {
		try{
		ObjectifyService.register(User.class);
		}catch(Exception e){
				System.out.println("Error static user manager");
		e.printStackTrace();
		};
	}

			
	public User findByFacebooUid(String p_facebooUid){
		User user = null;					
		Objectify ofy = ObjectifyService.begin();
		user = ofy.query(User.class).filter("facebookUid", p_facebooUid).get();		
		return user;			
	}
	
	
	public Iterable<User> findByFacebookUids(Collection<String> facebookUids){			
		Objectify ofy = ObjectifyService.begin();
		Iterable<User> users = ofy.query(User.class).filter("facebookUid in", facebookUids);		
		return users;	
	}
	
	public User findById(Long p_id){
		User user = null;					
		Objectify ofy = ObjectifyService.begin();
		user = ofy.get(User.class, p_id);
		return user;			
	}
	
	
	public void save(User p_user){
		Objectify ofy = ObjectifyService.begin();
		ofy.put(p_user);
	}

		
}
