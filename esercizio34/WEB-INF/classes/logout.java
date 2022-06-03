import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import jakarta.servlet.annotation.*;


@WebServlet("/logout")
public class logout extends HttpServlet
{
	
    

	/* quando la servlet viene caricata in memoria init() viene eseguito */

	public void init()
	{
		
	}
	
	protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session=request.getSession();
        session.invalidate();
        response.sendRedirect("index.html");
        return;
	}



}