import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import jakarta.servlet.annotation.*;

@WebServlet("/navigation")
public class navigation extends HttpServlet 
{
	
    

	

	public void init()
	{

	}
	
	protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{
		

		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
        response.setHeader("Pragma", "no-cache"); 
        response.setHeader("Expires", "0");

		

		HttpSession session = request.getSession(false);

		


		/* Attenzione al return! è necessario altrimenti il resto del codice viene eseguito e sono guai.. */

    	if (session == null) { response.sendRedirect("errore.html"); return; }




		response.setContentType("text/html");
		
		String username = (String) session.getAttribute("username");


        PrintWriter out = response.getWriter();
        out.println("<html><body>");

		if (username.equals("admin")) { out.println("Ciao, " +  username + ", sei admin!"); }
		else { out.println("Ciao, " +  username + " come stai?"); }

        
        out.println("<a href='logout'>Esci e termina la sessione (dovrai loggare di nuovo!)</a>");
        out.println("</body></html>");

	}



}