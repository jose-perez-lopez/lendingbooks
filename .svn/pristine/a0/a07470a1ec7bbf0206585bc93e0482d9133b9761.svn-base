package lendingbooks.user;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Id;

public class User implements Serializable{

	@Id		
	private Long id;			
	private String facebookUid; 
	private String firstName;
	private String lastName;
	
	private Date lastUserCopyUpdate;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getFacebookUid() {
		return facebookUid;
	}

	public void setFacebookUid(String facebookUid) {
		this.facebookUid = facebookUid;
	}
	
	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public Date getLastUserCopyUpdate() {
		return lastUserCopyUpdate;
	}

	public void setLastUserCopyUpdate(Date lastUserCopyUpdate) {
		this.lastUserCopyUpdate = lastUserCopyUpdate;
	}

	private static final long serialVersionUID = 1L;
		
}
