<%-- 
    Document   : ingredient-liste
    Created on : 1 oct. 2023, 23:12:20
    Author     : Valiah Karen
--%>

<%@page import="map.Proposition.Ingredient"%>
<%@page import="map.Proposition.Maladie"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Maladie</title>
    </head>
 

<% 
    try{
    Ingredient plat = new Ingredient();
    //plat.setNomTable("plat");
    String listeCrt[] = {"id","nom","prixachat","unite","valeur"};
    String listeInt[] = {};
    String libEntete[] = {"id", "nom"};
  PageRecherche pr = new PageRecherche(plat, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Liste Ingrédients");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("Proposition/maladie-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste Ingrédients</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=Proposition/maladie-liste.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>

        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=Proposition/maladie-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id", "Aliment"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
    <div class="box-footer">
                           <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=Proposition/Maladie-saisie.jsp"%>" style="margin-right: 10px">Ajouter recette</a>
                        </div>
</div>
    <%}catch(Exception e){e.printStackTrace();}%>
>
</html>
