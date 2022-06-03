

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import jakarta.servlet.annotation.*;
import java.sql.*;
import java.util.Date;
import java.util.Calendar;
import java.text.SimpleDateFormat;




@WebServlet("/answer")
public class answer extends HttpServlet
{
	
    

	/* quando la servlet viene caricata in memoria init() viene eseguito */

	public void init()
	{
	}
	
    @Override
	protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{

        
        
        String answer = request.getParameter("answer");
        int post_id = Integer.parseInt(request.getParameter("post_id"));
	
        if (answer == null || answer.equals(""))
        {
            response.sendRedirect("errore.jsp?messaggio='Dati obbligatori mancanti nel form'");
            return;
        }

        HttpSession session=request.getSession();

        try 
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://178.79.187.9:3306/progetto_pweb_2122", "alessio", "tommasofedericoalessio");


            java.util.Date date = new java.util.Date();
            java.sql.Timestamp timestamp = new java.sql.Timestamp(date.getTime());
            

            PreparedStatement ps = conn.prepareStatement("INSERT INTO `RISPOSTA`(`like_num`, `dislike_num`, `username_creatore`, `idPost`, `data_creazione`, `contenuto`) VALUES (?,?,?,?,?,?)");
            ps.setObject(1, null);
            ps.setObject(2, null);
            ps.setString(3, (String) session.getAttribute("username"));
            ps.setInt(4, post_id);
            ps.setTimestamp(5, timestamp);
            ps.setString(6, answer);
            int row_affected = ps.executeUpdate();

            response.sendRedirect("post.jsp?id=" + post_id);
        }
        catch (Exception e)
        {
            response.sendRedirect("errore.jsp?messaggio='" + e + "'");
            return;
        }
        
        


    
    
    }



}