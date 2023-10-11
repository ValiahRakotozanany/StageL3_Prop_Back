/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import Utils.Data;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import map.Proposition.ClientStatic;
import map.Proposition.Famille;
import map.Proposition.FamilleToken;
import map.Proposition.Membre;
import map.Proposition.Token.TokenException;

/**
 *
 * @author Valiah Karen
 */
@WebServlet(name = "Membre_Famille", urlPatterns = {"/Membre_Famille"})
public class Membre_Famille extends BaseWs {

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

                Membre m = new Membre();
                Membre[]mm = m.listeMembre(client.getId(),"membre",null);
                //JejooArticle jejooArticle = JejooArticle.getFicheArticle(idarticle, client, language);
//                data = new Data(new JejooArticle[]{jejooArticle},error);
                System.out.println("tailleee ==== "+mm.length);
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
        String idfamille = request.getParameter("idfamille");
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String datenaissance = request.getParameter("datenaissance");
        // Date d = new Date(datenaissance);
        Data data = null;
        Utils.Error error = new Utils.Error();
        System.out.println("datenaissance =" + datenaissance);
        try (PrintWriter out = response.getWriter()) {
            try {
                Membre f = new Membre();
                f.setIdfamille(idfamille);
                f.setNom(nom);
                f.setPrenom(prenom);
                //  f.setDatenaissance((java.sql.Date) d);

                String pattern = "dd-MM-yyyy"; // Par exemple, "2023-10-09"                        
                SimpleDateFormat dateFormat = new SimpleDateFormat(pattern);
                dateFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
                try {
                    // Utiliser le parse() pour convertir la chaîne en Date
                    Date utilDate = dateFormat.parse(datenaissance);

                    // Convertir java.util.Date en java.sql.Date
                    java.sql.Date sqlDate = new java.sql.Date(utilDate.getYear(), utilDate.getMonth(), utilDate.getDate());
                    f.setDatenaissance(sqlDate);
                    // Vous pouvez maintenant utiliser l'objet java.sql.Date comme bon vous semble
                    System.out.println("Date parse : " + sqlDate);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
                Membre ff = f.ajoutMembre(null);
                // data = new Data(nomfamille);
                data = new Data(new Membre[]{ff}, error);
                out.print(gsonSend.toJson(data));
            } catch (Exception exc) {
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
