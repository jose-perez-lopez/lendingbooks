<%@ page import="lendingbooks.user.*"%>
<%@ page import="lendingbooks.*"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.restfb.*"%>
<%@ page import="com.restfb.util.*"%>
<%@ page import="com.restfb.types.*"%>
<%
	UserManager um = new UserManager();
	String fbAccessToken = request.getParameter("fbAccessToken");
	String fbUserId = request.getParameter("fbUserId");
	session.setAttribute("fbAccessToken", fbAccessToken);
	String MY_ACCESS_TOKEN = (String) session.getAttribute("fbAccessToken");
	FacebookClient facebookClient = new DefaultFacebookClient(MY_ACCESS_TOKEN);
	com.restfb.types.User userFB = facebookClient.fetchObject("me",com.restfb.types.User.class);
	String facebookId = userFB.getId();
	lendingbooks.user.User user = new lendingbooks.user.User();
	user.setFacebookUid(facebookId);
	user.setFirstName(userFB.getFirstName());
	user.setLastName(userFB.getLastName());	
	user = um.findOrCreateUserByFacebookUid(user);
	session.setAttribute("USER", user);
%>
{"Response":"OK"}