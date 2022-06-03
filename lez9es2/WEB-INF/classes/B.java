import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import jakarta.servlet.annotation.*;


@WebServlet("/B")
public class B extends HttpServlet
{
	
    

	/* quando la servlet viene caricata in memoria init() viene eseguito */

	public void init()
	{
	}
	
	protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
     	response.setHeader("Pragma", "no-cache"); 
        response.setHeader("Expires", "0"); 

        HttpSession session=request.getSession(true);
        
        response.setContentType("text/html");
        
        ServletContext ctx=getServletContext();    
        int ac = (int) ctx.getAttribute("AccessCounter");
        ac++;
        ctx.setAttribute("AccessCounter",ac);
        
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h3>Io sono colui che sono: B</h3>");

        if (ac > 10)
        {
            out.println("Bravo, questo è il tuo " + ac + " accesso in questo esercizio..sai come sprecare il tempo");
        }
        else
        {
            out.println("Bravo, questo è il tuo " + ac + " accesso in questo esercizio");
        }

        out.println("<a href='A'>Vai a A</a>");

        
        out.println("</body></html>");

    
	
	}
}