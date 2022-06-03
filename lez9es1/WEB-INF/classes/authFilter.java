import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.Filter;


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


        HttpSession session = ((HttpServletRequest) request).getSession(false);


        // settare l'header a livello HTTP per non fare uso di cache

        ((HttpServletResponse) response).setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
        ((HttpServletResponse) response).setHeader("Pragma", "no-cache"); 
        ((HttpServletResponse) response).setHeader("Expires", "0"); 
        
        
        if (session == null) { chain.doFilter(request, response); } // chain.doFilter semplicemente fa continuare la richiesta => quindi non blocca nulla
        else { ((HttpServletResponse) response).sendRedirect("navigation"); }
    }
  
    public void destroy() {}
}