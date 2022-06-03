

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import jakarta.servlet.annotation.*;
import java.sql.*;
import java.util.Date;
import java.util.Calendar;
import java.text.SimpleDateFormat;




@WebServlet("/login")
public class login extends HttpServlet
{
	
    

	/* quando la servlet viene caricata in memoria init() viene eseguito */

	public void init()
	{
	}
	
    @Override
	protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{

        
        
        String username = request.getParameter("username");
        String pwd = request.getParameter("password");



        

	
        if (username == null || pwd == null || username.equals("") || pwd.equals(""))
        {
            response.sendRedirect("errore.jsp?messaggio='Dati obbligatori mancanti nel form'");
            return;
        }

        try 
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://178.79.187.9:3306/progetto_pweb_2122", "alessio", "tommasofedericoalessio");

            Statement stmt = conn.createStatement();
            ResultSet DB_checkusername = stmt.executeQuery("SELECT * FROM `UTENTE` WHERE username='" + username + "'");

            boolean userExists = false;
            String password_hash = null;

            while(DB_checkusername.next())
            {
                userExists = true;
                password_hash = DB_checkusername.getString(5);
            }

            if (!userExists) 
            {
                response.sendRedirect("errore.jsp?messaggio='L'utente non esiste. Hai inserito il corretto username?'");
                return;
            }

            BCrypt BCrypt = new BCrypt();

            if (!(BCrypt.checkpw(pwd, password_hash)))
            {
                response.sendRedirect("errore.jsp?messaggio='Password non corretta'");
                return;
            }



            HttpSession session=request.getSession();
            session.setAttribute("session_exists", true);
            session.setAttribute("username", username);

            response.sendRedirect("index.jsp");
        }
        catch (Exception e)
        {
            response.sendRedirect("errore.jsp?messaggio='" + e + "'");
            return;
        }
        
        


    
    
    }



}