<%-- 
    Document   : plat-liste.jsp
    Created on : 29 sept. 2023, 22:48:31
    Author     : Valiah Karen
--%>

<%@page import="affichage.Liste"%>
<%@page import="map.Proposition.Plat"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<% 
    try{
    Plat plat = new Plat();
    plat.setNomTable("plat");
    String listeCrt[] = {"id","nomplats"};
    String listeInt[] = {};
    String libEntete[] = {"id", "nomplats"};
  PageRecherche pr = new PageRecherche(plat, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Liste Plat");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("Proposition/plat-liste.jsp");
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
        <h1>Liste plats</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=Proposition/plat-liste.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>

        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=Proposition/plat-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id", "nomplats"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
    <div class="box-footer">
                           <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=Proposition/plat-saisie.jsp"%>" style="margin-right: 10px">Ajouter recette</a>
                        </div>
</div>
    <%}catch(Exception e){e.printStackTrace();}%>
