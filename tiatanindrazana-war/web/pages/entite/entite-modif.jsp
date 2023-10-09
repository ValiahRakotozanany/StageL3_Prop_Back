<%-- 
    Document   : update-simple
    Created on : 9 mars 2023, 11:58:35
    Author     : BICI
--%>
<%@page import="map.Entite"%>
<%@ page import="bean.*"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>

<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Entite entite = new Entite();
    entite.setNomTable("entite");
    PageUpdate pi = new PageUpdate(entite, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    
    pi.getFormu().getChamp("denomination").setLibelle("denomination");
    pi.getFormu().getChamp("siege").setLibelle("siege");
    pi.getFormu().getChamp("effectif").setLibelle("effectif");
    pi.getFormu().getChamp("activite").setLibelle("activite");
    pi.getFormu().getChamp("dateCreation").setLibelle("Date de creation");
    pi.getFormu().getChamp("circonscription").setLibelle("circonscription");
    pi.getFormu().getChamp("contact").setLibelle("contact");
    
    TypeObjet t = new TypeObjet();
    t.setNomTable("TYPEENTITE");
    affichage.Liste[] liste = new affichage.Liste[1];
    liste[0] = new Liste("idType",t,"val","id"); 
    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("idType").setLibelle("Type");
    
    String bute = "entite/entite-liste.jsp";
    String classe = "map.Entite";
    String nomtable = "entite";
    
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post">
                        <%
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <div class="row">
                            <div class="col-md-11">
                                <button class="btn btn-primary pull-right" name="Submit2" type="submit">Valider</button>
                            </div>
                            <br><br> 
                        </div>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="<%= bute %>">
                        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomtable %>">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>