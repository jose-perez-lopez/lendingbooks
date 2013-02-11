<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" 
%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"
%><fmt:setBundle basename='lang.text' /><% 
Integer NO_CACHE_VERSION = 1;
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0);
%>
<script type='text/javascript'>
	var SESSION = <%=(session.getAttribute("USER")==null)?"0":"1"%>
</script>