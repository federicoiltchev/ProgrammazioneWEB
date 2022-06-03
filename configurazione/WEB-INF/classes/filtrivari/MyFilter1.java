package filtrivari;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;

public class MyFilter1 implements Filter {

	FilterConfig filterConfig = null;

	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
	}

	public void destroy() {
	}

	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
			throws IOException, ServletException {
		servletResponse.setContentType("text/html");
		
		PrintWriter out = servletResponse.getWriter();
		out.println("Messaggio inserito dal filtro MyFilter1<br>");
		out.println("Init Parameter: " + filterConfig.getInitParameter("Mio-param"));
		out.println("<br/><br/>Request parameters:<br/>");
		Enumeration<String> parameterNames = servletRequest.getParameterNames();
		if (parameterNames.hasMoreElements()) {
			while (parameterNames.hasMoreElements()) {
				String name = parameterNames.nextElement();
				String value = servletRequest.getParameter(name);
				out.println("name:" + name + ", value: " + value + "<br/>");
				if (name.equals("nomeutente")&&value.equals("Novella")) out.println("Sei l'amministratore di questa app<br><br>");
			}
		} else {
			out.println("---None---<br/>");
		}
		out.println("<br/>Start Regular Content:<br/><hr/>");
		filterChain.doFilter(servletRequest, servletResponse);
		out.println("<br/><hr/>End Regular Content:<br/>");

	}

}