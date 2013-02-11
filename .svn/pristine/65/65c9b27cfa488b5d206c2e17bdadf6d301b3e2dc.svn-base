package lendingbooks.service.rest.impl;

import javax.ws.rs.FormParam;
import javax.ws.rs.Path;
import javax.ws.rs.GET;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import lendingbooks.book.Book;
import lendingbooks.book.BookManager;

@Path("/book/")
public class BookResource {
	@GET
	@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
	@Path("/isbn/{isbn}")
	public Book getBook(@PathParam("isbn") String p_isbn) {
		BookManager bm = new BookManager();
		Book book = bm.findByIsbn(p_isbn);
		return book;
	}
	
	
}
