package lendingbooks.copy;

import static com.google.appengine.api.taskqueue.TaskOptions.Builder.withUrl;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Id;
import javax.persistence.PostPersist;
import javax.persistence.PrePersist;
import javax.persistence.Transient;
import javax.servlet.http.HttpSession;

import lendingbooks.book.Book;
import lendingbooks.user.User;

import com.google.appengine.api.taskqueue.Queue;
import com.google.appengine.api.taskqueue.QueueFactory;
import com.google.gson.annotations.Expose;
import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Indexed;
import com.googlecode.objectify.annotation.NotSaved;


public class Copy implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	Long id;
	Integer rate;

	String comment;
	Date CreatedTime;
	Date UpdateTime;
	Long idBook;
	Long idUser;

	// Book data
	@Indexed
	String isbn;
	String title;
	String authorsText;

	// User data
	String facebookUid;
	String firstName;
	String lastName;
	
	@SuppressWarnings("unused")
	@PrePersist
	private void onPersist() {
		UpdateTime = new Date();
		if (CreatedTime == null) {
			CreatedTime = UpdateTime;
		}
		Queue queue = QueueFactory.getDefaultQueue();	
		queue.add(withUrl("/resources/user/task/update_copy_last_udate").param("date", UpdateTime.toString()).param("user_id",this.getIdUser().toString()));
	}
	
	public Copy(Book p_book, User p_user) {
		super();
		setIdBook(p_book.getId());
		setIdUser(p_user.getId());
		setIsbn(p_book.getIsbn());
		setTitle(p_book.getTitle());
		setAuthorsText(p_book.getAuthorsText());
		setFacebookUid(p_user.getFacebookUid());
		setFirstName(p_user.getFirstName());
		setLastName(p_user.getLastName());
	}

	public Copy() {
		super();
	}

	public String toString() {
		return "Rate [" + rate + "] Book [" + getIdBook() + "] User ["
				+ getIdUser() + "]";
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}


	public Integer getRate() {
		return rate;
	}

	public void setRate(Integer rate) {
		this.rate = rate;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Date getCreatedTime() {
		return CreatedTime;
	}

	public void setCreatedTime(Date createdTime) {
		CreatedTime = createdTime;
	}

	public Date getUpdateTime() {
		return UpdateTime;
	}

	public void setUpdateTime(Date updateTime) {
		UpdateTime = updateTime;
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

	public void setAuthorsText(String authorsText) {
		this.authorsText = authorsText;
	}

	public String getFacebookUid() {
		return facebookUid;
	}

	public void setFacebookUid(String facebookUid) {
		this.facebookUid = facebookUid;
	}

	public Long getIdBook() {
		return idBook;
	}

	public void setIdBook(Long idBook) {
		this.idBook = idBook;
	}

	public Long getIdUser() {
		return idUser;
	}

	public void setIdUser(Long idUser) {
		this.idUser = idUser;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	
	
	
}
