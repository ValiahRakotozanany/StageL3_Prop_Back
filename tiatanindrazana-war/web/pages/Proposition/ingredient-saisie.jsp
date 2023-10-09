<%-- 
    Document   : ingredient-saisie
    Created on : 1 oct. 2023, 17:40:41
    Author     : Valiah Karen
--%>

<%@page import="map.Proposition.Ingredient"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.PageInsert"%>
<%@page import="map.Proposition.Plat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Ajout Ingredient</title>
    </head> 

<%
    //String autreparsley = "data-parsley-range='[8, 40]' required";
    Ingredient  a = new Ingredient();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));    
    
    affichage.Champ[] liste = new affichage.Champ[1];
    
    TypeObjet op = new TypeObjet();
    op.setNomTable("unite");
    liste[0] = new Liste("unite", op, "VAL", "id");    
    pi.getFormu().changerEnChamp(liste);

    pi.getFormu().getChamp("nom").setLibelle("Nom Ingredient");    
    pi.getFormu().getChamp("prixachat").setLibelle("Prix d'achat");
    pi.getFormu().getChamp("valeur").setLibelle("Quantite");
    pi.getFormu().getChamp("datesaisondebut").setLibelle("Date saison Debut");
    pi.getFormu().getChamp("datesaisonfin").setLibelle("Date Saison Fin");
       
    /*pi.getFormu().getChamp("code").setLibelle("Code");
    pi.getFormu().getChamp("designation").setLibelle("Libelle");
    pi.getFormu().getChamp("seuil").setLibelle("Seuil");
    pi.getFormu().getChamp("unite").setLibelle("Unité");
    pi.getFormu().getChamp("presentation").setLibelle("Presentation");
    pi.getFormu().getChamp("typearticle").setLibelle("Type");
    pi.getFormu().getChamp("groupee").setLibelle("Groupe");
    pi.getFormu().getChamp("sousgroupe").setLibelle("Sous groupe");
    pi.getFormu().getChamp("chapitre").setLibelle("Chapitre");
    pi.getFormu().getChamp("constante").setLibelle("Constante");*/
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Ajout ingredient </h1>
    <!--  -->
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="starticle" id="starticle">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="Proposition/ingredient-saisie.jsp&id=<%=request.getParameter("id")%>">
    <input name="classe" type="hidden" id="classe" value="map.Proposition.Ingredient">
    </form>
</div>
    </html>