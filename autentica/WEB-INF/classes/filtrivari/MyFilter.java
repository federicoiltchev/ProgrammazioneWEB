package filtrivari;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
//import org.apache.commons.lang3.*;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.*;
import java.util.HashSet;
import java.util.HashMap;

public class MyFilter implements Filter {

	FilterConfig filterConfig = null;
	HashSet<String> utenti = new HashSet<String>();
	HashMap<String, String> lista_utenti = new HashMap<String, String>();
	int contatore;

	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
		contatore = 0;
		lista_utenti.put("Novella","Novella");
		lista_utenti.put("Federico","Federico");
		lista_utenti.put("Tommaso","Tommaso");
		lista_utenti.put("Alessio","Alessio");
		lista_utenti.put("Matteo","Matteo");
	}

	public void destroy() {
	}

	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
			throws IOException, ServletException {
		HttpServletRequest req=(HttpServletRequest)servletRequest;
		HttpServletResponse resp=(HttpServletResponse)servletResponse;
		
		resp.setHeader("Cache-Control", "no-cache, no-store");
    
        resp.setDateHeader("Expires", 0);

		HttpSession session=req.getSession(false);
		
		String r=req.getRequestURI();
		
		servletResponse.setContentType("text/html");
		PrintWriter out = servletResponse.getWriter();
			
		if ((session!=null)||(r.endsWith(".html"))) //o l'utente ha i diritti, o siamo nel form
			{
			out.println("Preprocessing del filtro su risorsa protetta o html<br>");
			out.println("URI: "+r+"<br>");
		
			filterChain.doFilter(servletRequest, servletResponse);
			out.println("Postprocessing del filtro su html<br>");
			out.println("</body></html>");
			out.close();
			out.println("Il contatore è: " + contatore);
			
			}
		 
			//se la risorsa non è il form e non ho una sessione aperta devo
			//controllare le credenziali, chiedendole con il form o verificandole se sono 
			//state inserite
			/*else if (( !"Novella".equals(req.getParameter("nomeutente")) || !"Novella".equals(req.getParameter("pwd"))){
				resp.sendRedirect("/autentica/login.html");
				out.println("Il contatore è: " + contatore);
			}*/
			//controlla se utente dato in input è in lista_utenti
			else if ((lista_utenti.get(req.getParameter("nomeutente"))==null) || (!(lista_utenti.get(req.getParameter("nomeutente")).equals(req.getParameter("pwd"))))) {
				//String pw = lista_utenti.get(req.getParameter("nomeutente"))
				resp.sendRedirect("/autentica/login.html");
			}
			 else {	
					out.println("Preprocessing: Il filtro sta aprendo una sessione <br>");
					session=req.getSession(true);

					filterChain.doFilter(servletRequest, servletResponse);
					out.println("Postprocessing: fine della chiamata dopo apertura della sessione");
					out.println("</body></html>");
					out.close();
					//incrementa se login un utente nuovo
					if (!utenti.contains(req.getParameter("nomeutente"))){
						String user = req.getParameter("nomeutente");
						contatore++;
						utenti.add(user);
						session.setAttribute(user, req.getParameter("pwd"));
						out.println("Il contatore è stato incrementato");
					}
					out.println("Il contatore è: " + contatore);
			
				}
				
			
					
	}
	
}
	
	