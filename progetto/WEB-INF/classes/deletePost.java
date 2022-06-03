import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import jakarta.servlet.annotation.*;
import java.sql.*;
import java.util.Date;
import java.util.Calendar;
import java.text.SimpleDateFormat;




@WebServlet("/deletePost")
public class deletePost extends HttpServlet
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
        String type = (String)request.getParameter("type");
        String safePostId = (String)request.getParameter("safepostid");
        String uname = (String)session.getAttribute("username");

        

        if (uname == null || (safePostId == null && type.equals("answer")))
        {
            response.sendRedirect("errore.jsp?messaggio='Devi essere loggato'");
            return;
        }




        if (type.equals("post"))
        {

            try 
            {

                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://178.79.187.9:3306/progetto_pweb_2122", "alessio", "tommasofedericoalessio");                
                
                PreparedStatement ps = conn.prepareStatement("DELETE FROM `LIKE_POST` WHERE postId=" + id);
                ps.executeUpdate();

                PreparedStatement ps2 = conn.prepareStatement("DELETE FROM `POST_TAG` WHERE postId=" + id);
                ps2.executeUpdate();

                PreparedStatement ps3 = conn.prepareStatement("DELETE FROM `PREFERITI` WHERE post_id=" + id);
                ps3.executeUpdate();

                PreparedStatement ps4 = conn.prepareStatement("DELETE FROM `RISPOSTA` WHERE idPost=" + id);
                ps4.executeUpdate();


                PreparedStatement ps5 = conn.prepareStatement("DELETE FROM `POST` WHERE id=" + id);
                ps5.executeUpdate();

                response.sendRedirect("forum.jsp?q=all");
                return;

            }
            catch (Exception e)
            {
                response.sendRedirect("errore.jsp?messaggio='" + e + "'");
                return;
            }
        }
        else
        {
            try 
            {

                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://178.79.187.9:3306/progetto_pweb_2122", "alessio", "tommasofedericoalessio");                
                
                PreparedStatement ps = conn.prepareStatement("DELETE FROM `LIKE_RISPOSTA` WHERE answerId=" + id);
                ps.executeUpdate();

                PreparedStatement ps2 = conn.prepareStatement("DELETE FROM `RISPOSTA` WHERE id=" + id);
                ps2.executeUpdate();

                response.sendRedirect("post.jsp?id=" + safePostId);
                return;



            }
            catch (Exception e)
            {
                response.sendRedirect("errore.jsp?messaggio='" + e + "'");
                return;
            }
        }



        
        


    
    
    }



}