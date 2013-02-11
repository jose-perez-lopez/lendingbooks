package lendingbooks.isbn;

import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;

import lendingbooks.book.Book;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class GoogleBooksAPISearch implements BookIsbnSearchInterface {

	//https://www.googleapis.com/books/v1/volumes?q=isbn+9788423427871
	private static String URL_REQUEST = "https://www.googleapis.com/books/v1/volumes?q=isbn+%ISBN%";
	

	public Book findBookByIsbn(String p_isbn) {
		Book book = null; 
		try{
			String requestUrl = URL_REQUEST.replaceAll("%ISBN%", p_isbn);
			String charset = "UTF-8";
			URL url = new URL(requestUrl);		
			Reader reader = new InputStreamReader(url.openStream(), charset);
			JsonParser parser = new JsonParser();
			JsonObject	jsonObject = (JsonObject) parser.parse(reader);
			JsonArray books = jsonObject.getAsJsonArray("items");
			JsonObject bookInfo = null;
			if(books.size()>0){
				book = new Book();
				 bookInfo = ((JsonObject)books.get(0)).getAsJsonObject("volumeInfo");
				 book.setTitle(bookInfo.get("title").getAsString());	
				 book.setAuthorsText(bookInfo.get("authors").getAsString());
				 book.setIsbn(p_isbn);
				 book.setApiOrigin("Google");
			}
		}catch(Exception e){
				System.out.println("Error:"+e.toString() );
		}
		return book;
	}

}
