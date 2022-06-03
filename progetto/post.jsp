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
    <%@ page import="java.util.ArrayList" %>

    <%
    
        Class.forName("com.mysql.jdbc.Driver");
            
        String postId = request.getParameter("id");

        if (postId == null)
        {
            response.sendRedirect("forum.jsp?q=all");
            return;
        }
        Connection conn = DriverManager.getConnection("jdbc:mysql://178.79.187.9:3306/progetto_pweb_2122", "alessio", "tommasofedericoalessio");

        Statement stmt = conn.createStatement();
        ResultSet DB_postInfo = stmt.executeQuery("SELECT * FROM `POST` WHERE id=" + postId);
        
        String titolo = null;
        String contenuto = null;
        String data = null;
        String creatore = null;
        int forPremium = 0;


        while(DB_postInfo.next())
        {
            titolo = DB_postInfo.getString(7);
            contenuto = DB_postInfo.getString(8);
            data = DB_postInfo.getString(6);
            creatore = DB_postInfo.getString(5);
            forPremium = Integer.parseInt(DB_postInfo.getString(4));
        }
    
        if (titolo == null)
        {
            response.sendRedirect("errore.jsp?messaggio='Il post che stai cercando non esiste'");
            return;
        }


        if (forPremium == 1 && session.getAttribute("session_exists") == null)
        {
            response.sendRedirect("errore.jsp?messaggio='Non puoi visualizzare questa risorsa'");
            return;
        }
        else if (forPremium == 1 && session.getAttribute("session_exists") != null)
        {
            Statement stmt3 = conn.createStatement();
            ResultSet DB_checkpremium = stmt.executeQuery("SELECT * FROM `PREMIUM` WHERE username='" + session.getAttribute("username") + "'");
            
            boolean isUserPremium = false;

            while(DB_checkpremium.next())
            {
                isUserPremium = true;
            }

            if (!isUserPremium)
            {
                response.sendRedirect("errore.jsp?messaggio='Non puoi visualizzare questa risorsa'");
                return;
            }
        
        }

        Statement stmtAdminCheck = conn.createStatement();
        ResultSet DB_adminCheck = stmtAdminCheck.executeQuery("SELECT * FROM `ADMIN` WHERE username='" + session.getAttribute("username") + "'");
        boolean isAdmin = false;

        while(DB_adminCheck.next())
        {
            isAdmin = true;
        }
    
    %>


    <jsp:include page="navbar.jsp" />

    <div class="forumcontainer" style="margin-top: 50px;">
        <!--Navigation-->
        <div class="navigate" style="display: flex;">
            <span class="qtitle">Q: <%= titolo %></span>         
        </div>

        <!--Topic Section-->
        <div class="topic-container">
            <div class="authors">
                <div class="username"><br><a href="profile.jsp?user=<%= creatore %>"><%= creatore %></a></div>
                
            </div>
            <div class="content">
                <br>
                <%= contenuto %>
                <br>
                <hr>
                <fmt:message key="post.publication.date" /> <%= data %> |
                
                <%

                    Statement stmt4 = conn.createStatement();
                    ResultSet DB_likenum = stmt4.executeQuery("SELECT COUNT(*) FROM `LIKE_POST` WHERE postId=" + postId);
                    int likenum = 0;

                    while(DB_likenum.next())
                    {
                        likenum = Integer.parseInt(DB_likenum.getString(1));
                    }
                    



                    if (session.getAttribute("session_exists") != null)
                    {

                        Statement stmt7 = conn.createStatement();
                        ResultSet DB_checklike = stmt7.executeQuery("SELECT * FROM `LIKE_POST` WHERE postId=" + postId + " AND username = '" + session.getAttribute("username") + "'");
                        String likeColor = "grey";
        
                        while(DB_checklike.next())
                        {
                            likeColor = "green";
                        }


                %>
                        <%= likenum %> <a style="color: <%= likeColor %>" href="/like?id=<%= postId %>&type=post"><i class="fa-solid fa-thumbs-up"></i></a> | 
                
                <%
                    
                        Statement stmt8 = conn.createStatement();
                        ResultSet DB_bookmarkExists = stmt8.executeQuery("SELECT * FROM `PREFERITI` WHERE post_id=" + postId + " AND username='" + session.getAttribute("username") + "'");
                        boolean bookmarkExists = false;
            
                        while(DB_bookmarkExists.next())
                        {
                            bookmarkExists = true;
                        }

                        if (!bookmarkExists)
                        {

                %>
                            <a href="/bookmark?id=<%= postId %>"><fmt:message key="post.preferiti.aggiungi" /></a> <p style="display: none">AAAAA</p>

                <%
                        }
                        else
                        {

                %>
                            <a href="/bookmark?id=<%= postId %>"><fmt:message key="post.preferiti.rimuovi" /></a> <p style="display: none">AAAAA</p>
                <%

                        }

                        if (session.getAttribute("username").equals(creatore) || isAdmin == true)
                        {

                %>
                            <a style="color: red; font-weight: bold" href="/deletePost?id=<%= postId %>&type=post"><fmt:message key="post.cancellazione" /></a></font>
                
                <%
                        }

                    }
                    else
                    {
                %>
        
                        <%= likenum %> <i class="fa-solid fa-thumbs-up"></i>
                <%
                
                    }
                %>
                <br>
                <br>
            </div>
        </div>

        <!--Navigation-->
        <div class="navigate">
            <span class="qtitle">Risposte</span>
        </div>

        <%
            Statement stmt2 = conn.createStatement();
            ResultSet DB_answers = stmt2.executeQuery("SELECT * FROM `RISPOSTA` WHERE idPost=" + postId + " ORDER BY `data_creazione` ASC");


            while(DB_answers.next())
            {

        %>

        <div class="topic-container">
            <div class="authors">
                <div class="username"><br><a href="profile.jsp?user=<%= DB_answers.getString(4) %>"><%= DB_answers.getString(4) %></a></div>
                     

            </div>
            <div class="content">
                <br>
                <%= DB_answers.getString(7) %>
                <br>
                <hr>
                <fmt:message key="post.publication.date" /> <%= DB_answers.getString(6) %> | 
                
                <%

                Statement stmt5 = conn.createStatement();
                ResultSet DB_answerlikenum = stmt5.executeQuery("SELECT COUNT(*) FROM `LIKE_RISPOSTA` WHERE answerId=" + DB_answers.getString(1));
                int answerlikenum = 0;

                while(DB_answerlikenum.next())
                {
                    answerlikenum = Integer.parseInt(DB_answerlikenum.getString(1));
                }
                
                    



                    if (session.getAttribute("session_exists") != null)
                    {
                        
                        Statement stmt6 = conn.createStatement();
                        ResultSet DB_checklike = stmt6.executeQuery("SELECT * FROM `LIKE_RISPOSTA` WHERE answerId=" + DB_answers.getString(1) + " AND username = '" + session.getAttribute("username") + "'");
                        String likeColor = "grey";
        
                        while(DB_checklike.next())
                        {
                            likeColor = "green";
                        }




                %>

                        
                        <%= answerlikenum %> <a style="color: <%= likeColor %>" href="/like?id=<%= DB_answers.getString(1) %>&type=answer&safepostid=<%= postId %>"><i class="fa-solid fa-thumbs-up"></i></a> | 
                
                
                
                
                <%

                        if (session.getAttribute("username").equals(DB_answers.getString(4)) || isAdmin == true)
                        {

                %>
                            <a style="color: red; font-weight: bold" href="/deletePost?id=<%= DB_answers.getString(1) %>&type=answer&safepostid=<%= postId %>"><fmt:message key="post.risposta.cancellazione" /></a>
                
                <%
                        }



                    }
                    else
                    {
                %>
        
                        <%= answerlikenum %> <i class="fa-solid fa-thumbs-up"></i>
                <%
                
                    }
                %>
                
                <br>
                <br>
            </div>
        </div>


        <%

            }

            if (session.getAttribute("session_exists") == null)
            {
    
        %>

                <div style="display: flex; width: 100%; margin-top: 20px;">
                    <p style="margin-left: auto"><fmt:message key="post.login.required1" /> <a href="login.jsp">login</a> <fmt:message key="post.login.required2" /></p>
                </div>

        <%
            }
            else
            {
        %>

                <div id="content" class="d-flex flex__center snippet-hidden form-responsive">
                
                            
                
                    <div class="flex--item">

                
                        <div id="formContainer" class="mx-auto mb24 p24 wmx3 bg-white bar-lg bs-xl mb24">
                            <form id="login-form" class="d-flex fd-column gs12 gsy" action="/answer" method="POST">
                                
                                
                                <div class="d-flex fd-column gs4 gsy js-auth-item ">
                                    <div class="d-flex ps-relative">
                                        <textarea class="s-input" type="text" size="30" maxlength="100" name="answer" style="width: 600px"></textarea>
                                    </div>
                                </div>

                                <input type="hidden" value="<%= postId %>" name="post_id">

                                <!-- submit -->

                                <div class="d-flex gs4 gsy fd-column js-auth-item ">
                                    <button class="flex--item s-btn s-btn__primary" id="submit-button" name="submit-button"><fmt:message key="post.invia.risposta" /></button>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>

        <%
        
            }
        %>


        
        
            

    </div>



    <jsp:include page="footer.jsp" />
</body>
</html>