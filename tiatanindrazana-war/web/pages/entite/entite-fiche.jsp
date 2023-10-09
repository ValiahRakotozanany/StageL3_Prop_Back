<%-- 
    Document   : entite-fiche
    Created on : 4 août 2023, 11:46:37
    Author     : drana
--%>


<%@page import="map.Entite"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
        Entite t = new Entite();
        t.setNomTable("entite");
        //t.setId(request.getParameter("id"));
        PageConsulte pc = new PageConsulte(t, request, (user.UserEJB) session.getValue("u"));
    
//    {"denomination","siege", "effectif", "activite","dateCreation","circonscription","contact","idType"};
        pc.getChampByName("denomination").setLibelle("Denomination");
        pc.getChampByName("siege").setLibelle("Siege");
        pc.getChampByName("effectif").setLibelle("Effectif");
        pc.getChampByName("activite").setLibelle("Activite");
        pc.getChampByName("dateCreation").setLibelle("Date de Creation");
        pc.getChampByName("circonscription").setLibelle("circonscription");
        pc.getChampByName("contact").setLibelle("contact");
        pc.getChampByName("idType").setLibelle("Type");
        pc.getChampByName("id").setLien((String) session.getValue("lien") + "?but=entite/entite-fiche.jsp", "id=");
        pc.setTitre("Fiche de l'entite");

        t = (Entite) pc.getBase();
        String id=t.getId( );
        
        
        String lien = (String) session.getValue("lien");
        String pageModif = "entite/entite-modif.jsp";
        String classe = "map.Entite";
        String nomtable = "entite";
        String bute = "entite/entite-liste.jsp";

%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%= lien %>?but=entite/entite-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning pull-left"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
                            <a href="<%= lien + "?but=apresTarif.jsp&id=" + id+"&acte=delete&nomtable="+nomtable+"&bute="+bute+"&classe="+classe %>"><button class="btn btn-danger">Supprimer</button></a>
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
}
%>



