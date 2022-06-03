import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.Filter;
import jakarta.servlet.http.Cookie; 


/*

Il filtro si occupa della pagina di autenticazione: se l'utente è loggato è conveniente non mostrare di nuovo la pagina di login

*/

@WebFilter("/index.html")
public class authFilter implements Filter 
{
  
    public void init(FilterConfig filterConfig) throws ServletException
    {
        // 
    }
  
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException
    {

        // settare l'header a livello HTTP per non fare uso di cache

        ((HttpServletResponse) response).setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
        ((HttpServletResponse) response).setHeader("Pragma", "no-cache"); 
        ((HttpServletResponse) response).setHeader("Expires", "0"); 
        

        Cookie ck[] = ((HttpServletRequest)request).getCookies(); // ritorna un array di cookie
        
        
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

		    if (cookieExists) { ((HttpServletResponse) response).sendRedirect("statistiche"); return; }
        }
        else { chain.doFilter(request, response); }



    }
  
    public void destroy() {}
}