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
import map.Proposition.ClientStatic;
import map.Proposition.Famille;
import map.Proposition.FamilleToken;
import map.Proposition.Maladie;
import map.Proposition.Token.TokenException;

/**
 *
 * @author Valiah Karen
 */
@WebServlet(name = "MaladieMembre", urlPatterns = {"/MaladieMembre"})
public class MaladieMembre extends BaseWs {

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
            out.println("<title>Servlet MaladieMembre</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MaladieMembre at " + request.getContextPath() + "</h1>");
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
                response.setContentType(contentType);

        response.addHeader("Access-Control-Allow-Origin", "*");
        //response.addHeader("Access-Control-Allow-Headers", "Origin, Content-Type, Accept, X-Auth-Token");
        response.addHeader("Access-Control-Allow-Credentials", "true");
        response.addHeader("Access-Control-Request-Headers", "Origin, X-Custom-Header, X-Requested-With, Authorization, Content-Type, Accept");
        //response.addHeader("Access-Control-Expose-Headers", "Content-Length, X-Kuma-Revision");
        response.addHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, PATCH, OPTIONS");

        Data data = null;
        Utils.Error error = new Utils.Error();
        //   String idarticle = request.getParameter("");
        String token = request.getHeader("Authorization");
        try (PrintWriter out = response.getWriter()) {
            try {
                Famille client = ClientStatic.findUserbyToken(token);
                FamilleToken tokenUser = ClientStatic.findTokenUserbyToken(token);
                String language = tokenUser.getLangue();

                MaladieMembre m = new MaladieMembre();
                MaladieMembre[] mm = m.listeMaladie("maladiemembre", null);
                System.out.println("tailleee ==== " + mm.length);
                data = new Data(mm, error);
                out.print(gsonSend.toJson(data));
            } catch (TokenException tex) {
                tex.printStackTrace();
                error = new Utils.Error(tex.getEtat(), "Situation", "Token Exception", tex.getMessage());
                out.println(gsonSend.toJson(error));
            } catch (Exception ex) {
                ex.printStackTrace();
                error = new Utils.Error(0, "Situation", "Token Exception", ex.getMessage());
            }
        }
        
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
