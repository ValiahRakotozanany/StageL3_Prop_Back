<%-- 
    Document   : page-fiche-simple
    Created on : 9 mars 2023, 10:08:42
    Author     : BICI
--%>

<%@ page import="antenne.*" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<%
    try{
    DistrictLibComplet district = new DistrictLibComplet();
    district.setNomTable("districtlibcomplet");
    PageConsulte pc = new PageConsulte(district, request, (user.UserEJB) session.getValue("u"));
    String id=pc.getBase().getTuppleID();
    pc.getChampByName("id").setLibelle("ID");
    pc.getChampByName("idregion").setVisible(false);
    pc.getChampByName("nom").setLibelle("Libelle");
    pc.getChampByName("regiondescelib").setLibelle("Region");
     pc.getChampByName("regionvallib").setVisible(false);
    pc.setTitre("Fiche District");
    String lien = (String) session.getValue("lien");

    //Initialisation de l'objet onglet
    Onglet onglet =  new Onglet("liste-commune");
    onglet.setDossier("inc");
    Map<String, String> listePage = new HashMap<String, String>();
    Map<String, String> listeNumero = new HashMap<String,String>();
    listePage.put("liste-commune","");
    listeNumero.put("1","liste-commune");
    onglet.setListePage(listePage);
    onglet.setListeNumero(listeNumero);
    String tab = request.getParameter("tab");
    String currentTab = onglet.getCurrentPage(tab);

    String pageListe = "district/district-liste.jsp";
    String pageModif = "district/district-modif.jsp";
    String classe = "antenne.District";
    String pageActuel = "district/district-fiche.jsp";
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%= lien+"?but=district/district-liste.jsp" %>"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning pull-left"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
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
                    <li class="<%=listePage.get("liste-commune")%>"><a href="<%= lien %>?but=<%= pageActuel %>&id=<%= id %>&tab=liste-commune">Liste Commune</a></li>
                </ul>
                <div class="tab-content">       
                    <jsp:include page="<%= currentTab %>">
                        <jsp:param name="iddistrict" value="<%= id %>"/>
                    </jsp:include>
                </div>
            </div>

        </div>
    </div>
</div>


<%
} catch (Exception e) {
    e.printStackTrace();
} %>


