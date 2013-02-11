package lendingbooks.service.rest.impl;

import static com.google.appengine.api.taskqueue.TaskOptions.Builder.withUrl;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.DELETE;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import com.google.appengine.api.taskqueue.Queue;
import com.google.appengine.api.taskqueue.QueueFactory;

import lendingbooks.book.Book;
import lendingbooks.book.BookManager;
import lendingbooks.copy.Copy;
import lendingbooks.copy.CopyManager;
import lendingbooks.user.User;
import lendingbooks.user.UserManager;
import java.util.logging.Logger;

@Path("/copy/")
public class CopyResource {
	
	@GET
	@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
	@Path("/user/")
	public List<Copy> getCopyList(@Context HttpServletRequest req) {
		HttpSession session = req.getSession(true);
		User user = (User) session.getAttribute("USER");
		CopyManager cm = new CopyManager();
		return cm.listFindByUserId(user.getId());
	}
	
	@GET
	@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
	@Path("/user/friends")
	public List<Copy> getFriendsCopyList(@Context HttpServletRequest req) {
		HttpSession session = req.getSession(true);
		String MY_ACCESS_TOKEN = (String) session.getAttribute("fbAccessToken");
		User user = (User) session.getAttribute("USER");
		CopyManager cm = new CopyManager();
		UserManager um = new UserManager();
		Iterable<User> friends = um.getFacebookFriends(MY_ACCESS_TOKEN, user.getFacebookUid());
		if(friends.iterator().hasNext())
			return cm.listFindByUsers(friends);
		else 
			return new ArrayList<Copy>();
	}

	@PUT
	@Path("/book")
	public void putCopy(@Context HttpServletRequest req,
			@FormParam("book_id") Long p_bookId) {
		BookManager bm = new BookManager();
		CopyManager cm = new CopyManager();
		HttpSession session = req.getSession(true);
		User user = (User) session.getAttribute("USER");
		Book book = bm.find(p_bookId);
		Copy copy = new Copy(book,user);
		cm.create(copy);
	}
	
	@PUT
	@Path("/book/whenever")
	public void putWheneveCopy(@Context HttpServletRequest req,
			@FormParam("isbn") String p_isbn) {
		HttpSession session = req.getSession(true);
		User user = (User) session.getAttribute("USER");
		Queue queue = QueueFactory.getDefaultQueue();	
		queue.add(withUrl("/resources/copy/task").param("isbn", p_isbn).param("user_id",user.getId().toString()));
	}
	
	@POST
	@Path("/task")
	public void put(@Context HttpServletRequest req,
			@FormParam("isbn") String p_isbn,
			@FormParam("user_id") Long p_userId) {
		BookManager bm = new BookManager();
		CopyManager cm = new CopyManager();
		UserManager um = new UserManager();
		Book book = bm.findByIsbn(p_isbn);
		User user = um.findById(p_userId);
		Copy copy = new Copy(book,user);
		cm.create(copy);
	}
	
	@POST
	@Path("/rate")
	public void rateCopy(@Context HttpServletRequest req,
			@FormParam("copy_id") Long p_copyId,
			@FormParam("rate") Integer p_rate) {
		
		CopyManager cm = new CopyManager();
		HttpSession session = req.getSession(true);
		User user = (User) session.getAttribute("USER");		
		Copy copy = cm.find(p_copyId);
		if(user==null || !user.getId().equals(copy.getIdUser())){
			System.err.println("user["+user+"] ["+(user==null)+"] ["+(user.getId().equals(copy.getIdUser()) )+"]");
			try{
				System.err.println("user.getId()["+user.getId()+"] ");
			}catch(Exception e){
				System.err.println("user.getId() ERROR ["+e.getMessage()+"] ");
			}
			System.err.println("copy.getIdUser()["+copy.getIdUser()+"] ");
			throw new WebApplicationException(403);
		}
		copy.setRate(p_rate);
		cm.save(copy);
	}
	

	@DELETE
	@Path("/{copy_id}")
	public void deleteCopy(@Context HttpServletRequest req,
			@PathParam("copy_id") Long p_copyId) {
		
		System.err.println("copy.deleteCopy()["+p_copyId+"] ");
		//TODO verify who is the user, if the user in session is not the copy owner 403
		CopyManager cm = new CopyManager();
		HttpSession session = req.getSession(true);
		User user = (User) session.getAttribute("USER");
		Copy copy = cm.find(p_copyId);
		/**if(user==null || user.getId()!=copy.getIdUser()){
			throw new WebApplicationException(403);
		}**/
		cm.delete(p_copyId);
	}
}
