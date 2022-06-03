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


<body style="background-color: var(--white)">

    <style>

        * {
            margin: 0;
            padding: 0
        }

        body {
            background-color: #000
        }

        .card {
            width: 350px;
            background-color: #efefef;
            border: none;
            cursor: pointer;
            transition: all 0.5s;
        }

        .image img {
            transition: all 0.5s
        }

        .card:hover .image img {
            transform: scale(1.5)
        }

        .btn {
            height: 140px;
            width: 140px;
            border-radius: 50%
        }

        .name {
            font-size: 22px;
            font-weight: bold
        }

        .idd {
            font-size: 14px;
            font-weight: 600
        }

        .idd1 {
            font-size: 12px
        }

        .number {
            font-size: 22px;
            font-weight: bold
        }

        .follow {
            font-size: 12px;
            font-weight: 500;
            color: #444444
        }

        .btn1 {
            height: 40px;
            width: 150px;
            border: none;
            background-color: #000;
            color: #aeaeae;
            font-size: 15px
        }

        .text span {
            font-size: 13px;
            color: #545454;
            font-weight: 500
        }

        .icons i {
            font-size: 19px
        }

        hr .new1 {
            border: 1px solid
        }

        .join {
            font-size: 14px;
            color: #a0a0a0;
            font-weight: bold
        }

        .date {
            background-color: #ccc
        }


    </style>


    <%@ page import="java.sql.*" %>

    <jsp:include page="navbar.jsp" />

    <% 
            
    String username = request.getParameter("user");

    if (username == null)
    {
        response.sendRedirect("forum.jsp?q=all");
        return;
    }

    String nome = null;
    String cognome = null;
    String data_registrazione = null;

    int postnumber = 0;
    int likenumber = 0;
    
    try 
    {
        Class.forName("com.mysql.jdbc.Driver"); 
        Connection conn = DriverManager.getConnection("jdbc:mysql://178.79.187.9:3306/progetto_pweb_2122", "alessio", "tommasofedericoalessio");
        
        Statement stmt = conn.createStatement();  
        ResultSet rs = stmt.executeQuery("SELECT * FROM `UTENTE` WHERE `UTENTE`.`username` = '" + username + "'");  
        
        boolean userExists = false;

        while(rs.next())
        {
            userExists = true;
            nome = rs.getString(1);
            cognome = rs.getString(2);
            data_registrazione = rs.getString(4);
        }

        out.println(nome);
        out.println(cognome);
        out.println(data_registrazione);

        /* L'utente non esiste */
        if (!userExists) { response.sendRedirect("errore.jsp?messaggio='utente non trovato'"); return; }

        if (nome == null) { nome = "-"; }
        if (cognome == null) { cognome = "-"; }

        Statement stmt3 = conn.createStatement();  
        ResultSet DB_postnum = stmt3.executeQuery("SELECT COUNT(*) FROM `POST` WHERE `POST`.`utente_creatore` = '" + username + "'");  
        
        while(DB_postnum.next())
        {
            postnumber = Integer.parseInt(DB_postnum.getString(1));
        }


        int l1 = 0;
        int l2 = 0;

        Statement stmt4 = conn.createStatement();  
        ResultSet DB_likenum1 = stmt4.executeQuery("SELECT COUNT(*) FROM LIKE_POST INNER JOIN POST ON LIKE_POST.postId = POST.id WHERE POST.utente_creatore = '" + username + "'");  
        
        while(DB_likenum1.next())
        {
            l1 = Integer.parseInt(DB_likenum1.getString(1));
        }

        Statement stmt5 = conn.createStatement();  
        ResultSet DB_likenum2 = stmt5.executeQuery("SELECT COUNT(*) FROM LIKE_RISPOSTA INNER JOIN RISPOSTA ON LIKE_RISPOSTA.answerId = RISPOSTA.id WHERE RISPOSTA.username_creatore = '" + username + "'");  
        
        while(DB_likenum2.next())
        {
            l2 = Integer.parseInt(DB_likenum2.getString(1));
        }

        likenumber = l1+l2;
        

        conn.close();
    
    }
    catch (Exception e)
    {
        out.println(e.getMessage());
    }

    
    

    
    %>


    <div class="container mt-4 mb-4 p-3 d-flex justify-content-center" style="margin-top: 100px !important">
        <div class="card p-4">
            <div class=" image d-flex flex-column justify-content-center align-items-center">
                <button class="btn btn-secondary"> <img src="images/programmer.png" height="100" width="100" /></button> <span class="name mt-3"><% out.println(nome); %> <% out.println(cognome); %></span> <span class="idd"><% out.println("@" + username); %></span>
                <div class="d-flex flex-row justify-content-center align-items-center mt-3"> <span class="number"><%= postnumber %> <span class="follow">post</span></span></div>
                <div class="d-flex flex-row justify-content-center align-items-center mt-3"> <span class="number"><%= likenumber %> <span class="follow">likes</span></span></div>
                <div class="d-flex flex-row justify-content-center align-items-center mt-3"> <span class="follow"><fmt:message key="profile.community" />: <span class="number"><% out.println(data_registrazione); %></span></span></div>
            </div>
        </div>
    </div>




    <jsp:include page="footer.jsp" />
</body>
</html>