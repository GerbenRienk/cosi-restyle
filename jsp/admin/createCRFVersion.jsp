<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setBundle basename="org.akaza.openclinica.i18n.notes" var="restext"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.words" var="resword"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.workflow" var="resworkflow"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.page_messages" var="respage"/>

<c:choose>
	<c:when test="${userBean.sysAdmin && module=='admin'}">
		<c:import url="../include/admin-header.jsp"/>
	</c:when>
	<c:otherwise>
		<c:import url="../include/managestudy-header.jsp"/>
	</c:otherwise>
</c:choose>

<!-- start of admin/createCRFVersion.jsp -->

<!-- move the alert message to the sidebar-->
<jsp:include page="../include/sideAlert.jsp"/>
<!-- then instructions-->

	<tr id="sidebar_Instructions_open" style="display: all">
		<td class="sidebar_tab">
			<a href="javascript:leftnavExpand('sidebar_Instructions_open');	leftnavExpand('sidebar_Instructions_closed');">
            <img src="images/sidebar_collapse.gif" class="sidebar_collapse_expand"></a>
			<b><fmt:message key="instructions" bundle="${resword}"/></b>
			<div class="sidebar_tab_content">
				<b><fmt:message key="create_CRF" bundle="${resword}"/> : </b>
				<fmt:message key="br_create_new_CRF_entering" bundle="${respage}"/><br/><br/>
				<b><fmt:message key="create_CRF_version" bundle="${resword}"/> : </b>
				<fmt:message key="br_create_new_CRF_uploading" bundle="${respage}"/><br/><br/>
				<b><fmt:message key="revise_CRF_version" bundle="${resword}"/> : </b>
				<fmt:message key="br_if_you_owner_CRF_version" bundle="${respage}"/><br/><br/>
				<b><fmt:message key="CRF_spreadsheet_template" bundle="${resword}"/> : </b>
				<fmt:message key="br_download_blank_CRF_spreadsheet_from" bundle="${respage}"/><br/><br/>
				<b><fmt:message key="example_CRF_br_spreadsheets" bundle="${resword}"/> : </b>
				<fmt:message key="br_download_example_CRF_instructions_from" bundle="${respage}"/><br/>		
			</div>
		</td>
	</tr>
	<tr id="sidebar_Instructions_closed" style="display: none">
		<td class="sidebar_tab">
			<a href="javascript:leftnavExpand('sidebar_Instructions_open');	leftnavExpand('sidebar_Instructions_closed');">
            <img src="images/sidebar_expand.gif"></a>
			<b><fmt:message key="instructions" bundle="${resword}"/></b>
		</td>
	</tr>

<jsp:include page="../include/sideInfo.jsp"/>

<jsp:useBean scope='session' id='version' class='org.akaza.openclinica.bean.submit.CRFVersionBean'/>
<jsp:useBean scope='session' id='userBean' class='org.akaza.openclinica.bean.login.UserAccountBean'/>
<jsp:useBean scope='request' id='crfName' class='java.lang.String'/>

<h1><span class="title_manage">
<c:choose>
     <c:when test="${empty crfName}">
         <fmt:message key="create_a_new_CRF_case_report_form" bundle="${resworkflow}"/>
     </c:when>
     <c:otherwise>
        <fmt:message key="create_CRF_version" bundle="${resworkflow}"/> <c:out value="${crfName}"/>
     </c:otherwise>
</c:choose>
</span>
</h1>

<c:if test="${xformEnabled == 'true'}">
 <table>
   <tr>
     <td class="normal_tab"><a href="javascript:toggleSectionDisplay('xlsUpload','xformUpload')"><b><fmt:message key="xls_file_upload" bundle="${resword}"/></b></a></td>
     <td class="normal_tab"><a href="javascript:toggleSectionDisplay('xformUpload','xlsUpload')"><b><fmt:message key="xform_file_upload" bundle="${resword}"/></b></a></td>
   </tr>
 </table>
</c:if>

