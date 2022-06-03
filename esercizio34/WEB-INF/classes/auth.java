import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import jakarta.servlet.annotation.*;


@WebServlet("/autenticazione")
public class auth extends HttpServlet
{
	
    

	/* quando la servlet viene caricata in memoria init() viene eseguito */

	public void init()
	{
	}
	
    @Override
	protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{

        String pwd = request.getParameter("pwd");
        String username = request.getParameter("username");

        if (pwd.equals("bottoni"))
        {

            HttpSession session = request.getSession(true);
            
            session.setAttribute("username", username);



            response.sendRedirect("navigation");
        }
        else
        {
            response.sendRedirect("errore.html");
        }
	
	}



}