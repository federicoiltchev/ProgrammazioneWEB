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
		
		getServletContext().setAttribute("SessionCounter",0);
	}
	
	protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{

        String pwd = request.getParameter("pwd");

        if (pwd.equals("bottoni"))
        {

            HttpSession session=request.getSession(true);
            
            
            ServletContext ctx=getServletContext();
            
            int sessioncounter = (int) ctx.getAttribute("SessionCounter");
            
            if (session.isNew())
            {
                sessioncounter++;
                ctx.setAttribute("SessionCounter",sessioncounter);
            }



            response.sendRedirect("navigation");
        }
        else
        {
            response.sendRedirect("errore.html");
        }
	
	}



}