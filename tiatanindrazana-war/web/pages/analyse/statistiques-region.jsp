
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="map.CommuneEntite" %>


<%
    try {
        CommuneEntite communeEntite = new CommuneEntite();
        communeEntite.setNomTable("v_commune_entite_lib_complet");
        String listeCrt[] = {"idRegionLib","idDistrictLib"};
        String listeInt[] = {};
        String colDefaut[] = {"idRegionLib", "idDistrictLib", "nom"};
        String somDefaut[] = {"effectif"};
        String pourcentage[] = {};
        int nbRangeForm = 3;
        PageRechercheGroupe pr = new PageRechercheGroupe(communeEntite, request, listeCrt, listeInt, nbRangeForm, colDefaut, somDefaut, pourcentage, colDefaut.length, somDefaut.length);
        //Definition info global
        pr.setTitre("Analyse effectif");
        pr.setApres("analyse/statistiques-region.jsp");
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        /*pr.getFormu().getChamp("id").setLibelle("Id");
        pr.getFormu().getChamp("libelle").setLibelle("Libelle");*/
        pr.getFormu().getChamp("idRegionLib").setLibelle("Region");
        pr.getFormu().getChamp("idDistrictLib").setLibelle("District");
        pr.creerObjetPage();
        //Definir les informations sur les tableaux (liens, libellés)
        String lienTableau[] = {/*pr.getLien() + "?but=#"*/};
        String colonneLien[] = {/*"id"*/};
        String libEnteteAffiche[] = {"Region", "District", "Commune","Effectif"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="<%= pr.getApres() %>" />
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%

            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript">
    alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>

