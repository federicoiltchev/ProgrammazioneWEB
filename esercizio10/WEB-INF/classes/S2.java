import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;

public class S2 extends HttpServlet {
	
	
	
	
	protected void doGet(HttpServletRequest request,HttpServletResponse response)
		throws ServletException, IOException
	{
	response.setContentType("text/html;charset=UTF-8");
	PrintWriter out=response.getWriter();
	
	// uso del SERVLET CONFIG
	ServletConfig cfg=this.getServletConfig();
	
	// uso del SERVLET CONTEXT
	ServletContext ctx=cfg.getServletContext();
	
	out.println("<html><body>");
	
	int appcounter=(int) ctx.getAttribute("AppCounter");
	
	out.println("Accessi di applicazione "+appcounter+"<br>");
    appcounter++;
	ctx.setAttribute("AppCounter",appcounter);
	out.println("Sei nella servlet: "+cfg.getServletName()+"<br>");
	out.println("<a href=\"/configurazione/\">Torna alla home </a><br>");
	out.println("</body></html>");
	out.close();
	}
}