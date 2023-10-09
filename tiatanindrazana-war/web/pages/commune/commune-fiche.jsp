<%-- 
    Document   : page-fiche-simple
    Created on : 9 mars 2023, 10:08:42
    Author     : BICI
--%>

<%@page import="map.CommuneLibComplet"%>
<%@ page import="antenne.*" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    CommuneLibComplet commune = new CommuneLibComplet();
    PageConsulte pc = new PageConsulte(commune, request, (user.UserEJB) session.getValue("u"));
    String id=pc.getBase().getTuppleID( );
    pc.getChampByName("id").setLibelle("ID");
    pc.getChampByName("iddistrict").setVisible(false);
    pc.getChampByName("idregion").setVisible(false);
    pc.getChampByName("iddistrictlib").setLibelle("District");
    pc.getChampByName("idregionlib").setLibelle("Region");
    pc.getChampByName("nom").setLibelle("Commune");
    pc.setTitre("Fiche Commune");
    String lien = (String) session.getValue("lien");
    String pageModif = "commune/commune-modif.jsp";
    String classe = "antenn.Commune";
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%= lien + "?but=commune/commune-liste.jsp" %>"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <!--<a class="btn btn-warning pull-left"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>-->
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<%
} catch (Exception e) {
    e.printStackTrace();
} %>


