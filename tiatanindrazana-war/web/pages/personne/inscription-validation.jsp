
<%@page import="map.Poste"%>
<%@page import="map.TypeTraitement"%>
<%@page import="map.PersonneValide"%>
<%@page import="responsable.Responsable"%>
<%@page import="constante.ConstanteAffichage"%>
<%@page import="map.Personne"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    try{
    PersonneValide a = new PersonneValide();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    //Modification des affichages
    
    String id = request.getParameter("idPersonne");
    
    Liste[] liste = new Liste[2];
    Responsable responsable = new Responsable();
    liste[0] = new Liste("idresponsable",responsable,"nom","id");
    TypeTraitement typetraitement = new TypeTraitement();
    liste[1] = new Liste("idTypeTraitement",typetraitement,"nom","id");
    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("idPoste").setLibelle("Poste");
    pi.getFormu().getChamp("idresponsable").setLibelle("Responsable");
    pi.getFormu().getChamp("idTypeTraitement").setLibelle("Role à attribuer");
    pi.getFormu().getChamp("traitement").setLibelle("Traitement *");
    pi.getFormu().getChamp("traitement").setType(ConstanteAffichage.textarea);
    pi.getFormu().getChamp("traitement").setAutre("required");
    pi.getFormu().getChamp("traitement").setCss("big-textarea");
    pi.getFormu().getChamp("idPoste").setLibelle("Postes");
    pi.getFormu().getChamp("idPoste").setPageAppel("choix/postes-choix.jsp");
    pi.getFormu().getChamp("idPoste").setAutre("readonly");
    //Variables de navigation
    String classe = "map.PersonneValide";
    String butApresPost = String.format("personne/inscription-fiche.jsp?id=%s",id);
    String nomTable = "personne_valide_virtuel";
    //Generer les affichages
    pi.preparerDataFormu();
    pi.getFormu().makeHtmlInsertTabIndex();
%>
<div class="content-wrapper">
    <h1 align="center">Traitement d'une antenne</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post"  data-parsley-validate>
        <%
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="idPersonne" type="hidden" id="nature" value="<%= id %>">
        <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
    </form>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
} %>


