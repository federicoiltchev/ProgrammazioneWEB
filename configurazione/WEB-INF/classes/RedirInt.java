import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;

public class RedirInt extends HttpServlet {
	private int counter;
	
	
		
	protected void doGet(HttpServletRequest request,HttpServletResponse response)
		throws ServletException, IOException
	{
	RequestDispatcher disp=request.getServletContext().getRequestDispatcher("/alias1");
	disp.include(request,response);
	//disp.forward(request,response);
	
	}
}