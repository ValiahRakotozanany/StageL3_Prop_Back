
<%@page import="antenne.Commune"%>
<%@page import="antenne.District"%>
<%@page import="map.Poste"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%@ page import="affichage.PageInsert" %>
<style>
    .select option::before {
        content: " - "; /* Texte générique pour masquer les valeurs */
    }
</style>
<%
    try{

    Poste a = new Poste();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    //Modification des affichages
    Liste[] liste = new Liste[3]; 
    TypeObjet region = new TypeObjet();
    region.setNomTable("region");
    District district = new District();
    district.setNomTable("district");
    Commune commune = new Commune();
    commune.setNomTable("commune");
    liste[0] = new Liste("idregion", region, "val", "id"); 
    liste[1] = new Liste("iddistrict",district,"nom","id");
    liste[0].setDeroulanteDependante(liste[1],"idregion","onchange");
    liste[2] = new Liste("idcommune",commune,"nom","id");
    liste[1].setDeroulanteDependante(liste[2], "iddistrict", "onchange");
    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("nom").setLibelle("Nom");
    pi.getFormu().getChamp("idregion").setLibelle("Region");
    pi.getFormu().getChamp("iddistrict").setLibelle("District");
    pi.getFormu().getChamp("idcommune").setLibelle("Commune");
    pi.getFormu().getChamp("idPersonne").setVisible(false);
    //Variables de navigation
    String classe = "map.Poste";
    String butApresPost = "poste/poste-fiche.jsp";
    String nomTable = "poste";
    //Generer les affichages
    pi.preparerDataFormu();
    String[] listOrdre = {"nom", "idregion","iddistrict","idcommune","idPersonne"};
    pi.getFormu().setOrdre(listOrdre);
%>
<div class="content-wrapper">
    <h1 align="center">Saisie d'une poste</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post"  data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
    </form>
</div>
<script>
    $(document).ready(function() {
        var newOption = '<option value="-" selected>-</option>';
        $('#iddistrict').prepend(newOption);
        $('#idcommune').prepend(newOption);
    });     

</script>
<%
} catch (Exception e) {
    e.printStackTrace();
}
%>
