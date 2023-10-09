<%-- 
    Document   : page-fiche-simple
    Created on : 9 mars 2023, 10:08:42
    Author     : BICI
--%>

<%@ page import="bean.*" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<%
    try{
    TypeObjet region = new TypeObjet();
    region.setNomTable("region");
    PageConsulte pc = new PageConsulte(region, request, (user.UserEJB) session.getValue("u"));
    String id=pc.getBase().getTuppleID();
    pc.getChampByName("id").setLibelle("ID");
    pc.getChampByName("val").setLibelle("R&eacute;gion");
    pc.getChampByName("desce").setLibelle("Description");
    pc.setTitre("Fiche R&eacute;gion");
    String lien = (String) session.getValue("lien");
    String pageModif = "region/region-modif.jsp";
    String classe = "bean.TypeObjet";

    //Initialisation de l'objet onglet
    Onglet onglet =  new Onglet("liste-district");
    onglet.setDossier("inc");
    Map<String, String> listePage = new HashMap<String, String>();
    Map<String, String> listeNumero = new HashMap<String,String>();
    listePage.put("liste-district","");
    listeNumero.put("1","liste-district");
    onglet.setListePage(listePage);
    onglet.setListeNumero(listeNumero);
    String tab = request.getParameter("tab");
    String currentTab = onglet.getCurrentPage(tab);

    String nomtable = "region";
    String pageListe = "regiont/region-liste.jsp";
    String pageActuel = "region/region-fiche.jsp";
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%= lien + "?but=region/region-liste.jsp" %>"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning pull-left"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
                            <a href="<%= lien + "?but=apresTarif.jsp&id=" + id+"&acte=delete&nomtable="+nomtable+"&bute="+pageActuel+"&classe="+classe %>"><button class="btn btn-danger">Supprimer</button></a>
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
                    <li class="<%=listePage.get("liste-district")%>"><a href="<%= lien %>?but=<%= pageListe %>&id=<%= id %>&tab=liste-district">Liste District</a></li>
                </ul>
                <div class="tab-content">       
                    <jsp:include page="<%= currentTab %>">
                        <jsp:param name="idregion" value="<%= id %>"/>
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


