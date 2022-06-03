

<%


    String langChoice = request.getParameter("lc");

    switch(langChoice) 
    {
        case "en":
            session.setAttribute("language", "en");
            response.sendRedirect("index.jsp");
            break;
        case "fr":
            session.setAttribute("language", "fr");
            response.sendRedirect("index.jsp");
            break;
        case "es":
            session.setAttribute("language", "es");
            response.sendRedirect("index.jsp");
            break;
        case "de":
            session.setAttribute("language", "de");
            response.sendRedirect("index.jsp");
            break;
        case "sicilian":
            session.setAttribute("language", "sicilian");
            response.sendRedirect("index.jsp");
            break;
        default:
            session.setAttribute("language", "it");
            response.sendRedirect("index.jsp");
            break;
    }

    return;
      


%>