<div id="xlsUpload" class="crf-upload-div">
	<form action="CreateCRFVersion?action=confirm&crfId=<c:out value="${version.crfId}"/>&name=<c:out value="${version.name}"/>" method="post" ENCTYPE="multipart/form-data">	
		<div class="crf-upload-padded-div">
			<fmt:message key="can_download_blank_CRF_excel" bundle="${restext}"/>
			<a href="DownloadVersionSpreadSheet?template=1"><b><fmt:message key="here" bundle="${resword}"/></b></a>.
		</div>
		
		<div class="crf-upload-padded-div">
		    <p><fmt:message key="openclinica_excel_support" bundle="${restext}"/></p>
		</div>
		
		<div class="textbox_center">
			<table>
				<tr>
					<td class="formlabel">
						<fmt:message key="ms_excel_file_to_upload" bundle="${resword}"/>:
					</td>
					<td>
						<div class="formfieldFile_BG">
							<input type="file" name="excel_file" id="excel_file_path">
						</div>
						<br>
						<jsp:include page="../showMessage.jsp"><jsp:param name="key" value="excel_file"/></jsp:include>
					</td>
				</tr>
			</table>
			<input type="hidden" name="crfId" value="<c:out value="${version.crfId}"/>" >
		</div>
		<br clear="all">
		<table>
			<tr>
				<td>
					<input type="submit" onclick="return submitform();" value="<fmt:message key="preview_CRF_version" bundle="${resword}"/>" class="button_long">
				</td>
				<td>
					<input type="button" onclick="confirmExit('ListCRF?module=<c:out value="${module}"/>')" name="exit" value="<fmt:message key="exit" bundle="${resword}"/>   "class="button_medium"/>
				</td>
			</tr>
		</table>
	</form>
</div>

<c:if test="${xformEnabled == 'true'}">
	<div id="xformUpload" class="crf-upload-div-hidden">
		<form id="xformSubmit" action="CreateXformCRFVersion?action=confirm&crfId=<c:out value="${version.crfId}"/>&name=<c:out value="${version.name}"/>" method="post" ENCTYPE="multipart/form-data">
			<div class="textbox_center">
	        	<table>
	        		<c:if test="${empty CrfId}">
	          			<tr>
	            			<td class="formlabel">
	            				<fmt:message key="CRF_name" bundle="${resword}"/>:
	            			</td>
	            			<td>
	            				<input type="text" id="crfName" name="crfName"/>
	            			</td>
	          			</tr>
	          		</c:if>
					<tr>
						<td class="formlabel">
							<fmt:message key="version_name" bundle="${resword}"/>:
						</td>
						<td>
							<input type="text" id="versionName" name="versionName"/>
						</td>
					</tr>
					<tr>
						<td class="formlabel">
							<fmt:message key="crf_version_description" bundle="${resword}"/>:
						</td>
						<td>
							<input type="text" id="versionDescription" name="versionDescription"/>
						</td>
	          		</tr>
	         		<tr>
	            		<td class="formlabel">
	            			<fmt:message key="revision_notes" bundle="${resword}"/>:
	            		</td>
	            		<td>
	            			<input type="text" id="revisionNotes" name="revisionNotes"/>
	            		</td>
					</tr>
				</table>
			</div>
	        <div class="crf-upload-padded-div">
	        	<textarea class="crf-upload-padded-div" id="xformText" name="xformText" rows="40" cols="60"></textarea>
	        </div>
	        <br>
	        <div class="crf-upload-padded-div"><fmt:message key="xform_upload_media_instruction" bundle="${resword}"/></div>
	        <br>
	        <div class="textbox_center">
		        <table>
		        	<tr>
		            	<td class="formlabel">
		            		<fmt:message key="upload_media_files" bundle="${resword}"/>:
		            	</td>
		            	<td>
		            		<div><input type="file" name="media_file" id="xform_media_file_path" multiple></div>
		            		<br><jsp:include page="../showMessage.jsp"><jsp:param name="key" value="excel_file"/></jsp:include>
		            	</td>
		        	</tr>
		        </table>
			</div>
	        <input type="hidden" name="crfId" value="<c:out value="${version.crfId}"/>">
			<br clear="all">
			<table>
				<tr>
					<td>
						<input type="submit" onclick="return submitXform()" value="<fmt:message key="submit" bundle="${resword}"/>" class="button_medium">
	        		</td>
	        		<td>
	          			<input type="button" onclick="confirmExit('ListCRF?module=<c:out value="${module}"/>')" name="exit" value="<fmt:message key="exit" bundle="${resword}"/>   "class="button_medium"/>
	        		</td>
	      		</tr>
	    	</table>
	    </form>
	</div>
</c:if>

<c:choose>
	<c:when test="${userBean.sysAdmin && module=='admin'}">
		<c:import url="../include/workflow.jsp">
			<c:param name="module" value="admin"/>
		</c:import>
	</c:when>
	<c:otherwise>
		<c:import url="../include/workflow.jsp">
			<c:param name="module" value="manage"/>
		</c:import>
	</c:otherwise>
</c:choose>

<!-- end of admin/createCRFVersion.jsp -->
<jsp:include page="../include/footer.jsp"/>
