import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;

public class LoadBalance extends HttpServlet {
	private int counter;
	
	
	public void init()
	{
	counter=0;
	getServletContext().setAttribute("AppCounter",0);
	}
	
	protected void doGet(HttpServletRequest request,HttpServletResponse response)
		throws ServletException, IOException
	{
	response.setContentType("text/html;charset=UTF-8");
	PrintWriter out=response.getWriter();
	
	// uso del SERVLET CONFIG
	ServletConfig cfg=this.getServletConfig();
	String nomeservlet=cfg.getServletName();
	out.println("<html><body>");
	out.println("Il servlet name \u00E8: "+nomeservlet+"<br>");
	String anno=cfg.getInitParameter("year");
	out.println("Servlet realizzata nell'anno: "+anno+"<br>");
	
	// uso del SERVLET CONTEXT
	ServletContext ctx=cfg.getServletContext();
	
	String paese=ctx.getInitParameter("country");
	out.println("Applicazione realizzata in: "+paese+"<br>");
	
	// contatore servlet
	
	
	out.println("Il contatore della servlet vale: "+counter+"<br>");
	out.println("Redirezione con URL REWRITING usando i seguenti link: <br>"); 
	
	if (counter%2==0) //even number
		out.println ("<a href=\"/configurazione/alias1\"> link1 </a><br>");
	else
		out.println ("<a href=\"/configurazione/alias2\"> link2 </a><br>");
	
	counter++;
	int appcounter=(int) ctx.getAttribute("AppCounter");
	
	out.println("Accessi di applicazione "+appcounter+"<br>");
    appcounter++;
	ctx.setAttribute("AppCounter",appcounter);
	out.println("</body></html>");
	out.close();
	}
}