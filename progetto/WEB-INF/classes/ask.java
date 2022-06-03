

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import jakarta.servlet.annotation.*;
import java.sql.*;
import java.util.Date;
import java.util.Calendar;
import java.text.SimpleDateFormat;




@WebServlet("/ask")
public class ask extends HttpServlet
{
	
    

	/* quando la servlet viene caricata in memoria init() viene eseguito */

	public void init()
	{
	}
	
    @Override
	protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{

        
        
        String[] tags = request.getParameterValues("tag");
        String titolo = request.getParameter("titolo");
        String contenuto = request.getParameter("contenuto");
        String premium = request.getParameter("premium");


        

        if (titolo == null || contenuto == null || titolo.equals("") || contenuto.equals("") )
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
            

            PreparedStatement ps = conn.prepareStatement("INSERT INTO `POST`(`like`, `dislike`, `premium`, `utente_creatore`, `data_creazione`, `titolo`, `contenuto`) VALUES (?,?,?,?,?,?,?)");
            ps.setObject(1, null);
            ps.setObject(2, null);
            if (premium == null || premium.equals("n")) { ps.setInt(3,0); }
            else { ps.setInt(3,1); }
            ps.setString(4, (String) session.getAttribute("username"));
            ps.setTimestamp(5, timestamp);
            ps.setString(6, titolo);
            ps.setString(7, contenuto);
            int row_affected = ps.executeUpdate();


            int postId = 0;

            Statement stmt = conn.createStatement();
            ResultSet DB_getNextPostId = stmt.executeQuery("SELECT MAX(`id`) FROM `POST`");

            while (DB_getNextPostId.next())
            {
                postId = Integer.parseInt(DB_getNextPostId.getString(1));
            }


            if (tags != null)
            {

                for (String t : tags)
                {

                    PreparedStatement ps2 = conn.prepareStatement("INSERT INTO `POST_TAG`(`postId`, `tag`) VALUES (?,?)");
                    ps2.setInt(1, postId);
                    ps2.setString(2, t);
                    row_affected = ps2.executeUpdate();


                }
            }


            response.sendRedirect("forum.jsp?q=all");
        }
        catch (Exception e)
        {
            response.sendRedirect("errore.jsp?messaggio='" + e + "'");
            return;
        }

        
        
        


    
    
    }



}