package lendingbooks.book;

import java.util.List;
import java.util.Map;
import java.util.ServiceLoader;
import lendingbooks.isbn.BookIsbnSearchInterface;
import com.googlecode.objectify.Key;
import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyOpts;
import com.googlecode.objectify.ObjectifyService;

public class BookDAO {
			
	static {
		try {
			ObjectifyService.register(Book.class);
		} catch (Exception ex) {
		}
	}
	
	public Book findByIsbn(String p_isbn){		
		p_isbn = p_isbn.replaceAll( "[^\\d]", "" );
		ObjectifyOpts opts = new ObjectifyOpts().setSessionCache(true);
		Objectify ofy = ObjectifyService.begin(opts);		
		Book book = ofy.query(Book.class).filter("isbn", p_isbn).get();										
		if(book!=null){			
			book.origin = Book.ORIGIN.DATASTORE;
			return book;
		}				
		ServiceLoader<BookIsbnSearchInterface> serviceLoader = ServiceLoader.load(lendingbooks.isbn.BookIsbnSearchInterface.class);		
		for(BookIsbnSearchInterface servicio: serviceLoader){
			book = servicio.findBookByIsbn(p_isbn);
			if(book!=null){												
				ofy.put(book);	
				book.origin = Book.ORIGIN.API;
				return book;
			}
		}		
		return book;			
	}
		
	public void save(Book book){
		Objectify ofy = ObjectifyService.begin();
		ofy.put(book);		
	}
	
	public Map<Key<Book>, Book> findByKeys(List<Key<Book>> p_booksKeys ){
		Objectify ofy = ObjectifyService.begin();
		Map<Key<Book>, Book> books = ofy.get(p_booksKeys);
		return books;			
	}
	
	public Book find(Long p_bookId){
		Objectify ofy = ObjectifyService.begin();
		return ofy.get(Book.class,p_bookId);
	}
}
