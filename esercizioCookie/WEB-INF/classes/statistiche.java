import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.Cookie; 

@WebServlet("/statistiche")
public class statistiche extends HttpServlet
{
	
    

	/* quando la servlet viene caricata in memoria init() viene eseguito */

	public void init(){}
	
    @Override
	protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{

        Cookie ck[] = request.getCookies(); // ritorna un array di cookie
		
		if (ck == null) { response.sendRedirect("index.html"); return; }
		
		boolean cookieExists = false;
		String voto = null;

		for(int i = 0; i < ck.length; i++)
		{  
 			if (ck[i].getName().equals("preferenza"))
			{
				cookieExists = true;
				voto = ck[i].getValue();
			}
		}

		if (!cookieExists) { response.sendRedirect("index.html"); return; }

		PrintWriter out = response.getWriter();
        out.println("<html><body>");

		out.println("<h1> Grazie per il tuo voto. </h1>");
		out.println("Hai votato: " +  voto);

		out.println("<h2> Numero di voti </h2>");
		out.println("Alessio: " + (int)getServletContext().getAttribute("Alessio") + "<br>");
		out.println("Tommaso: " + (int)getServletContext().getAttribute("Tommaso") + "<br>");
		out.println("Federico: " + (int)getServletContext().getAttribute("Federico") + "<br>");
		out.println("Matteo: " + (int)getServletContext().getAttribute("Matteo") + "<br>");
		out.println("Lorenzo: " + (int)getServletContext().getAttribute("Lorenzo") + "<br>");

        out.println("</body></html>");
		



        
	
	}



}