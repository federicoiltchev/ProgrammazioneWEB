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
	<!-- Google font -->
	<link href="https://fonts.googleapis.com/css?family=Raleway:400,700" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Passion+One:900" rel="stylesheet">

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


    <jsp:include page="navbar.jsp" />

        <%


        Class.forName("com.mysql.jdbc.Driver");
        
        String queryType = request.getParameter("q");
        String tag = request.getParameter("tag");
        int viewPage = 0;
        String forumType = null;
        boolean searchPost = false;

        /* for pagination */

        if (request.getParameter("page") != null)
        {
            viewPage = Integer.parseInt(request.getParameter("page")) - 1;

            if (viewPage < 0) { viewPage = 0; } 
        }   

        /* posts to be shown */

        if (queryType == null && tag == null)
        {
            response.sendRedirect("forum.jsp?q=all");
            return;
        }
        else if (queryType == null && tag != null && tag.startsWith("tag:"))
        {
            forumType="tag";
            Cookie cookie = new Cookie("recents", tag);
            response.addCookie(cookie);


            tag = (tag.strip()).substring(4, tag.length());



        }
        else if (queryType == null && tag != null)
        {   
            forumType = "all";
            searchPost = true;
            Cookie cookie = new Cookie("recents", tag);
            response.addCookie(cookie);
        }
        else if (queryType.equals("all"))
        {
            forumType = "all";
        }
        else if (queryType.equals("pref"))
        {
            forumType = "pref";
        }
        else
        {
            response.sendRedirect("forum.jsp?q=all");
            return;
        }

        boolean isLogged = false;
        boolean isPremium = false;
        
        
        
        Connection conn = DriverManager.getConnection("jdbc:mysql://178.79.187.9:3306/progetto_pweb_2122?useSSL=false&allowPublicKeyRetrieval=true", "alessio", "tommasofedericoalessio");

        if (session.getAttribute("session_exists") != null)
        {
            isLogged = true;
            Statement stmt = conn.createStatement();
            ResultSet rs1 = stmt.executeQuery("SELECT * FROM `PREMIUM` WHERE username='" + session.getAttribute("username") + "'");
            
            while(rs1.next())
            {
                isPremium = true;
            }
        }



    
        
        if (forumType.equals("all"))
        {

            try 
            {
                Statement stmt = conn.createStatement();
                ResultSet rs2 = null;

                if (searchPost)
                {
                    stmt = conn.createStatement();                   
                    rs2 = stmt.executeQuery("SELECT * FROM `POST` WHERE titolo LIKE '%" + tag + "%' ORDER BY `data_creazione` DESC LIMIT " + viewPage*5 + ",5");
                }
                else
                {
                    out.println(viewPage*5);
                    out.println((viewPage*5)+5);
                    stmt = conn.createStatement();                   
                    rs2 = stmt.executeQuery("SELECT * FROM `POST` ORDER BY `data_creazione` DESC LIMIT " + viewPage*5 + ",5");
                }


            
        %>


            <div class="forumbar forumbar-responsive">

                <div class="d-flex ai-center mb16">
                    <div class="flex--item">
                        <div class=" d-flex s-btn-group js-filter-btn">
                            <a class="youarehere is-selected flex--item s-btn s-btn__muted s-btn__outlined" ><fmt:message key="forum.tab.all" /></a>
                            <a class="flex--item s-btn s-btn__muted s-btn__outlined" href="forum.jsp?q=pref"><fmt:message key="forum.tab.fav" /></a>
                            <a class="flex--item s-btn s-btn__muted s-btn__outlined">Tag</a>
                        </div>
                        
                        
                    </div>

                    <div class="flex--item" style="margin-left: auto">
                        <a href="ask.jsp" style="align-self: right;" class="s-btn s-btn__primary"><fmt:message key="forum.button.ask" /></a>
                    </div>

                </div>        


            <%
                    

                while(rs2.next())
                {
                    stmt = conn.createStatement();
                    ResultSet DB_tagassociati = stmt.executeQuery("SELECT * FROM `POST_TAG` WHERE postId = " + rs2.getString(1));
                    ArrayList<String> tags = new ArrayList<String>();

                    while(DB_tagassociati.next())
                    {
                        tags.add(DB_tagassociati.getString(2));
                    }



                    boolean hasAnswers = false;

                    stmt = conn.createStatement();
                    ResultSet rs3 = stmt.executeQuery("SELECT * FROM `RISPOSTA` WHERE idPost = " + rs2.getString(1));
                    
                    while(rs3.next())
                    {
                        hasAnswers = true;
                        break;
                    }

                    
                    if (isPremium)
                    {
                        // Nel caso in cui l'utente è premium genera status diversi in base al post (risposto-non risposto)


                        if (hasAnswers)
                        {
            %>

                            <div class="question-summary search-result" style="background-color: #292c31">
                                <div class="statscontainer">
                                    <div class="stats">
                                        <div class="vote">
                                            <div class="votes">
                                                <span class="vote-count-post "><i class="fa-solid fa-check"></i></span>
                                                <div class="viewcount"><fmt:message key="forum.status.risposto" /></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="summary">
                                    <div class="result-link">
                                        <h3><a href="post.jsp?id=<%= rs2.getString(1) %>" class="question-hyperlink"><% out.println(rs2.getString(7)); %></a></h3>
                                    </div>
                                    <div class="tags d-flex gs4 fw-wrap mt2">

                                        <%
                                            for (String posttag : tags)
                                            {
                                        %>

                                            <a href="forum.jsp?tag=tag:<%= posttag %>" class="post-tag flex--item" > <%= posttag %> </a> 
                                    
                                        <%
                                            }
                                        %>
                                    </div>
                                    <div class="started float-right">
                                        <% out.println("<a href='profile.jsp?user="+ rs2.getString(5) + "'>"); %> <%= rs2.getString(5) %></a> <fmt:message key="forum.question.owner" />
                                    </div>
                                </div>
                            </div>

            <%
                        }
                        else
                        {
                            // UTENTE PREMIUM - NON RISPOSTO
            %>
                            <div class="question-summary search-result" style="background-color: #292c31">
                                <div class="statscontainer">
                                    <div class="stats">
                                        <div class="vote">
                                            <div class="votes">
                                                <span class="vote-count-post "><i class="fa-solid fa-xmark"></i></span>
                                                <div class="viewcount"><fmt:message key="forum.status.nonrisposto" /></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="summary">
                                    <div class="result-link">
                                        <h3><a href="post.jsp?id=<%= rs2.getString(1) %>" class="question-hyperlink"><% out.println(rs2.getString(7)); %></a></h3>
                                    </div>
                                    <div class="tags d-flex gs4 fw-wrap mt2">

                                        <%
                                            for (String posttag : tags)
                                            {
                                        %>

                                            <a href="forum.jsp?tag=tag:<%= posttag %>" class="post-tag flex--item" > <%= posttag %> </a> 
                                    
                                        <%
                                            }
                                        %>
                                    </div>
                                    <div class="started float-right">
                                        <% out.println("<a href='profile.jsp?user="+ rs2.getString(5) + "'>"); %> <%= rs2.getString(5) %></a> <fmt:message key="forum.question.owner" />
                                    </div>
                                </div>
                            </div>

            <%
                        }
            
                    }
                    else
                    {
                        // risorsa protetta perchè l'utente non è premium


                        if ((rs2.getString(4)).equals("1"))
                        {


            %>
                            <div class="question-summary search-result" style="background-color: #292c31">
                                <div class="statscontainer">
                                    <div class="stats">
                                        <div class="vote">
                                            <div class="votes">
                                                <span class="vote-count-post "><i class="fa-solid fa-lock"></i></span>
                                                <div class="viewcount">premium</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="summary" style="filter: blur(4px); pointer-events: none;">
                                    <div class="result-link">
                                        <h3><a href="post.jsp?id=<%= rs2.getString(1) %>" class="question-hyperlink"><% out.println(rs2.getString(7)); %></a></h3>
                                    </div>
                                    <div class="tags d-flex gs4 fw-wrap mt2">

                                        <%
                                            for (String posttag : tags)
                                            {
                                        %>

                                            <a href="forum.jsp?tag=tag:<%= posttag %>" class="post-tag flex--item" > <%= posttag %> </a> 
                                    
                                        <%
                                            }
                                        %>
                                    </div>
                                    <div class="started float-right">
                                        <% out.println("<a href='profile.jsp?user="+ rs2.getString(5) + "'>"); %> <%= rs2.getString(5) %></a> <fmt:message key="forum.question.owner" />
                                    </div>
                                </div>
                            </div>           


            <%
                        }
                        else 
                        {

                            if (hasAnswers)
                            {

            %>  
                                <div class="question-summary search-result" style="background-color: #292c31">
                                    <div class="statscontainer">
                                        <div class="stats">
                                            <div class="vote">
                                                <div class="votes">
                                                    <span class="vote-count-post "><i class="fa-solid fa-check"></i></span>
                                                    <div class="viewcount"><fmt:message key="forum.status.risposto" /></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="summary">
                                        <div class="result-link">
                                            <h3><a href="post.jsp?id=<%= rs2.getString(1) %>" class="question-hyperlink"><% out.println(rs2.getString(7)); %></a></h3>
                                        </div>
                                        <div class="tags d-flex gs4 fw-wrap mt2">

                                            <%
                                                for (String posttag : tags)
                                                {
                                            %>
        
                                                <a href="forum.jsp?tag=tag:<%= posttag %>" class="post-tag flex--item" > <%= posttag %> </a> 
                                        
                                            <%
                                                }
                                            %>
                                        </div>
                                        <div class="started float-right">
                                            <% out.println("<a href='profile.jsp?user="+ rs2.getString(5) + "'>"); %> <%= rs2.getString(5) %></a> <fmt:message key="forum.question.owner" />
                                        </div>
                                    </div>
                                </div>  
            
            <%
                            }
                            else
                            {
            %>
                                <div class="question-summary search-result" style="background-color: #292c31">
                                    <div class="statscontainer">
                                        <div class="stats">
                                            <div class="vote">
                                                <div class="votes">
                                                    <span class="vote-count-post "><i class="fa-solid fa-xmark"></i></span>
                                                    <div class="viewcount"><fmt:message key="forum.status.nonrisposto" /></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="summary">
                                        <div class="result-link">
                                            <h3><a href="post.jsp?id=<%= rs2.getString(1) %>" class="question-hyperlink"><% out.println(rs2.getString(7)); %></a></h3>
                                        </div>
                                        <div class="tags d-flex gs4 fw-wrap mt2">

                                            <%
                                                for (String posttag : tags)
                                                {
                                            %>
        
                                                <a href="forum.jsp?tag=tag:<%= posttag %>" class="post-tag flex--item" > <%= posttag %> </a> 
                                        
                                            <%
                                                }
                                            %>
                                        </div>
                                        <div class="started float-right">
                                            <% out.println("<a href='profile.jsp?user="+ rs2.getString(5) + "'>"); %> <%= rs2.getString(5) %></a> <fmt:message key="forum.question.owner" />
                                        </div>
                                    </div>
                                </div>  

            <%      
                            }
                        }
                    }
                }
            
                    
            
            
                conn.close();
                
                }
                catch (Exception e)
                {
                    out.println(e.getMessage());
                }


            
            %>

            <!-- pagination (TAB ALL) -->


                <br class="cbt">
                <div class="s-pagination site1 themed pager float-left">

                    <%
                        if (searchPost)
                        {
                    %>

                            <a class="s-pagination--item " href="forum.jsp?tag=<%= tag %>&page=<%= viewPage %>" title="Vai alla pagina <%= viewPage %>"> <fmt:message key="forum.button.paginaprima" /> </a>
                            <a class="s-pagination--item " href="forum.jsp?tag=<%= tag %>&page=<%= viewPage+2 %>" title="Vai alla pagina <%= viewPage+2 %>"> <fmt:message key="forum.button.paginadopo" /> </a>
                    <%
                        }
                        else
                        {    
                    %>
                            <a class="s-pagination--item " href="forum.jsp?q=all&page=<%= viewPage %>" title="Vai alla pagina <%= viewPage %>"> <fmt:message key="forum.button.paginaprima" /> </a>
                            <a class="s-pagination--item " href="forum.jsp?q=all&page=<%= viewPage+2 %>" title="Vai alla pagina <%= viewPage+2 %>"> <fmt:message key="forum.button.paginadopo" /> </a>
                    <%
                        }
                    
                    %>


                </div>
            </div>
        


    
        <% 

        }
        else if (forumType.equals("pref"))
        {

            if (session.getAttribute("session_exists") == null)
            {
                response.sendRedirect("login.jsp");
                return;
            }

            try 
            {
                Statement stmt = conn.createStatement();                   
                ResultSet rs2 = stmt.executeQuery("SELECT id,`like`,dislike,premium,utente_creatore,data_creazione,titolo,contenuto FROM `POST` INNER JOIN `PREFERITI` ON PREFERITI.post_id = POST.id WHERE username = '" + session.getAttribute("username") + "' ORDER BY `data_creazione` DESC LIMIT " + viewPage*5 + ",5");

        %>
        
                <div class="forumbar forumbar-responsive">

                    <div class="d-flex ai-center mb16">
                        <div class="flex--item">
                            <div class=" d-flex s-btn-group js-filter-btn">
                                <a class="flex--item s-btn s-btn__muted s-btn__outlined" href="forum.jsp?q=all"><fmt:message key="forum.tab.all" /></a>
                                <a class="youarehere is-selected flex--item s-btn s-btn__muted s-btn__outlined" ><fmt:message key="forum.tab.fav" /></a>
                                <a class="flex--item s-btn s-btn__muted s-btn__outlined" href="#">Tag</a>
                            </div>
                            
                            
                        </div>

                        <div class="flex--item" style="margin-left: auto">
                            <a href="ask.jsp" style="align-self: right;" class="s-btn s-btn__primary"><fmt:message key="forum.button.ask" /></a>
                        </div>

                    </div>        


                <%
                    while(rs2.next())
                    {
                        stmt = conn.createStatement();
                        ResultSet DB_tagassociati = stmt.executeQuery("SELECT * FROM `POST_TAG` WHERE postId = " + rs2.getString(1));
                        ArrayList<String> tags = new ArrayList<String>();

                        while(DB_tagassociati.next())
                        {
                            tags.add(DB_tagassociati.getString(2));
                        }



                        boolean hasAnswers = false;

                        stmt = conn.createStatement();
                        ResultSet rs3 = stmt.executeQuery("SELECT * FROM `RISPOSTA` WHERE idPost = " + rs2.getString(1));
                        
                        while(rs3.next())
                        {
                            hasAnswers = true;
                            break;
                        }

                        
                        if (isPremium)
                        {
                            // Nel caso in cui l'utente è premium genera status diversi in base al post (risposto-non risposto)


                            if (hasAnswers)
                            {
                %>

                                <div class="question-summary search-result" style="background-color: #292c31">
                                    <div class="statscontainer">
                                        <div class="stats">
                                            <div class="vote">
                                                <div class="votes">
                                                    <span class="vote-count-post "><i class="fa-solid fa-check"></i></span>
                                                    <div class="viewcount"><fmt:message key="forum.status.risposto" /></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="summary">
                                        <div class="result-link">
                                            <h3><a href="post.jsp?id=<%= rs2.getString(1) %>" class="question-hyperlink"><% out.println(rs2.getString(7)); %><i class="fa-solid fa-bookmark"></i></a></h3>
                                        </div>
                                        <div class="tags d-flex gs4 fw-wrap mt2">

                                            <%
                                                for (String posttag : tags)
                                                {
                                            %>

                                                <a href="forum.jsp?tag=tag:<%= posttag %>" class="post-tag flex--item" > <%= posttag %> </a> 
                                        
                                            <%
                                                }
                                            %>
                                        </div>
                                        <div class="started float-right">
                                            <% out.println("<a href='profile.jsp?user="+ rs2.getString(5) + "'>"); %> <%= rs2.getString(5) %></a> <fmt:message key="forum.question.owner" />
                                        </div>
                                    </div>
                                </div>

                <%
                            }
                            else
                            {
                %>
                                <div class="question-summary search-result" style="background-color: #292c31">
                                    <div class="statscontainer">
                                        <div class="stats">
                                            <div class="vote">
                                                <div class="votes">
                                                    <span class="vote-count-post "><i class="fa-solid fa-xmark"></i></span>
                                                    <div class="viewcount"><fmt:message key="forum.status.nonrisposto" /></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="summary">
                                        <div class="result-link">
                                            <h3><a href="post.jsp?id=<%= rs2.getString(1) %>" class="question-hyperlink"><% out.println(rs2.getString(7)); %><i class="fa-solid fa-bookmark"></i></a></h3>
                                        </div>
                                        <div class="tags d-flex gs4 fw-wrap mt2">

                                            <%
                                                for (String posttag : tags)
                                                {
                                            %>

                                                <a href="forum.jsp?tag=tag:<%= posttag %>" class="post-tag flex--item" > <%= posttag %> </a> 
                                        
                                            <%
                                                }
                                            %>
                                        </div>
                                        <div class="started float-right">
                                            <% out.println("<a href='profile.jsp?user="+ rs2.getString(5) + "'>"); %> <%= rs2.getString(5) %></a> <fmt:message key="forum.question.owner" />
                                        </div>
                                    </div>
                                </div>

                <%
                            }
                
                        }
                        else
                        {
                            // risorsa protetta perchè l'utente non è premium


                            if ((rs2.getString(4)).equals("1"))
                            {


                %>
                                <div class="question-summary search-result" style="background-color: #292c31">
                                    <div class="statscontainer">
                                        <div class="stats">
                                            <div class="vote">
                                                <div class="votes">
                                                    <span class="vote-count-post "><i class="fa-solid fa-lock"></i></span>
                                                    <div class="viewcount">premium</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="summary" style="filter: blur(4px); pointer-events: none;">
                                        <div class="result-link">
                                            <h3><a href="post.jsp?id=<%= rs2.getString(1) %>" class="question-hyperlink"><% out.println(rs2.getString(7)); %><i class="fa-solid fa-bookmark"></i></a></h3>
                                        </div>
                                        <div class="tags d-flex gs4 fw-wrap mt2">

                                            <%
                                                for (String posttag : tags)
                                                {
                                            %>

                                                <a href="forum.jsp?tag=tag:<%= posttag %>" class="post-tag flex--item" > <%= posttag %> </a> 
                                        
                                            <%
                                                }
                                            %>
                                        </div>
                                        <div class="started float-right">
                                            <% out.println("<a href='profile.jsp?user="+ rs2.getString(5) + "'>"); %> <%= rs2.getString(5) %></a> <fmt:message key="forum.question.owner" />
                                        </div>
                                    </div>
                                </div>           


                <%
                            }
                            else 
                            {

                                if (hasAnswers)
                                {

                %>  
                                    <div class="question-summary search-result" style="background-color: #292c31">
                                        <div class="statscontainer">
                                            <div class="stats">
                                                <div class="vote">
                                                    <div class="votes">
                                                        <span class="vote-count-post "><i class="fa-solid fa-check"></i></span>
                                                        <div class="viewcount"><fmt:message key="forum.status.risposto" /></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="summary">
                                            <div class="result-link">
                                                <h3><a href="post.jsp?id=<%= rs2.getString(1) %>" class="question-hyperlink"><% out.println(rs2.getString(7)); %><i class="fa-solid fa-bookmark"></i></a></h3>
                                            </div>
                                            <div class="tags d-flex gs4 fw-wrap mt2">

                                                <%
                                                    for (String posttag : tags)
                                                    {
                                                %>
            
                                                    <a href="forum.jsp?tag=tag:<%= posttag %>" class="post-tag flex--item" > <%= posttag %> </a> 
                                            
                                                <%
                                                    }
                                                %>
                                            </div>
                                            <div class="started float-right">
                                                <% out.println("<a href='profile.jsp?user="+ rs2.getString(5) + "'>"); %> <%= rs2.getString(5) %></a> <fmt:message key="forum.question.owner" />
                                            </div>
                                        </div>
                                    </div>  
                
                <%
                                }
                                else
                                {
                %>
                                    <div class="question-summary search-result" style="background-color: #292c31">
                                        <div class="statscontainer">
                                            <div class="stats">
                                                <div class="vote">
                                                    <div class="votes">
                                                        <span class="vote-count-post "><i class="fa-solid fa-xmark"></i></span>
                                                        <div class="viewcount"><fmt:message key="forum.status.nonrisposto" /></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="summary">
                                            <div class="result-link">
                                                <h3><a href="post.jsp?id=<%= rs2.getString(1) %>" class="question-hyperlink"><% out.println(rs2.getString(7)); %><i class="fa-solid fa-bookmark"></i></a></h3>
                                            </div>
                                            <div class="tags d-flex gs4 fw-wrap mt2">

                                                <%
                                                    for (String posttag : tags)
                                                    {
                                                %>
            
                                                    <a href="forum.jsp?tag=tag:<%= posttag %>" class="post-tag flex--item" > <%= posttag %> </a> 
                                            
                                                <%
                                                    }
                                                %>
                                            </div>
                                            <div class="started float-right">
                                                <% out.println("<a href='profile.jsp?user="+ rs2.getString(5) + "'>"); %> <%= rs2.getString(5) %></a> <fmt:message key="forum.question.owner" />
                                            </div>
                                        </div>
                                    </div>  

                <%      
                                }
                            }
                        }
                    }
                
                        
                
                
                    conn.close();
                    
                    }
                    catch (Exception e)
                    {
                        out.println(e.getMessage());
                    }


                
                %>


                <!-- pagination (TAB PREFERITI )-->

                    <br class="cbt">
                    <div class="s-pagination site1 themed pager float-left">
        
                        <a class="s-pagination--item " href="forum.jsp?q=pref&page=<%= viewPage %>" title="Vai alla pagina <%= viewPage %>"> <fmt:message key="forum.button.paginaprima" /> </a>
                        <a class="s-pagination--item " href="forum.jsp?q=pref&page=<%= viewPage+2 %>" title="Vai alla pagina <%= viewPage+2 %>"> <fmt:message key="forum.button.paginadopo" /> </a>
        
        
                    </div>
                </div>

        <%
        }
        else if (forumType.equals("tag"))
        {
            try 
            {
                Statement stmt = conn.createStatement();                   
                ResultSet rs2 = stmt.executeQuery("SELECT DISTINCT id,`like`,dislike,premium,utente_creatore,data_creazione,titolo,contenuto FROM `POST` INNER JOIN `POST_TAG` ON POST_TAG.postId = POST.id WHERE tag = '" + tag + "' ORDER BY `data_creazione` DESC LIMIT " + viewPage*5 + ",5");


        %>

            <div class="forumbar forumbar-responsive">

                <div class="d-flex ai-center mb16">
                    <div class="flex--item">
                        <div class=" d-flex s-btn-group js-filter-btn">
                            <a class="flex--item s-btn s-btn__muted s-btn__outlined" href="forum.jsp?q=all"><fmt:message key="forum.tab.all" /></a>
                            <a class="flex--item s-btn s-btn__muted s-btn__outlined" href="forum.jsp?q=pref"><fmt:message key="forum.tab.fav" /></a>
                            <a class="youarehere is-selected flex--item s-btn s-btn__muted s-btn__outlined" >Tag</a>
                        </div>
                        
                        
                    </div>

                    <div class="flex--item" style="margin-left: auto">
                        <a href="ask.jsp" style="align-self: right;" class="s-btn s-btn__primary"><fmt:message key="forum.button.ask" /></a>
                    </div>

                </div>        


            <%
                while(rs2.next())
                {
                    stmt = conn.createStatement();
                    ResultSet DB_tagassociati = stmt.executeQuery("SELECT * FROM `POST_TAG` WHERE postId = " + rs2.getString(1));
                    ArrayList<String> tags = new ArrayList<String>();

                    while(DB_tagassociati.next())
                    {
                        tags.add(DB_tagassociati.getString(2));
                    }



                    boolean hasAnswers = false;

                    stmt = conn.createStatement();
                    ResultSet rs3 = stmt.executeQuery("SELECT * FROM `RISPOSTA` WHERE idPost = " + rs2.getString(1));
                    
                    while(rs3.next())
                    {
                        hasAnswers = true;
                        break;
                    }

                    
                    if (isPremium)
                    {
                        // Nel caso in cui l'utente è premium genera status diversi in base al post (risposto-non risposto)


                        if (hasAnswers)
                        {
            %>

                            <div class="question-summary search-result" style="background-color: #292c31">
                                <div class="statscontainer">
                                    <div class="stats">
                                        <div class="vote">
                                            <div class="votes">
                                                <span class="vote-count-post "><i class="fa-solid fa-check"></i></span>
                                                <div class="viewcount"><fmt:message key="forum.status.risposto" /></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="summary">
                                    <div class="result-link">
                                        <h3><a href="post.jsp?id=<%= rs2.getString(1) %>" class="question-hyperlink"><% out.println(rs2.getString(7)); %></a></h3>
                                    </div>
                                    <div class="tags d-flex gs4 fw-wrap mt2">

                                        <%
                                            for (String posttag : tags)
                                            {
                                        %>

                                            <a href="forum.jsp?tag=tag:<%= posttag %>" class="post-tag flex--item" > <%= posttag %> </a> 
                                    
                                        <%
                                            }
                                        %>
                                    </div>
                                    <div class="started float-right">
                                        <% out.println("<a href='profile.jsp?user="+ rs2.getString(5) + "'>"); %> <%= rs2.getString(5) %></a> <fmt:message key="forum.question.owner" />
                                    </div>
                                </div>
                            </div>

            <%
                        }
                        else
                        {
            %>
                            <div class="question-summary search-result" style="background-color: #292c31">
                                <div class="statscontainer">
                                    <div class="stats">
                                        <div class="vote">
                                            <div class="votes">
                                                <span class="vote-count-post "><i class="fa-solid fa-xmark"></i></span>
                                                <div class="viewcount"><fmt:message key="forum.status.nonrisposto" /></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="summary">
                                    <div class="result-link">
                                        <h3><a href="post.jsp?id=<%= rs2.getString(1) %>" class="question-hyperlink"><% out.println(rs2.getString(7)); %></a></h3>
                                    </div>
                                    <div class="tags d-flex gs4 fw-wrap mt2">

                                        <%
                                            for (String posttag : tags)
                                            {
                                        %>

                                            <a href="forum.jsp?tag=tag:<%= posttag %>" class="post-tag flex--item" > <%= posttag %> </a> 
                                    
                                        <%
                                            }
                                        %>
                                    </div>
                                    <div class="started float-right">
                                        <% out.println("<a href='profile.jsp?user="+ rs2.getString(5) + "'>"); %> <%= rs2.getString(5) %></a> <fmt:message key="forum.question.owner" />
                                    </div>
                                </div>
                            </div>

            <%
                        }
            
                    }
                    else
                    {
                        // risorsa protetta perchè l'utente non è premium


                        if ((rs2.getString(4)).equals("1"))
                        {


            %>
                            <div class="question-summary search-result" style="background-color: #292c31">
                                <div class="statscontainer">
                                    <div class="stats">
                                        <div class="vote">
                                            <div class="votes">
                                                <span class="vote-count-post "><i class="fa-solid fa-lock"></i></span>
                                                <div class="viewcount">premium</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="summary" style="filter: blur(4px); pointer-events: none;">
                                    <div class="result-link">
                                        <h3><a href="post.jsp?id=<%= rs2.getString(1) %>" class="question-hyperlink"><% out.println(rs2.getString(7)); %></a></h3>
                                    </div>
                                    <div class="tags d-flex gs4 fw-wrap mt2">

                                        <%
                                            for (String posttag : tags)
                                            {
                                        %>

                                            <a href="forum.jsp?tag=tag:<%= posttag %>" class="post-tag flex--item" > <%= posttag %> </a> 
                                    
                                        <%
                                            }
                                        %>
                                    </div>
                                    <div class="started float-right">
                                        <% out.println("<a href='profile.jsp?user="+ rs2.getString(5) + "'>"); %> <%= rs2.getString(5) %></a> <fmt:message key="forum.question.owner" />
                                </div>
                            </div>           


            <%
                        }
                        else 
                        {

                            if (hasAnswers)
                            {

            %>  
                                <div class="question-summary search-result" style="background-color: #292c31">
                                    <div class="statscontainer">
                                        <div class="stats">
                                            <div class="vote">
                                                <div class="votes">
                                                    <span class="vote-count-post "><i class="fa-solid fa-check"></i></span>
                                                    <div class="viewcount"><fmt:message key="forum.status.risposto" /></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="summary">
                                        <div class="result-link">
                                            <h3><a href="post.jsp?id=<%= rs2.getString(1) %>" class="question-hyperlink"><% out.println(rs2.getString(7)); %></a></h3>
                                        </div>
                                        <div class="tags d-flex gs4 fw-wrap mt2">

                                            <%
                                                for (String posttag : tags)
                                                {
                                            %>
        
                                                <a href="forum.jsp?tag=tag:<%= posttag %>" class="post-tag flex--item" > <%= posttag %> </a> 
                                        
                                            <%
                                                }
                                            %>
                                        </div>
                                        <div class="started float-right">
                                            <% out.println("<a href='profile.jsp?user="+ rs2.getString(5) + "'>"); %> <%= rs2.getString(5) %></a> <fmt:message key="forum.question.owner" />
                                        </div>
                                    </div>
                                </div>  
            
            <%
                            }
                            else
                            {
            %>
                                <div class="question-summary search-result" style="background-color: #292c31">
                                    <div class="statscontainer">
                                        <div class="stats">
                                            <div class="vote">
                                                <div class="votes">
                                                    <span class="vote-count-post "><i class="fa-solid fa-xmark"></i></span>
                                                    <div class="viewcount"><fmt:message key="forum.status.nonrisposto" /></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="summary">
                                        <div class="result-link">
                                            <h3><a href="post.jsp?id=<%= rs2.getString(1) %>" class="question-hyperlink"><% out.println(rs2.getString(7)); %></a></h3>
                                        </div>
                                        <div class="tags d-flex gs4 fw-wrap mt2">

                                            <%
                                                for (String posttag : tags)
                                                {
                                            %>
        
                                                <a href="forum.jsp?tag=tag:<%= posttag %>" class="post-tag flex--item" > <%= posttag %> </a> 
                                        
                                            <%
                                                }
                                            %>
                                        </div>
                                        <div class="started float-right">
                                            <% out.println("<a href='profile.jsp?user="+ rs2.getString(5) + "'>"); %> <%= rs2.getString(5) %></a> <fmt:message key="forum.question.owner" />
                                        </div>
                                    </div>
                                </div>  

            <%      
                            }
                        }
                    }
                }
            
                    
            
            
                conn.close();
                
                }
                catch (Exception e)
                {
                    out.println(e.getMessage());
                }


            
            %>

            <!-- pagination (TAB TAGS )-->


                <br class="cbt">
                <div class="s-pagination site1 themed pager float-left">

                    <a class="s-pagination--item " href="forum.jsp?tag=tag:<%= tag %>&page=<%= viewPage %>" title="Vai alla pagina <%= viewPage %>"> <fmt:message key="forum.button.paginaprecedente" /> </a>
                    <a class="s-pagination--item " href="forum.jsp?tag=tag:<%= tag %>&page=<%= viewPage+2 %>" title="Vai alla pagina <%= viewPage+2 %>"> <fmt:message key="forum.button.paginadopo" /> </a>


                </div>
            </div>

        <%

        }

        %>


    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>