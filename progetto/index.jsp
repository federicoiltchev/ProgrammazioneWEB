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

    <jsp:include page="navbar.jsp" />


    <section id="hero">
        <div class="landing-container">
          <div class="row">

                

                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5">
                    <img src="images/coders.png" class="img-fluid img-landing" alt="img-landing">
                </div>

                

                <div class="col-md-7 content-box hero-content content-landing">
                    <p class="main-title"><fmt:message key="AppName" /></p>
                    <p><fmt:message key="index.landing.text" /></p>
                    <a href="forum.jsp" class="btn btn-regular"><fmt:message key="index.landing.button" /></a>
                </div>

                <div class="mousedown-container responsive-disappear">
                    <div class="mousedown">
                        <div class="wheel"></div>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <section id="marketing">
        <div class="container">
            <div class="row">
                <div class="col-md-5">
                    <div class="content-box">
                    <h2><fmt:message key="index.presentation.title" /></h2>
                    <br>
                    <p><fmt:message key="index.presentation.description" /> </p>
                </div>
            </div>
                <div class="col-md-7">
                    <img src="images/iphone.png" class="img-fluid" alt="Demo image">
                </div>
            </div>
        </div>
    </section>


    <jsp:include page="footer.jsp" />
</body>
</html>