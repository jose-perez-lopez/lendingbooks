package lendingbooks.book;

import java.io.Serializable;

import javax.persistence.Id;
import javax.persistence.Transient;

import com.googlecode.objectify.annotation.Indexed;
import com.googlecode.objectify.annotation.NotSaved;

public class Book implements Serializable{
	
	static enum ORIGIN { CACHE, DATASTORE, API };  

	@Id	Long id;		
    @Indexed String isbn;	
	String title;
	String authorsText;
	String apiOrigin;	
	
	@Transient ORIGIN origin;
	
	public Book() {super();}
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuthorsText() {
		return authorsText;
	}

	public void setAuthorsText(String autorsText) {
		this.authorsText = autorsText;
	}

	public String getApiOrigin() {
		return apiOrigin;
	}

	public void setApiOrigin(String apiOrigin) {
		this.apiOrigin = apiOrigin;
	}

	public ORIGIN getOrigin() {
		return origin;
	}

	public void setOrigin(ORIGIN origin) {
		this.origin = origin;
	}
	
	private static final long serialVersionUID = 1L;
	
}
