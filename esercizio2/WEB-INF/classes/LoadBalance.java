// import jakarta.servlet.*;
// import jakarta.servlet.http.*;
// import java.io.*;


// public class LoadBalance extends HttpServlet {
// 	private int counter;
// 	public void init()
// 	{
// 		counter=0;
// 		getServletContext().setAttribute("AppCounter",0);
// 		getServletContext().setAttribute("SessionCounter",0);
// 	}
	
// 	protected void doGet(HttpServletRequest request,HttpServletResponse response)
// 		throws ServletException, IOException
// 	{
// 	HttpSession session=request.getSession(true);
// 	response.setContentType("text/html");
// 	PrintWriter out=response.getWriter();
// 	out.println("<html><body>");
	
	
// 	out.println("Il valore del contatore di bilancia vale: "+counter + "<br>");
// 	counter++;
// 	if (counter%2==0)
// 		out.println("<a href=\"/undici/alias1\"> link1 </a><br>");
// 	else
// 		out.println("<a href=\"/undici/alias2\"> link2 </a><br>");
	
// 	ServletContext ctx=getServletContext();
// 	int appcounter = (int) ctx.getAttribute("AppCounter");
// 	out.println("Il valore del contatore di applicazione vale: "+appcounter + "<br>");
// 	appcounter++;
// 	ctx.setAttribute("AppCounter",appcounter);
	
// 	int sessioncounter = (int) ctx.getAttribute("SessionCounter");
// 	out.println("Il valore del contatore di sessioni vale: "+sessioncounter + "<br>");
	
// 	if (session.isNew())
// 			{
// 				sessioncounter++;
// 				ctx.setAttribute("SessionCounter",sessioncounter);
// 			}
	
	
	
	
	
	
// 	out.println("Messaggio di benvenuto");
// 	out.println("</html></body>");
// 	out.close();
// 	}
// }

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;


public class LoadBalance extends HttpServlet {
	private int counter;

	/* quando la servlet viene caricata in memoria init() viene eseguito */

	public void init()
	{
		counter=0;
		getServletContext().setAttribute("AppCounter",0);
		getServletContext().setAttribute("SessionCounter",0);
	}
	
	protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{

		

		HttpSession session=request.getSession(true);
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Prova</title>");
		out.println("</head>");
		out.println("<body>");
		
		
		out.println("Il valore del contatore di bilancia vale: "+counter + "<br>");
		counter++;
		if (counter%2==0)
			out.println("<a href=\"/undici/alias1\"> link1 </a><br>");
		else
			out.println("<a href=\"/undici/alias2\"> link2 </a><br>");
		
		ServletContext ctx=getServletContext();
		int appcounter = (int) ctx.getAttribute("AppCounter");
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
		
		out.println("</html></body>");
		out.close();
	}
}