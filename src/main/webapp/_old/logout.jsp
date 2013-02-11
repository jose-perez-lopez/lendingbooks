<%@ include file="global.jsp"%>
<%
	if (session != null) {

		session.invalidate();
	}
response.sendRedirect("/");
%>