<%-- 
    Document   : template-insertion-multiple.jsp
    Created on : 9 mars 2023, 15:03:41
    Author     : Rado
--%>

<%@page import="user.*"%> 
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>
<%@page import="map.*"%>
<%@page import="antenne.*"%>
<%
    try{
    UserEJB u = null;
    u = (UserEJB) session.getValue("u");
    PersonneInsertion  mere = new PersonneInsertion();   
    mere.setNomTable("v_virtual_personne_insertion");
    AssociationEntitePersonne fille = new AssociationEntitePersonne();
    int nombreLigne = 10;
    PageInsertMultiple pi = new PageInsertMultiple(mere, fille, request, nombreLigne, u);
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("job").setLibelle("Poste actuel *");
    pi.getFormu().getChamp("compteFB").setLibelle("Compte FB");
    pi.getFormu().getChamp("idresponsable").setVisible(false);
    pi.getFormu().getChamp("traitement").setVisible(false);
    Attente attente = new Attente();
    attente.setNomTable("attente");
    TypeObjet region = new TypeObjet();
    region.setNomTable("region");
    District district = new District();
    district.setNomTable("district");
    affichage.Liste[] liste = new affichage.Liste[4];
    liste[0] = new Liste("idAttente", attente, "val", "id"); 
    String[] valeurs = {"M","F"};
    String[] affiches = {"homme","femme"};
    liste[1] = new Liste("sexe" ,affiches,valeurs);
    liste[2] = new Liste("region", region, "val", "id"); 
    liste[3] = new Liste("district",district,"nom","id");
    liste[2].setDeroulanteDependante(liste[3],"idregion","onchange");
    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("idAttente").setLibelle("Quels sont vos attentes ? *");
    pi.getFormu().getChamp("champLibre").setLibelle("Remarque");
    pi.getFormu().getChamp("champLibre").setType("textarea");
    pi.getFormu().getChamp("champLibre").setCss("big-textarea");
    pi.getFormu().getChamp("communes").setPageAppel("choix/commune-choix.jsp");
    pi.getFormu().getChamp("communes").setAutre("readOnly");
    pi.getFormu().getChamp("nom").setLibelle("Nom *");
    pi.getFormu().getChamp("prenom").setLibelle("Prenom");
    pi.getFormu().getChamp("telephone").setLibelle("Telephone *");
    pi.getFormu().getChamp("region").setLibelle("Region *");
    pi.getFormu().getChamp("district").setLibelle("District *");
    pi.getFormu().getChamp("communes").setLibelle("Communes *");
    pi.getFormu().getChamp("demandes").setLibelle("Demandes *");
    pi.getFormufle().getChamp("rolePersonne_0").setLibelle("Role");
    pi.getFormufle().getChamp("idEntite_0").setLibelle("Entit&eacute;");
    for(int i=0;i < pi.getFormufle().getChampFille("idEntite").length;i++){
        pi.getFormufle().getChampFille("idEntite")[i].setPageAppel("choix/entite-choix.jsp","idEntite_"+i+";idEntitelibelle_"+i);
        pi.getFormufle().getChampFille("idEntite")[i].setAutre("readOnly");
    }
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("idPersonne"),false); 
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"),false); 
    String[] listOrdre = {"id","nom", "prenom","age","sexe","domicile","job","mail","compteFB","whatsapp","telephone","region","district","communes","idAttente","champLibre","traitement","idresponsable"};
    pi.getFormu().setOrdre(listOrdre);

    pi.preparerDataFormu();
    //Variables de navigation
    String classeMere = "map.PersonneInsertion";
    String classeFille = "map.AssociationEntitePersonne";
    String butApresPost = "personne/inscription-liste.jsp";
    String colonneMere = "idPersonne";
    //Preparer les affichages
    pi.getFormu().makeHtmlInsertTabIndex();
    pi.getFormufle().makeHtmlInsertTableauIndex();
    
%>
<div class="content-wrapper">
    <!-- A modifier -->
    <h1>Inscription antenne</h1>
    <!--  -->
    <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post" >
        <%
            
            out.println(pi.getFormu().getHtmlInsert());
            out.println(pi.getFormufle().getHtmlTableauInsert());
        %>
        
        <input name="acte" type="hidden" id="nature" value="insertSansControle">
        <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= classeMere %>">
        <input name="classefille" type="hidden" id="classefille" value="<%= classeFille %>">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%= nombreLigne %>">
        <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMere %>">
    </form>
        
</div>
<script>
    $("document").ready(()=>{
        let link = $("[onclick*='communes']")[0].getAttribute("onclick");
        let newLink = link.substring(0,link.length-2)+`&idDistrict=`+$("[name='district']").val()+link.substring(link.length-2,link.length);
        $("[onclick*='communes']")[0].setAttribute("onclick",newLink);
        $("[name='district']").on('change',()=>{
            let newLink = link.substring(0,link.length-2)+`&idDistrict=`+$("[name='district']").val()+link.substring(link.length-2,link.length);
            $("[onclick*='communes']")[0].setAttribute("onclick",newLink);
        });
    });
</script>
<%
	} catch (Exception e) {
		e.printStackTrace();
%>
    <script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
<% }%>

