import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import jakarta.servlet.annotation.*;
import java.sql.*;
import java.util.Date;
import java.util.Calendar;
import java.text.SimpleDateFormat;




@WebServlet("/bookmark")
public class bookmark extends HttpServlet
{
	
    

	/* quando la servlet viene caricata in memoria init() viene eseguito */

	public void init()
	{
	}
	
    @Override
	protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{

        HttpSession session = request.getSession();
        
        
        String id = (String)request.getParameter("id");
        String uname = (String)session.getAttribute("username");

        

        if (uname == null)
        {
            response.sendRedirect("errore.jsp?messaggio='Non sei loggato!'");
            return;
        }





        try 
        {

            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://178.79.187.9:3306/progetto_pweb_2122", "alessio", "tommasofedericoalessio");                

            Statement stmt1 = conn.createStatement();
            ResultSet DB_bookmarkExists = stmt1.executeQuery("SELECT * FROM `PREFERITI` WHERE post_id=" + id + " AND username='" + uname + "'");
            boolean bookmarkExists = false;

            while(DB_bookmarkExists.next())
            {
                bookmarkExists = true;
            }

            if (!bookmarkExists)
            {
                PreparedStatement ps = conn.prepareStatement("INSERT INTO `PREFERITI`(`username`, `post_id`) VALUES (?,?)");
                ps.setString(1, uname);
                ps.setInt(2, Integer.parseInt(id));
                int row_affected = ps.executeUpdate();

                response.sendRedirect("post.jsp?id=" + id);
                return;
            }
            else
            {
                PreparedStatement ps = conn.prepareStatement("DELETE FROM `PREFERITI` WHERE post_id=" + id + " AND username='" + uname + "'");
                int row_affected = ps.executeUpdate();

                response.sendRedirect("post.jsp?id=" + id);
                return;
            }



        }
        catch (Exception e)
        {
            response.sendRedirect("errore.jsp?messaggio='" + e + "'");
            return;
        }
    }
    
    
}
