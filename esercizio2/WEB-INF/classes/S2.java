

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;

public class S2 extends HttpServlet {
	
	protected void doGet(HttpServletRequest request,HttpServletResponse response)
		throws ServletException, IOException
	{
    HttpSession session=request.getSession(true);		
	response.setContentType("text/html");
	PrintWriter out=response.getWriter();
	out.println("<html><body>");
	
	
	ServletContext ctx=getServletContext();
	int appcounter = (int) ctx.getAttribute("AppCounter");
	out.println("Risponde la servlet S2<br>");
	out.println("Il valore del contatore di applicazione vale: "+appcounter + "<br>");
	appcounter++;
	ctx.setAttribute("AppCounter",appcounter);
	
	
	int sessioncounter = (int) ctx.getAttribute("SessionCounter");
	out.println("Il valore del contatore di sessioni vale: "+sessioncounter + "<br>");
	
	if (session.isNew())
			{
				sessioncounter++;
				ctx.setAttribute("SessionCounter",sessioncounter);
			}
	
	
	out.println("Messaggio di benvenuto");
	out.println("</html></body>");
	out.close();
	}
}