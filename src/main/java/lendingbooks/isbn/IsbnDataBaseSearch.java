package lendingbooks.isbn;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import lendingbooks.book.Book;


/**
 * http://isbndb.com/docs/api/
 * La key de acceso esta asociada a la cuenta jose.perez@intelygenz.com
 * 
 * 
 * <?xml version="1.0" encoding="UTF-8"?>
 * <ISBNdb server_time="2005-02-25T23:03:41">
 * <BookList total_results="1" page_size="10" page_number="1" shown_results="1">
 *   <BookData book_id="somebook" isbn="0123456789">
 *    <Title>Interesting Book</Title>
 *    <TitleLong>Interesting Book: Read it or else..</TitleLong>
 *    <AuthorsText>John Doe</AuthorsText>
 *    <PublisherText>Acme Publishing</PublisherText>
 *   </BookData>
 *  </BookList>
 * </ISBNdb>
 * 
 */

public class IsbnDataBaseSearch implements BookIsbnSearchInterface {

	private static String URL_REQUEST = "http://isbndb.com/api/books.xml?access_key=L9ODATBN&index1=isbn&value1=%ISBN%";
	
	
	//TODO controlar java.net.SocketTimeoutException
	
	
	public Book findBookByIsbn(String p_isbn) {			
		InputStream is = null;	
		Book book = null;		
		try {
			String requestUrl = URL_REQUEST.replaceAll("%ISBN%", p_isbn);	
			DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder documentBuilder = documentBuilderFactory.newDocumentBuilder();
			URL url = new URL(requestUrl);
			is = url.openStream();
			Document doc = documentBuilder.parse(is);	
			doc.getDocumentElement ().normalize ();
			XPathFactory  xFactory = XPathFactory.newInstance();
			XPath xpath = xFactory.newXPath();
			XPathExpression  expr = xpath.compile("//BookData");			
			NodeList booksNodes = (NodeList) expr.evaluate(doc, XPathConstants.NODESET);
			if(booksNodes.getLength()>0){			
				Node bookNode = ((Node)(booksNodes.item(0)));				
				NodeList bookData = bookNode.getChildNodes();	
				book = new Book();
				book.setIsbn(p_isbn);
				book.setApiOrigin("IsbnDataBase");
				for (int j=0; j<bookData.getLength();j++){					
					Node dataNode = bookData.item(j);		
					if(dataNode.getNodeType() == Node.ELEMENT_NODE){
						if(dataNode.getNodeName() == "Title"){
							book.setTitle(dataNode.getTextContent());
						}else if(dataNode.getNodeName() == "AuthorsText"){
							book.setAuthorsText(dataNode.getTextContent());
						}						
					}
					//TODO Get more data from book
				}				
			}				           
			return book;			
		} catch (Exception e) { 
			System.out.println("ERROR");
			e.printStackTrace();
		}finally{
			try {is.close();} catch (IOException e) {}
		}
		return null;
	}
	
	

}
