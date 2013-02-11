package lendingbooks.copy;

import static com.google.appengine.api.taskqueue.TaskOptions.Builder.withUrl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.google.appengine.api.taskqueue.Queue;
import com.google.appengine.api.taskqueue.QueueFactory;

import lendingbooks.user.User;

public class CopyManager extends CopyDAO {

	public  void create(Copy p_copy){		
		if(!alreadyExistsForUserAndBook(p_copy)){
			save(p_copy);
		}
	}
	
	public boolean alreadyExistsForUserAndBook(Copy p_copy){
		return (findByBookAndUser(p_copy)!=null);		
	}
	
	public List<Copy> listFindByUsers(Iterable<User> users) {
		ArrayList<Copy> copys = new ArrayList<Copy>();
		Iterator<User> it = users.iterator();
		while (it.hasNext()) {
			User user = (User) it.next();
			copys.addAll(listFindByUserId(user.getId()));
		}
		return copys;
	}
	
	
}
