<%-- 
    Document   : template-insertion-multiple.jsp
    Created on : 9 mars 2023, 15:03:41
    Author     : Rado
--%>

<%@page import="user.*"%> 
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>
<%@page import="antenne.*"%>
<%
    try{
    UserEJB u = null;
    u = (UserEJB) session.getValue("u");
    District  mere = new District();   
    Commune fille = new Commune();
    int nombreLigne = 10;
    PageInsertMultiple pi = new PageInsertMultiple(mere, fille, request, nombreLigne, u);
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("nom").setLibelle("Libelle");
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"),false); 
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("iddistrict"),false); 

    affichage.Champ[] liste = new affichage.Champ[1];
    TypeObjet region=new TypeObjet();
    region.setNomTable("region");

    liste[0] = new Liste("idregion", region, "val", "id");
    pi.getFormu().changerEnChamp(liste);

    pi.getFormu().getChamp("idregion").setLibelle("Region");
    
    pi.preparerDataFormu();

    //Variables de navigation
    String classeMere = "antenne.District";
    String classeFille = "antenne.Commune";
    String butApresPost = "district/district-fiche.jsp";
    String colonneMere = "iddistrict";

    pi.getFormufle().getChamp("nom_0").setLibelle("Nom Commune");
    //Preparer les affichages
    pi.getFormu().makeHtmlInsertTabIndex();
    pi.getFormufle().makeHtmlInsertTableauIndex();
       
%>
<div class="content-wrapper">
    <h1>Insertion District</h1>
    <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post" >
        <%
            
            out.println(pi.getFormu().getHtmlInsert());
            out.println(pi.getFormufle().getHtmlTableauInsert());
        %>
        
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= classeMere %>">
        <input name="classefille" type="hidden" id="classefille" value="<%= classeFille %>">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%= nombreLigne %>">
        <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMere %>">
    </form>
        
</div>

<%
	} catch (Exception e) {
		e.printStackTrace();
%>
    <script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
<% }%>

