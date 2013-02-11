package lendingbooks.user;

import java.util.ArrayList;

import com.restfb.Connection;
import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;

public class UserManager extends UserDAO {

	public User findOrCreateUserByFacebookUid(String p_facebooUid) {
		User user = findByFacebooUid(p_facebooUid);
		if (user == null) {
			user = new User();
			user.setFacebookUid(p_facebooUid);
			save(user);
		}
		return user;
	}
	
	
	public User findOrCreateUserByFacebookUid(User p_user){
		User user = findByFacebooUid(p_user.getFacebookUid());
		if (user == null) {
			user = new User();
			user.setFacebookUid(p_user.getFacebookUid());
			user.setFirstName(p_user.getFirstName());
			user.setLastName(p_user.getLastName());
			save(user);
		}
		return user;
		
	}

	public Iterable<lendingbooks.user.User> getFacebookFriends(
			String p_fb_access_token, String p_facebookId) {
		FacebookClient facebookClient = new DefaultFacebookClient(
				p_fb_access_token);
		ArrayList<String> friendsFacebookIDs = new ArrayList<String>();
		try {
			Connection<com.restfb.types.User> myFriends = facebookClient
					.fetchConnection("me/friends", com.restfb.types.User.class);
			for (com.restfb.types.User friend : myFriends.getData()) {
				friendsFacebookIDs.add(friend.getId());
			}
		} catch (Exception ex) {
			System.err.println("Error getting friends.."+ex.getMessage());
		}
		System.err.println("Friens number"+ friendsFacebookIDs.size());
		
		Iterable<lendingbooks.user.User> friends = (Iterable<lendingbooks.user.User>) findByFacebookUids(friendsFacebookIDs);
		return friends;
	}

}
