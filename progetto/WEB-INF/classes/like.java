import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import jakarta.servlet.annotation.*;
import java.sql.*;
import java.util.Date;
import java.util.Calendar;
import java.text.SimpleDateFormat;




@WebServlet("/like")
public class like extends HttpServlet
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

        

        if (uname == null)
        {
            response.sendRedirect("errore.jsp?messaggio='Devi entrare per poter mettere un like!'");
            return;
        }




        if (type.equals("post"))
        {

            try 
            {

                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://178.79.187.9:3306/progetto_pweb_2122", "alessio", "tommasofedericoalessio");                

                Statement stmt1 = conn.createStatement();
                ResultSet DB_likeExists = stmt1.executeQuery("SELECT * FROM `LIKE_POST` WHERE postId=" + id + " AND username='" + uname + "'");
                boolean likeExists = false;

                while(DB_likeExists.next())
                {
                    likeExists = true;
                }

                if (!likeExists)
                {
                    PreparedStatement ps = conn.prepareStatement("INSERT INTO `LIKE_POST`(`username`, `postId`) VALUES (?,?)");
                    ps.setString(1, uname);
                    ps.setInt(2, Integer.parseInt(id));
                    int row_affected = ps.executeUpdate();

                    response.sendRedirect("post.jsp?id=" + id);
                    return;
                }
                else
                {
                    PreparedStatement ps = conn.prepareStatement("DELETE FROM `LIKE_POST` WHERE postId=" + id + " AND username='" + uname + "'");
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
        else
        {
            try 
            {

                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://178.79.187.9:3306/progetto_pweb_2122", "alessio", "tommasofedericoalessio");                

                Statement stmt1 = conn.createStatement();
                ResultSet DB_likeExists = stmt1.executeQuery("SELECT * FROM `LIKE_RISPOSTA` WHERE answerId=" + id + " AND username='" + uname + "'");
                boolean likeExists = false;

                while(DB_likeExists.next())
                {
                    likeExists = true;
                }

                if (!likeExists)
                {
                    PreparedStatement ps = conn.prepareStatement("INSERT INTO `LIKE_RISPOSTA`(`username`, `answerId`) VALUES (?,?)");
                    ps.setString(1, uname);
                    ps.setInt(2, Integer.parseInt(id));
                    int row_affected = ps.executeUpdate();

                    response.sendRedirect("post.jsp?id=" + safePostId);
                    return;
                }
                else
                {
                    PreparedStatement ps = conn.prepareStatement("DELETE FROM `LIKE_RISPOSTA` WHERE answerId=" + id + " AND username='" + uname + "'");
                    int row_affected = ps.executeUpdate();

                    response.sendRedirect("post.jsp?id=" + safePostId);
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



}