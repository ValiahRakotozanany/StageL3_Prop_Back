<%-- 
    Document   : plat-saisie
    Created on : 1 oct. 2023, 17:40:41
    Author     : Valiah Karen
--%>

<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.PageInsert"%>
<%@page import="map.Proposition.Plat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Ajout Plat</title>
    </head> 

<%
    //String autreparsley = "data-parsley-range='[8, 40]' required";
    Plat  a = new Plat();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));    
    
    //affichage.Champ[] liste = new affichage.Champ[1];
    
    /*TypeObjet op = new TypeObjet();
    op.setNomTable("plat");
    liste[0] = new Liste("typeproduit", op, "VAL", "id");
    */
    //pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("nomplats").setLibelle("Nom Plat");
    pi.getFormu().getChamp("descri").setType("textarea");
        
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
    <h1>Nouveau Plat</h1>
    <!--  -->
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="starticle" id="starticle">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="Proposition/plat-saisie.jsp">
    <input name="classe" type="hidden" id="classe" value="map.Proposition.Plat">
    </form>
</div>
    </html>