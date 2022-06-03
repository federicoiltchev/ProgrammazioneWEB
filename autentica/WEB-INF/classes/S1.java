import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;

public class S1 extends HttpServlet {

	
	
	
	
	protected void doGet(HttpServletRequest request,HttpServletResponse response)
		throws ServletException, IOException
	{
	response.setContentType("text/html;charset=UTF-8");
	PrintWriter out=response.getWriter();
	
	
	out.println("<html><body>");
	out.println("Per arrivare qui devi esserti autenticato correttamente! <br>");
	out.println("SERVLET PROTETTA <br>");

	//out.println("<a "+ title="Torna al login" + href="/autentica/login.html" </a>);
	out.println("<p><a href = \"/autentica/login.html\"> Home </a></p>");
	//out.println("</body></html>");
	//out.close();
	}
}