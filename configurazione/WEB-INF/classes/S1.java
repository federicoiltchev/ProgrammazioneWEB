import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;

public class S1 extends HttpServlet {

	
	
	
	
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
	
	Integer appcounter=(Integer) ctx.getAttribute("AppCounter");
	
	if (appcounter!=null)
		{
		out.println("Accessi di applicazione "+appcounter+"<br>");
		appcounter++;
		ctx.setAttribute("AppCounter",appcounter);
		out.println("Sei nella servlet: "+cfg.getServletName()+"<br>");
		out.println("<a href=\"/configurazione/\">Torna alla home </a><br>");
		}
	else out.println("Il parametro di applicazione non \u00E8 stato definito<br>");
	
	out.println("</body></html>");
	out.close();
	}
}