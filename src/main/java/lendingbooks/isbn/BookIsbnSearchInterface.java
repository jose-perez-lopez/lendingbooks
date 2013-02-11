package lendingbooks.isbn;

import lendingbooks.book.*;

public interface BookIsbnSearchInterface {	
	
	public Book findBookByIsbn(String p_isbn);
	
}
