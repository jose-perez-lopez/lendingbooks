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
	String CODE = request.getParameter("code");
	if (CODE != null) {
		String url = "https://graph.facebook.com/oauth/access_token?"
		+ "client_id=253130971383304"
		+ "&redirect_uri=http://lending-books.appspot.com/login.facebook.jsp"
		+ "&client_secret=d40803605ad70a7f619eab56a271c5c0"
		+ "&code=" + CODE;
		URL fbTokenURL = new URL(url);
		URLConnection conn = fbTokenURL.openConnection();
		BufferedReader reader = new BufferedReader(
		new InputStreamReader(conn.getInputStream()));
		String fbTokenResponseString = "";
		String inputLine = "";
		while ((inputLine = reader.readLine()) != null) {
	fbTokenResponseString = fbTokenResponseString + inputLine
			+ "\n";
		}
		String fbAccessToken = fbTokenResponseString.split("&")[0]
		.replaceFirst("access_token=", "");
		session.setAttribute("fbAccessToken", fbAccessToken);
		String MY_ACCESS_TOKEN = (String) session
		.getAttribute("fbAccessToken");
		FacebookClient facebookClient = new DefaultFacebookClient(
		MY_ACCESS_TOKEN);
		com.restfb.types.User userFB = facebookClient.fetchObject("me",
		com.restfb.types.User.class);
		String facebookId = userFB.getId();
		lendingbooks.user.User user = new lendingbooks.user.User();
		user.setFacebookUid(facebookId);
		user.setFirstName(userFB.getFirstName());
		user.setLastName(userFB.getLastName());
		
		user = um.findOrCreateUserByFacebookUid(user);
		
		session.setAttribute("USER", user);
	}
	String redirectURL = "/index.jsp";
	response.sendRedirect(redirectURL);
%>
