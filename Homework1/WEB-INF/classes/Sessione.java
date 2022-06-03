import javax.servlet.*; 
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class Sessione extends HttpServlet 
{
	HashMap<String, String> books = new HashMap<String, String>();

	public void init()
{
 books.put( "pomodori", "200g" );	
 books.put( "caramelle", " busta" );
 books.put( "latte", "cartone" );
 books.put( "gelato", "vaschetta" );
 books.put( null, null);
 }
		
protected void doPost(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException
{
	String storia = request.getParameter("storia");
	HttpSession session = request.getSession(true);
	session.setAttribute(storia,books.get(storia));
	String articolo = request.getParameter("articolo");
	String quantita = request.getParameter("quantita");
	session.setAttribute(articolo, quantita);
	response.setContentType("text/html");
	PrintWriter out = response.getWriter();

	out.println("<head>");
	out.println("<title>Benvenuto alla sessione</title>");
	out.println("<head>");
	out.println("<body>");
	out.println("<p>Hey, sei nella sessione.<p>");
	out.println("<p>Hai aggiunto manualmente questo articolo: " + articolo + "<p>");
	out.println("<p>Hai selezionato questo articolo: "+ storia + ".<p>");

	out.println( "<p>L'ID della tua sessione e': " + session.getId() + "<br />" );

 	out.println("Questa  " + ( session.isNew() ? "e'" : "non e'" ) +" una nuova sessione <br/>" );
	out.println("La sessione e' stata creata il: " + new Date(session.getCreationTime())+ "<br/>");
	out.println("Il tuo ultimo accesso e' stato alle:" + new Date(session.getLastAccessedTime()) + "<br/>");
	
	out.println("<p><a href = \"SessioneScegliStoria.html\">" + "Clicca qui per aggiungere un'altro articolo </a></p>");
	out.println("<p><a href = \"sessions\">" + "Clicca qui per andare alla tua lista della spesa</a></p>");
	out.print("</html>");

	out.close();
}
protected void doGet( HttpServletRequest request,HttpServletResponse response )
 	throws ServletException, IOException
 {
 
 	HttpSession session = request.getSession( false );

 	Enumeration<String> valueNames;
	if (session != null)
		valueNames = session.getAttributeNames();
	else
		valueNames = null;
	PrintWriter out = response.getWriter();
	response.setContentType("text/html");
	
	out.println("<head>");
	out.println("<title>Suggerimenti</title>");
	out.println("</head>");
	
	out.println("<body>");
	if (valueNames != null && valueNames.hasMoreElements())
	{
		out.println("<h1>Lista della Spesa</h1>");
		out.println("<p>");

		String name, value;
		while (valueNames.hasMoreElements())
		{
			name = valueNames.nextElement();
			value = session.getAttribute(name).toString();	
			out.println( name + " " + value + "<br/>");
		}
		
		out.println("</p>");
	}
	else {
		out.println("<h1> La tua lista e' vuota, non hai selezionato nessun articolo</h1>");	
	}
out.println("<p><a href = \"SessioneScegliStoria.html\">" + "Clicca qui per tornare alla home </a></p>");
out.println("</body>");
out.println("</html>");
	out.close();
	}
}






















