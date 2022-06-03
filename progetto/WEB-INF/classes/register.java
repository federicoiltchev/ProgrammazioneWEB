

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import jakarta.servlet.annotation.*;
import java.sql.*;
import java.util.Date;
import java.util.Calendar;
import java.text.SimpleDateFormat;




@WebServlet("/register")
public class register extends HttpServlet
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
        String cpwd = request.getParameter("confirmpassword");
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");



        

	
        if (username == null || pwd == null || cpwd == null || username.equals("") || pwd.equals("") || cpwd.equals(""))
        {
            response.sendRedirect("errore.jsp?messaggio='Dati obbligatori mancanti nel form'");
            return;
        }

        if (nome.equals("")) { nome = null; }
        if (cognome.equals("")) { cognome = null; }


        if (!pwd.equals(cpwd))
        {
            response.sendRedirect("errore.jsp?messaggio='Le password non combaciano'");
            return;
        }



        try 
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://178.79.187.9:3306/progetto_pweb_2122", "alessio", "tommasofedericoalessio");

            Statement stmt = conn.createStatement();
            ResultSet DB_checkusername = stmt.executeQuery("SELECT * FROM `UTENTE` WHERE username='" + username + "'");

            while(DB_checkusername.next())
            {
                response.sendRedirect("errore.jsp?messaggio='username già esistente'");
                return;
            }

            String data_oggi = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

            BCrypt BCrypt = new BCrypt();

            PreparedStatement ps = conn.prepareStatement("INSERT INTO `UTENTE`(`nome`, `cognome`, `username`, `data_reg`, `password`) VALUES (?,?,?,?,?)");
            ps.setString(1, nome);
            ps.setString(2, cognome);
            ps.setString(3, username);
            ps.setString(4, data_oggi);
            ps.setString(5, BCrypt.hashpw(pwd, BCrypt.gensalt(12)));
            int row_affected = ps.executeUpdate();


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