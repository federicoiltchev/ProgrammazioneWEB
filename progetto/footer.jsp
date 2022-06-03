<!DOCTYPE html>
<html lang="en">

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


    <%  

        String lang = (String)session.getAttribute("language"); 

        if (lang == null)
        {
            lang = "it";
        }

    %>

    <fmt:setLocale value="<%= lang %>" />
    <fmt:setBundle basename="text" />


<body>
    <footer>
        <div class="container">
        <div class="row">
            <div class="col-md-3">
            <h5><fmt:message key="footer.navigazione.title" /></h5>
            <ul>
                <li><a href="index.jsp">Homepage</a></li>
                <li><a href="forum.jsp">Forum</a></li>

                <%
                    if (session.getAttribute("session_exists") != null)
                    {
                %>
                        <li><a href="profile.jsp?user=<%= session.getAttribute("username") %>"><fmt:message key="footer.navigazione.profilo" /></a></li>
                <%
                    }
                    else
                    {
                %>
                        <li><a href="login.jsp"><fmt:message key="footer.navigazione.profilo" /></a></li>
                <%
                    }
                %>
                <li><a href="relazione.pdf"><fmt:message key="footer.navigazione.relazione" /></a></li>
            </ul>
            </div>
            <div class="col-md-3">
            <h5><fmt:message key="footer.informazioni.title" /></h5>
            <p><fmt:message key="footer.informazioni.esame" /></p>
            <p><fmt:message key="footer.informazioni.facolta" /></p>
            <p><fmt:message key="footer.informazioni.professore" /></p>
            </div>
        </div> 
        <div class="divider"></div>
        <div class="row">
            <div class="col-md-6 col-xs-12">
                <a href="change-language.jsp?lc=it"><img src="images/italy.png" height="15px" width="25px"></a>
                <a href="change-language.jsp?lc=en"><img src="images/uk.png" height="15px" width="25px"></a>
                <!--
                <a href="change-language.jsp?lc=fr"><img src="images/france.png" height="15px" width="25px"></a>
                <a href="change-language.jsp?lc=de"><img src="images/germany.png" height="15px" width="25px"></a>
                <a href="change-language.jsp?lc=es"><img src="images/spain.png" height="15px" width="25px"></a>-->
                <a href="change-language.jsp?lc=sicilian"><img src="images/sicily.png" height="15px" width="25px"></a>
            </div>
            <div class="col-md-6 col-xs-12">
                <small><fmt:message key="footer.credits" /></small>
            </div>
        </div>
        </div>
    </footer>
</body>