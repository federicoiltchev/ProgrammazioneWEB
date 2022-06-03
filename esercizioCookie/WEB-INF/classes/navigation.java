import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import jakarta.servlet.annotation.*;
import java.util.*;
import jakarta.servlet.http.Cookie; 

@WebServlet("/navigation")
public class navigation extends HttpServlet 
{
	
    

	

	public void init()
	{
		getServletContext().setAttribute("Alessio", 0); //Il servlet context è condiviso tra tutte le servlet
        getServletContext().setAttribute("Tommaso", 0);
		getServletContext().setAttribute("Federico", 0); 
        getServletContext().setAttribute("Matteo", 0);
		getServletContext().setAttribute("Lorenzo", 0);
	}
	
	protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{
		Cookie ck[] = request.getCookies(); // ritorna un array di cookie

		if (ck != null)
		{
			boolean cookieExists = false;

			for(int i = 0; i < ck.length; i++)
			{  
				if (ck[i].getName().equals("preferenza"))
				{
					cookieExists = true;
				}
			}  		
			if (cookieExists) { response.sendRedirect("index.html"); return; }

		}



		String voto = request.getParameter("candidati");
		if (voto == null) { response.sendRedirect("index.html"); return; }


		getServletContext().setAttribute(voto, (int)getServletContext().getAttribute(voto) + 1);


		Cookie co = new Cookie("preferenza", voto);
		response.addCookie(co);
		response.sendRedirect("statistiche");


	
	}



}