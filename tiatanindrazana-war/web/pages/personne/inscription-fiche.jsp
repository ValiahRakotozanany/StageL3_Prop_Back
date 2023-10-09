
<%@page import="constante.ConstanteEtat"%>
<%@page import="map.PersonneLibComplet"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<%
    try{
        
    UserEJB user = (UserEJB) session.getValue("u");
        
    //Information sur les navigations via la page
    String lien = (String) session.getValue("lien");
    String pageModif = "personne/inscription-modif.jsp";
    String classe = "map.PersonneLibComplet";
    String classeAnnul = "map.Personne";
    String pageListe = "personne/inscription-liste.jsp";
    String pageActuel = "personne/inscription-fiche.jsp";
    String pageValider = "personne/inscription-validation.jsp";
    String pageInterview = "personne/inscription-interview.jsp";

    //Information sur la fiche
    PersonneLibComplet t = new PersonneLibComplet();
    t.setNomTable("v_personne_lib_complet");
    PageConsulte pc = new PageConsulte(t, request, user);
    t = (PersonneLibComplet) pc.getBase();
    String id=request.getParameter(t.getAttributIDName());
    pc.getChampByName("nom").setLibelle("Nom"); 
    pc.getChampByName("prenom").setLibelle("Prenom"); 
    pc.getChampByName("age").setLibelle("Age");
    pc.getChampByName("nom").setLibelle("Nom");
    pc.getChampByName("id").setLibelle("ID");
    pc.getChampByName("prenom").setLibelle("Prenom");
    pc.getChampByName("telephone").setLibelle("Telephone");
    pc.getChampByName("job").setLibelle("Poste actuel");
    pc.getChampByName("idAttente").setVisible(false);
    pc.getChampByName("idTypeTraitement").setVisible(false);
    pc.getChampByName("idresponsable").setVisible(false);
    pc.getChampByName("idAttenteLib").setLibelle("Attente");
    pc.getChampByName("idTypeTraitementLib").setLibelle("Type de role");
    pc.getChampByName("idresponsablelib").setLibelle("Responsable");
    pc.getChampByName("sexe").setLibelle("Sexe");
    pc.getChampByName("domicile").setLibelle("Adresse");
    pc.getChampByName("mail").setLibelle("Mail");
    pc.getChampByName("compteFB").setLibelle("Compte FB");
    pc.getChampByName("whatsapp").setLibelle("Whatsapp");
    pc.getChampByName("etatlib").setVisible(false);
    pc.getChampByName("region").setVisible(false);
    pc.getChampByName("district").setVisible(false);
    pc.getChampByName("communes").setVisible(false);
    pc.getChampByName("demandes").setVisible(false);
    pc.getChampByName("idPoste").setVisible(false);
    pc.getChampByName("typeentites").setVisible(false);
    pc.getChampByName("demandeslib").setLibelle("Demande(s)");
    pc.getChampByName("regionlib").setLibelle("Region");
    pc.getChampByName("districtlib").setLibelle("District");
    pc.getChampByName("communeslib").setLibelle("Commune(s)");
    pc.getChampByName("champLibre").setLibelle("Remarque");
    pc.getChampByName("champLibre").setLibelle("Remarque");
    pc.getChampByName("attenteDetaille").setLibelle("Attentes d&eacute;taill&eacute;es");
    pc.getChampByName("rdv").setLibelle("Rendez-vous");
    pc.setTitre("Fiche d'une personne");

    //Initialisation de l'objet onglet
    Onglet onglet =  new Onglet("association-liste");
    onglet.setDossier("inc");
    Map<String, String> listePage = new HashMap<String, String>();
    Map<String, String> listeNumero = new HashMap<String,String>();
    listePage.put("association-liste","association-liste");
    listePage.put("poste-liste","poste-liste");
    listeNumero.put("1","association-liste");
    listeNumero.put("2","poste-liste");
    onglet.setListePage(listePage);
    onglet.setListeNumero(listeNumero);
    String tab = request.getParameter("tab");
    String currentTab = onglet.getCurrentPage(tab);

%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=<%= pageListe %>"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <% if(t.getEtat()>=ConstanteEtat.getEtatInterviewe() ){ %>
                                <a class="btn btn-warning pull-left"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
                            <% } %>
                            
                            <% if(user.getUser().getIdrole().compareTo("redacteur")!=0){ %>
                                <% if(t.getEtat()==ConstanteEtat.getEtatInterviewe()){ %>

                                    <a class="btn btn-danger pull-right"  href="<%= lien + "?but=apresTarif.jsp&id=" + id +"&acte=annuler&bute="+pageActuel+"&classe="+classeAnnul+"&nomtable=personne" %>" style="margin-right: 10px">Annuler</a>
                                    <a class="btn btn-success pull-right"  href="<%= lien + "?but="+ pageValider +"&idPersonne=" + id%>" style="margin-right: 10px">Traiter</a>
                                <% }else if(t.getEtat()==ConstanteEtat.getEtatCreer()) { %>
                                    <a class="btn btn-danger pull-right"  href="<%= lien + "?but=apresTarif.jsp&id=" + id +"&acte=annuler&bute="+pageActuel+"&classe="+classeAnnul+"&nomtable=personne" %>" style="margin-right: 10px">Annuler</a>
                                    <a class="btn btn-info pull-right"  href="<%= lien + "?but="+ pageInterview +"&id=" + id%>" style="margin-right: 10px">Interviewer</a>
                                <% } %>
                            <% } %>
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <!-- a modifier -->
                    <li class="<%= listePage.get("page1")%>"><a href="<%= lien %>?but=<%= pageActuel %>&id=<%= id %>&tab=association-liste">Liste des associations</a></li>
                    <li class="<%= listePage.get("page2")%>"><a href="<%= lien %>?but=<%= pageActuel %>&id=<%= id %>&tab=poste-liste">Liste des postes</a></li>
                </ul>
                <div class="tab-content">       
                    <jsp:include page="<%= currentTab %>" >
                        <jsp:param name="idPersonne" value="<%= id %>" />
                    </jsp:include>
                </div>
            </div>

        </div>
    </div>
</div>


<%
} catch (Exception e) {
    e.printStackTrace();
}
%>
