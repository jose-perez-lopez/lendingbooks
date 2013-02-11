<%@ page import="lendingbooks.user.*"%>
<%@ page import="lendingbooks.*"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.restfb.*"%>
<%@ page import="com.restfb.util.*"%>
<%@ page import="com.restfb.types.*"%>
<%@ page import="com.igz.facebook.*"%>
<%
	String redirectURL = "/index.jsp";
	UserManager um = new UserManager();
	FacebookRequest fbRequest = FacebookRequest.fromSignedRequest(request.getParameter("signed_request"));
	if(fbRequest!=null) {
		String fbAccessToken = fbRequest.getOauthToken();
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
	}else{
 	 	redirectURL = "https://www.facebook.com/dialog/oauth?client_id=253130971383304" +
                        "&redirect_uri=" + URLEncoder.encode("http://apps.facebook.com/lending-books", "UTF-8") + 
                        "&scope=email";
	}
	response.sendRedirect(redirectURL);
%>








