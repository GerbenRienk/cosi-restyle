<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<!-- start include/showHiddenInput.jsp -->
<jsp:useBean scope='request' id='presetValues' class='java.util.HashMap'/>
<%
String fieldName = request.getParameter("fieldName");
Object fieldValue;

if (presetValues.containsKey(fieldName)) {
	fieldValue = presetValues.get(fieldName);
	%>
<input type="hidden" name="<%= fieldName %>" value="<%= fieldValue.toString() %>" />
	<%
}
%>
<!-- end include/showHiddenInput.jsp -->