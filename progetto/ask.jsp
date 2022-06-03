<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OutOfMemory</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="primary.css">
    <link rel="stylesheet" href="secondary.css">
    <link rel="stylesheet" href="stacks.css">
    <link rel="stylesheet" href="channels.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
    
    <script src="https://kit.fontawesome.com/4c27afb9d3.js" crossorigin="anonymous"></script>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Titillium+Web:ital@1&display=swap" rel="stylesheet">
</head>

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

    <%@ page import="java.sql.*" %>

    <jsp:include page="navbar.jsp" />


    <%

    if (session.getAttribute("session_exists") == null)
    {
        response.sendRedirect("login.jsp");
        return;
    }

    Class.forName("com.mysql.jdbc.Driver");

    Connection conn = DriverManager.getConnection("jdbc:mysql://178.79.187.9:3306/progetto_pweb_2122", "alessio", "tommasofedericoalessio");



    Statement stmt = conn.createStatement();
    ResultSet DB_checkpremium = stmt.executeQuery("SELECT * FROM `PREMIUM` WHERE username='" + session.getAttribute("username") + "'");
    
    boolean isPremium = false;

    while(DB_checkpremium.next())
    {
        isPremium = true;
    }
    
    
    %>



    <div style="margin-top:100px;" class="container">
        
        <div id="content" class="d-flex flex__center snippet-hidden form-responsive ">
        
                    
        
            <div class="flex--item">

        
                <div id="formContainer" class="mx-auto mb24 p24 wmx3 bg-white bar-lg bs-xl mb24">

                    <form id="login-form" class="d-flex fd-column gs12 gsy" action="/ask" method="POST">
                        

                        <div class="d-flex fd-column gs4 gsy js-auth-item ">
                            <label class="flex--item s-label" for="titolo"><fmt:message key="ask.form.title" /></label>
                            <div class="d-flex ps-relative">
                                <input class="s-input" type="textarea" size="30" maxlength="100" name="titolo" autocomplete="off" required >
                            </div>

                        </div>

                        <div class="d-flex fd-column gs4 gsy js-auth-item ">
                            <label class="flex--item s-label" for="email"><fmt:message key="ask.form.content" /></label>
                            <div class="d-flex ps-relative">
                                <textarea class="s-input" type="textarea" size="30" name="contenuto" style="height: 100px" ></textarea>
                            </div>
                        </div>


                        <div class="d-flex fd-column-reverse gs4 gsy js-auth-item ">
                            <select name="tag" multiple>
                                <%

                                Statement stmt2 = conn.createStatement();
                                ResultSet DB_tags = stmt.executeQuery("SELECT * FROM `TAG`");
                                
                                while(DB_tags.next())
                                {
                            
                                %>
                                    <option value="<%= DB_tags.getString(1) %>"><%= DB_tags.getString(1) %></option>
        
                                <%
        
                                    }
        
                                %>
                                
                            </select>
                            <div class="d-flex ai-center ps-relative jc-space-between">
                                <label class="flex--item s-label" for="tag">Tags</label>
                            </div>
                        </div>


                        <%
                        
                            if (isPremium)
                            {                        
                        %>


                                <div class="d-flex fd-column-reverse gs4 gsy js-auth-item ">
                                    <select name="premium">
                                        <option value="y">Si</option>
                                        <option value="n">No</option>
                                    </select>
                                    <div class="d-flex ai-center ps-relative jc-space-between">
                                        <label class="flex--item s-label" for="premium">Premium</label>
                                    </div>
                                </div>
                        <%
                        
                            }
                        %>
                        
                        


                        <!-- submit -->

                        <div class="d-flex gs4 gsy fd-column js-auth-item ">
                            <button class="flex--item s-btn s-btn__primary" id="submit-button" name="submit-button"><fmt:message key="ask.form.button" /></button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>


    <jsp:include page="footer.jsp" />
</body>
</html>