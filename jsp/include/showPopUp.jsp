<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- start include/showPopUp.jsp -->
<jsp:useBean scope='request' id='popUpURL' class='java.lang.String'/>

<c:choose>
	<c:when test='${popUpURL != ""}'>
		openDNoteWindow('<c:out value="${popUpURL}" />');
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>
<!-- end include/showPopUp.jsp -->