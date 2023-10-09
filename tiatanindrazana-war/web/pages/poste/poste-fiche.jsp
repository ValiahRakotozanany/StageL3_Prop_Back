<%-- 
    Document   : page-fiche-simple
    Created on : 9 mars 2023, 10:08:42
    Author     : BICI
--%>


<%@page import="map.PosteLibComplet"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    UserEJB user = (user.UserEJB) session.getValue("u");
    if(user.getUser().getIdrole().compareToIgnoreCase("dg")==0){
        PosteLibComplet t = new PosteLibComplet();
        PageConsulte pc = new PageConsulte(t, request, user);
        String id=pc.getBase().getTuppleID( );
        pc.getChampByName("id").setLibelle("Id");
        pc.getChampByName("nom").setLibelle("Nom");
        pc.getChampByName("idregion").setVisible(false);
        pc.getChampByName("iddistrict").setVisible(false);
        pc.getChampByName("idcommune").setVisible(false);
        pc.getChampByName("idregionlib").setLibelle("Region");
        pc.getChampByName("iddistrictlib").setLibelle("District");
        pc.getChampByName("idcommunelib").setLibelle("Commune");
        pc.getChampByName("idpersonne").setVisible(false);
        pc.getChampByName("nompersonne").setLibelle("Nom de la personne");
        pc.getChampByName("prenompersonne").setLibelle("Pr&eacute;nom de la personne");
        pc.setTitre("Fiche d'une poste ");
        String lien = (String) session.getValue("lien");
        String pageModif = "poste/poste-modif.jsp";
        String pageListe = "poste/poste-liste.jsp"; 
        String classe = "map.PosteLibComplet";
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
                            <a class="btn btn-warning pull-left"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
                            <!--<a href="<%= lien + "?but=apresTarif.jsp&id=" + id+"&acte=delete&bute=#&classe="+classe %>"><button class="btn btn-danger">Supprimer</button></a>-->
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%
        }else{
%>

<div class="content-wrapper">
    <p>Vous n'êtes pas autorisé à voir !</p>
</div>
        
  

<%
        }
} catch (Exception e) {
    e.printStackTrace();
} %>


