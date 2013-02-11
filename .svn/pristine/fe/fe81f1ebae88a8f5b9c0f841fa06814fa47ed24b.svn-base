package lendingbooks.service.rest.impl;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.Context;

import lendingbooks.user.User;
import lendingbooks.user.UserManager;

@Path("/user/")
public class UserResource {

	@POST	
	@Path("/fake")
	public void postFakeLogin(@Context HttpServletRequest req) {
		UserManager um = new UserManager();
		HttpSession session = req.getSession(true);
		String facebookId = "736219779";
		User user = um.findOrCreateUserByFacebookUid(facebookId);
		session.setAttribute("USER", user);
	}
	
	@POST
	@Path("/task/update_copy_last_udate")
	public void update(@Context HttpServletRequest req,
			@FormParam("date") 		Date p_lastUpdateDate,
			@FormParam("user_id") Long p_userId){
		UserManager um = new UserManager();
		User user = um.findById(p_userId);
		user.setLastUserCopyUpdate(p_lastUpdateDate);
		um.save(user);
	}
	
}


