


<%@page import="map.Personne"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    Personne a = new Personne();
    a.setNomTable("v_virtual_personne_insertion");
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    affichage.Liste[] liste=new Liste[1];
    TypeObjet objet=new TypeObjet();
    objet.setNomTable("cible");
    liste[0]=new affichage.Liste("cible",objet,"val","id");

    //Modification des affichages\
    pi.getFormu().getChamp("nom").setLibelle("Nom *");
    pi.getFormu().getChamp("prenom").setLibelle("Prenom");
    pi.getFormu().getChamp("telephone").setLibelle("T&eacute;l&eacute;phone *");
    pi.getFormu().getChamp("job").setVisible(false);
    pi.getFormu().getChamp("sexe").setVisible(false);
    pi.getFormu().getChamp("idAttente").setVisible(false);
    pi.getFormu().getChamp("age").setVisible(false);
    pi.getFormu().getChamp("domicile").setVisible(false);
    pi.getFormu().getChamp("compteFB").setLibelle("Compte FB");
    pi.getFormu().getChamp("whatsapp").setLibelle("Whatsapp");
    pi.getFormu().getChamp("mail").setLibelle("Mail");
    pi.getFormu().getChamp("champLibre").setLibelle("Remarque");
    pi.getFormu().getChamp("demandes").setAutre("readonly");
    pi.getFormu().getChamp("demandes").setLibelle("Demandes *");
    pi.getFormu().getChamp("demandes").setPageAppel("choix/demandes-choix.jsp");
    pi.getFormu().getChamp("region").setVisible(false);
    pi.getFormu().getChamp("district").setVisible(false);
    pi.getFormu().getChamp("communes").setVisible(false);
    pi.getFormu().getChamp("idresponsable").setVisible(false);
    pi.getFormu().getChamp("idresponsable").setVisible(false);
    pi.getFormu().getChamp("traitement").setVisible(false);
    pi.getFormu().getChamp("idTypeTraitement").setVisible(false);
    pi.getFormu().getChamp("demandes").setLibelle("Demande *");
    pi.getFormu().getChamp("idPoste").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("atout").setVisible(false);
    pi.getFormu().getChamp("attenteDetaille").setVisible(false);
    pi.getFormu().getChamp("rdv").setLibelle("Rendez-vous*");
    pi.getFormu().getChamp("rdv").setAutre("placeholder=\"dd/mm/yyyy hh:mm\"");
    pi.getFormu().changerEnChamp(liste);
    //Variables de navigation
    String classe = "map.Personne";
    String butApresPost = "personne/inscription-fiche.jsp";
    String nomTable = "personne";
    //Generer les affichages
    pi.preparerDataFormu();
    pi.getFormu().makeHtmlInsertTabIndex();
%>
<div class="content-wrapper">
    <h1 align="center">Saisie contact</h1>
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
