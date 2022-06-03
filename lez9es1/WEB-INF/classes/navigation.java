import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import jakarta.servlet.annotation.*;

@WebServlet("/navigation")
public class navigation extends HttpServlet 
{
	
    

	/* quando la servlet viene caricata in memoria init() viene eseguito */

	public void init()
	{

	}
	
	protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{		

		HttpSession session=request.getSession(false);
		response.setContentType("text/html");

        if (session == null) { response.sendRedirect("errore.html"); return; }

		
		ServletContext ctx=getServletContext();


        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("Numero di sessioni generate: " +  " " + (int) ctx.getAttribute("SessionCounter"));
        out.println("<a href='logout'>Esci e termina la sessione (dovrai loggare di nuovo!)</a>");
        out.println("</body></html>");

	}



}