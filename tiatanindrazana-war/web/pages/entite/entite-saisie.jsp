<%@page import="map.*"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    Entite entite = new Entite();
    PageInsert pi = new PageInsert(entite, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
//    //Modification des affichages
    pi.getFormu().getChamp("denomination").setLibelle("denomination");
    pi.getFormu().getChamp("siege").setLibelle("siege");
    pi.getFormu().getChamp("effectif").setLibelle("effectif");
    pi.getFormu().getChamp("activite").setLibelle("activite");
    pi.getFormu().getChamp("dateCreation").setLibelle("dateCreation");
    pi.getFormu().getChamp("circonscription").setLibelle("circonscription");
    pi.getFormu().getChamp("contact").setLibelle("contact");
    
    TypeObjet t = new TypeObjet();
    t.setNomTable("TYPEENTITE");
    affichage.Liste[] liste = new affichage.Liste[1];
    liste[0] = new Liste("idType",t,"val","id"); 
    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("idType").setLibelle("Type");
    
//    //Variables de navigation
    String classe = "map.Entite";
    String butApresPost = "entite/entite-liste.jsp";
    String nomTable = "entite";
//    //Generer les affichages  
    pi.preparerDataFormu();
    pi.getFormu().makeHtmlInsertTabIndex();
%>
<div class="content-wrapper">
    <h1 align="center">Nouvel Entite</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post"  data-parsley-validate>
        <%
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
    </form>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
} %>
