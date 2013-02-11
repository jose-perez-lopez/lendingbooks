package lendingbooks.user;

import com.google.appengine.api.users.*;

public class Facebook {

	
	public void connect(){
		 UserService userService = UserServiceFactory.getUserService();
		 userService.getCurrentUser().getUserId();
		
	}
}
