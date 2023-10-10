/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import Utils.Data;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import map.Proposition.Famille;

/**
 *
 * @author Valiah Karen
 */
@WebServlet(name = "Login_Famille", urlPatterns = {"/Login_Famille"})
public class Login_Famille extends BaseWs {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Login_Famille</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Login_Famille at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        //processRequest(request, response);
        response.setContentType(contentType);
        
        response.addHeader("Access-Control-Allow-Origin", "*");
        //response.addHeader("Access-Control-Allow-Headers", "Origin, Content-Type, Accept, X-Auth-Token");
        response.addHeader("Access-Control-Allow-Credentials", "true");
        response.addHeader("Access-Control-Request-Headers", "Origin, X-Custom-Header, X-Requested-With, Authorization, Content-Type, Accept");
        //response.addHeader("Access-Control-Expose-Headers", "Content-Length, X-Kuma-Revision");
        response.addHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, PATCH, OPTIONS");
        
        HttpSession session = request.getSession(true);
        
       // String nomfamille = request.getParameter("nom");
        String email = request.getParameter("email");
        String motdepasse = request.getParameter("motdepasse");
        
        Data data = null;
        Utils.Error error = new Utils.Error();
        
        try (PrintWriter out = response.getWriter()) {
            try{
                Famille f = new Famille(email, motdepasse);
                Famille ff = f.connect(null,email,motdepasse,"mg");
               // data = new Data(nomfamille);
                data = new Data(new Famille[]{ff},error);
                out.print(gsonSend.toJson(data));
            } catch(Exception exc){
                exc.printStackTrace();
                error = new Utils.Error(-2, "Situation", "Exception", exc.getMessage());
                out.println(gsonSend.toJson(error));
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
