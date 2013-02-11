package lendingbooks.copy;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import lendingbooks.book.Book;
import lendingbooks.user.User;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyOpts;
import com.googlecode.objectify.ObjectifyService;

public class CopyDAO {

	static {
		try {
			ObjectifyService.register(Copy.class);
		} catch (Exception ex) {
		}
		try {
			ObjectifyService.register(Book.class);
		} catch (Exception ex) {
		}
		try {
			ObjectifyService.register(User.class);
		} catch (Exception ex) {
		}

	}

	public void save(Copy copy) {
		Objectify ofy = ObjectifyService.begin();
		ofy.put(copy);
	}

	public Copy find(Long id){
		Objectify ofy = ObjectifyService.begin();
		return (Copy) ofy.get(new Key<Object>(Copy.class, id));
	}
	public Copy findByBookAndUser(Copy p_copy) {
		Objectify ofy = ObjectifyService.begin();
		Copy copy = ofy.query(Copy.class).filter("idUser", p_copy.getIdUser())
				.filter("idBook", p_copy.getIdBook()).get();
		return copy;
	}

	public void delete(Long id) {
		Objectify ofy = ObjectifyService.begin();
		Copy copy = (Copy) ofy.get(new Key<Object>(Copy.class, id));
		ofy.delete(copy);
	}
	
	

	public List<Copy> listFindByUserId(Long p_userId) {
		ObjectifyOpts opts = new ObjectifyOpts().setSessionCache(true);
		Objectify ofy = ObjectifyService.begin(opts);
		Iterable<Copy> copys = ofy.query(Copy.class).filter("idUser", p_userId);
		ArrayList<Copy> list = new ArrayList<Copy>();
		Iterator<Copy> it = copys.iterator();
		while (it.hasNext()) {
			Copy copy = it.next();
			list.add(copy);
		}
		return list;
	}
}
