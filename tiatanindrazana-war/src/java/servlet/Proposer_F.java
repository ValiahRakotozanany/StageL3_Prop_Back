/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import Utils.Data;
import bean.ClassMAPTable;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import map.Proposition.ClientStatic;
import map.Proposition.Famille;
import map.Proposition.FamilleToken;
import map.Proposition.MaladieMembre;
import map.Proposition.Proposer;
import map.Proposition.Token.TokenException;
import org.hornetq.utils.json.JSONArray;
import org.hornetq.utils.json.JSONObject;

/**
 *
 * @author Valiah Karen
 */
@WebServlet(name = "Proposer", urlPatterns = {"/Proposer"})
public class Proposer_F extends BaseWs {

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
            out.println("<title>Servlet Proposer</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Proposer at " + request.getContextPath() + "</h1>");
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
        response.setContentType(contentType);

        response.addHeader("Access-Control-Allow-Origin", "*");
        //response.addHeader("Access-Control-Allow-Headers", "Origin, Content-Type, Accept, X-Auth-Token");
        response.addHeader("Access-Control-Allow-Credentials", "true");
        response.addHeader("Access-Control-Request-Headers", "Origin, X-Custom-Header, X-Requested-With, Authorization, Content-Type, Accept");
        //response.addHeader("Access-Control-Expose-Headers", "Content-Length, X-Kuma-Revision");
        response.addHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, PATCH, OPTIONS");

        HttpSession session = request.getSession(true);
        String ingredient = request.getParameter("ingredient");
        String type = request.getParameter("type");
        String budgetMin = request.getParameter("budgetMin");
        String budgetMax = request.getParameter("budgetMax");
        String nbrPers = request.getParameter("nbrPers");
        //  String datenaissance = request.getParameter("datenaissance");
        System.out.println(" ingredients = " + ingredient);
        // Date d = new Date(datenaissance);
        Data data = null;
        Utils.Error error = new Utils.Error();
        System.out.println("type =" + type);
        String[] splitType = type.split(",");
        String[] splitIng = ingredient.split(",");
        String token = request.getHeader("Authorization");
        try (PrintWriter out = response.getWriter()) {
            try {
                Famille client = ClientStatic.findUserbyToken(token);
                FamilleToken tokenUser = ClientStatic.findTokenUserbyToken(token);
                String language = tokenUser.getLangue();
                System.out.println(" idfamille = " + client.getId());
                MaladieMembre m = new MaladieMembre();
                MaladieMembre[] mm = m.getIngredientInterdit(client.getId(), "ingredient_eviter", null, splitIng);
                System.out.println("tailleee ==== " + mm.length);
                Proposer p = new Proposer();
                Proposer[] proposition = p.getPropositionJour(client.getId(), "ingredient_eviter", null, splitIng, splitType);
                ArrayList<ArrayList<Proposer>> disp = p.dispatchProp(proposition, splitType);
                ArrayList<ArrayList<Proposer>> combinations = Proposer.generateCombinations(disp);
                for (ArrayList<Proposer> combination : combinations) {
                    System.out.println(combination + " --- FIRST :");
                    for (int i = 0; i < combination.size(); i++) {
                        System.out.println(" ==>" + combination.get(i).getNomplats() + " _____  " + combination.get(i).getIdtype());
                    }
                    System.out.println(" ____________________________________________________");
                }                                              
//  ArrayList<Proposer> propos = p.genererPropositionjour(proposition, splitType.length   , 1, new ArrayList<Proposer>(),0,0,1);
                double buMin = Double.parseDouble(budgetMin);
                double buMax = Double.parseDouble(budgetMax);
                int nbr = Integer.parseInt(nbrPers);
                ArrayList<ArrayList<Proposer>> propTotal = p.propAvecBudgetEtNbrPers(combinations, buMin, buMax, nbr);
                data = new Data(new ArrayList<ArrayList<ClassMAPTable>>((ArrayList) combinations), error);
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
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
/*String json = jsonArray.toString();
                JSONArray jsonArray = new JSONArray();
                for (ArrayList<Proposer> combination : combinations) {
                    JSONArray innerArray = new JSONArray();
                    for (Proposer proposer : combination) {
                        JSONObject jsonObject = new JSONObject();
                        jsonObject.put("nomplats", proposer.getNomplats());
                        jsonObject.put("idtype", proposer.getIdtype());
                        jsonObject.put("idplat",proposer.getIdplat());
                        jsonObject.put("prix",proposer.getPrixenfant());
                        jsonObject.put("val",proposer.getVal());
                        jsonObject.put("ordre",proposer.getOrdre());
                        innerArray.put(jsonObject);
                    }
                    jsonArray.put(innerArray);
                }*/