<%-- 
    Document   : maladie-saisie
    Created on : 1 oct. 2023, 23:22:33
    Author     : Valiah Karen
--%>

<%@page import="map.Proposition.Maladie"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
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
            Maladie a = new Maladie();
            PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
            pi.setLien((String) session.getValue("lien"));

            affichage.Champ[] liste = new affichage.Champ[1];
            String[] lsnom = {"Maladie", "intolerance", "autre condition"};
            String[] lsval = {"1", "2", "3"};
            liste[0] = new Liste("etat", lsnom, lsval);

            /*TypeObjet op = new TypeObjet();
            op.setNomTable("plat");
            liste[0] = new Liste("typeproduit", op, "VAL", "id");
             */
            pi.getFormu().changerEnChamp(liste);
            pi.getFormu().getChamp("Maladie").setLibelle("Nom Maladie");
            //pi.getFormu().getChamp("etat").setType("textarea");

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
            <h1>Ajout maladie</h1>
            <!--  -->
            <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="starticle" id="starticle">
                <%
                    pi.getFormu().makeHtmlInsertTabIndex();
                    out.println(pi.getFormu().getHtmlInsert());
                %>
                <input name="acte" type="hidden" id="nature" value="insert">
                <input name="bute" type="hidden" id="bute" value="Proposition/Maladie-saisie.jsp">
                <input name="classe" type="hidden" id="classe" value="map.Proposition.Maladie">
            </form>
        </div>
    </html>
</html>
