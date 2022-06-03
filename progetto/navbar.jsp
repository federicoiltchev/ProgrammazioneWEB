<!DOCTYPE html>
<html lang="en" class="navbar-responsive">

    <link rel="icon" type="image/x-icon" href="images/favicon.ico">

    	<!-- Google font -->
	<link href="https://fonts.googleapis.com/css?family=Raleway:400,700" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Passion+One:900" rel="stylesheet">

    <script>

        function showRecents() 
        {
            var x = document.getElementById("recent-searches");
            x.style.display = "block";
        }
        function removeRecents() 
        {
            var x = document.getElementById("recent-searches");
            x.style.display = "none";
        }

    </script>

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


    <body class="navbar-responsive" >

        <header class="s-topbar ps-fixed t0 l0" style="border-top: none">
            <!--NavBar Section-->
            <div class="s-topbar--container">
                
                <a href="index.jsp" class="s-topbar--logo">
                    <span class="brand"> <fmt:message key="AppName" /> </span>
                    
                </a>

                <ol class="s-navigation">

                    <li class="responsive-disappear">
                        <a href="forum.jsp" class="s-navigation--item">Forum</a>
                    </li>

                    <li class="responsive-disappear">
                        <a href="relazione.pdf" class="s-navigation--item"><fmt:message key="navbar.buttons.relazione" /></a>
                    </li>

                    <li class="responsive-disappear">
                        <a href="downloads/downloads.jsp" class="s-navigation--item"><fmt:message key="navbar.buttons.codice" /></a>
                    </li>
                </ol>

                <form action="forum.jsp" class="s-topbar--searchbar responsive-disappear" onmousedown="showRecents()">



                    <div class="s-topbar--searchbar--input-group">
                        <input name="tag" autocomplete="off" type="text" placeholder="<fmt:message key="navbar.searchbar.placeholder" />" maxlength="100" class="s-input s-input__search">
                        <i class="fa-solid fa-magnifying-glass s-input-icon s-input-icon__search svg-icon iconSearch" width="18" height="18""></i>
                    </div>
                </form>

                <ol class="s-topbar--content">
                    <li><a href="#" class="s-topbar--item s-btn s-btn__icon s-btn__muted d-none sm:d-inline-flex js-searchbar-trigger" role="button" aria-label="Search" aria-haspopup="true" aria-controls="search" title="Click to show search"><svg aria-hidden="true" class="svg-icon iconSearch" width="18" height="18" viewBox="0 0 18 18"><path d="m18 16.5-5.14-5.18h-.35a7 7 0 1 0-1.19 1.19v.35L16.5 18l1.5-1.5ZM12 7A5 5 0 1 1 2 7a5 5 0 0 1 10 0Z"></path></svg></a></li>
                    
                    
                    <%
                    
                        if (session.getAttribute("session_exists") != null)
                        {
                    
                    %>
                            <li><div class="s-topbar--item"><i class="fa-solid fa-user"></i> <a style="margin-left: 3px" href="profile.jsp?user=<%= session.getAttribute("username") %>"><%= session.getAttribute("username") %></a></div></li>
                            <li><a href="/logout" class="s-topbar--item s-topbar--item__unset s-btn s-btn__filled ws-nowrap js-gps-track" >Logout</a></li>

                    <%
                        }
                        else
                        {
                    %>
                    
                            <li><a href="login.jsp" class="s-topbar--item s-topbar--item__unset s-btn s-btn__filled ws-nowrap js-gps-track" >Login</a></li>
                            <li><a href="register.jsp" class="s-topbar--item s-topbar--item__unset ml4 s-btn s-btn__primary ws-nowrap"> <fmt:message key="navbar.loginbuttons.register" /> </a></li>
                        
                    <%
                        }
                    %>

                </ol>


            </div>
        </header>


        <!--fake header for recents-->

        <header class="s-topbar ps-fixed t0 l0 responsive-disappear" style="margin-top: 35px !important; background: transparent; border-top: 0; box-shadow: none">
            <!--NavBar Section-->
            <div class="s-topbar--container" >
                
                <a href="index.jsp" class="s-topbar--logo" style="visibility: hidden;">
                    <span class="brand"> <fmt:message key="AppName" /> </span>
                    
                </a>

                <ol class="s-navigation" style="visibility: hidden;">

                    <li class="responsive-disappear">
                        <a href="forum.jsp" class="s-navigation--item">Forum</a>
                    </li>

                    <li class="responsive-disappear">
                        <a href="relazione.pdf" class="s-navigation--item">Relazione</a>
                    </li>

                    <li class="responsive-disappear">
                        <a href="#" class="s-navigation--item">Codice</a>
                    </li>
                </ol>

                <div class="s-topbar--searchbar responsive-disappear" style="background-color: white;">
                    



                    <div id="recent-searches" class="s-topbar--searchbar--input-group" style="display: none" ">
                        

                        <div class="s-input s-input__search">  Di recente hai cercato:

                        <%

                            
                            Cookie[] cookies = null;
                            
                            // Get an array of Cookies associated with the this domain
                            cookies = request.getCookies();
                            
                            if( cookies != null ) 
                            {
                            
                                for (int i = 0; i < cookies.length; i++) 
                                {

                                    if ((cookies[i].getName()).equals("recents"))
                                    {


                        %>
                        
                                        <a href="forum.jsp?tag=<%= cookies[i].getValue() %>"><%= cookies[i].getValue() %></a>
                        
                        <%
                                    }
                                }
                            }
    
                        %>
                        
                        
                        
                        </div>
                        <i class="fa-solid fa-xmark s-input-icon s-input-icon__search svg-icon iconSearch" style="pointer-events: all;" onclick="removeRecents()"></i>
                    </div>

                    

                </div>

                <ol class="s-topbar--content" style="visibility: hidden;">
                    <li><a href="#" class="s-topbar--item s-btn s-btn__icon s-btn__muted d-none sm:d-inline-flex js-searchbar-trigger" role="button" aria-label="Search" aria-haspopup="true" aria-controls="search" title="Click to show search"><svg aria-hidden="true" class="svg-icon iconSearch" width="18" height="18" viewBox="0 0 18 18"><path d="m18 16.5-5.14-5.18h-.35a7 7 0 1 0-1.19 1.19v.35L16.5 18l1.5-1.5ZM12 7A5 5 0 1 1 2 7a5 5 0 0 1 10 0Z"></path></svg></a></li>
                    
                    
                    <%
                    
                        if (session.getAttribute("session_exists") != null)
                        {
                    
                    %>
                            <li><div class="s-topbar--item"><i class="fa-solid fa-user"></i> <a style="margin-left: 3px" href="profile.jsp?user=<%= session.getAttribute("username") %>"><%= session.getAttribute("username") %></a></div></li>
                            <li><a href="/logout" class="s-topbar--item s-topbar--item__unset s-btn s-btn__filled ws-nowrap js-gps-track" >Logout</a></li>

                    <%
                        }
                        else
                        {
                    %>
                    
                            <li><a href="login.jsp" class="s-topbar--item s-topbar--item__unset s-btn s-btn__filled ws-nowrap js-gps-track" >Login</a></li>
                            <li><a href="register.jsp" class="s-topbar--item s-topbar--item__unset ml4 s-btn s-btn__primary ws-nowrap">Registrati</a></li>
                        
                    <%
                        }
                    %>

                </ol>


            </div>
        </header>

    </body>
</html>