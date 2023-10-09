
<%@page import="responsable.Responsable"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    Responsable t = new Responsable();
    String nomtable = "responsable";
    t.setNomTable(nomtable);
    PageConsulte pc = new PageConsulte(t, request, (user.UserEJB) session.getValue("u"));
    
    t = (Responsable) pc.getBase();
    String id = t.getId();
    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("nom").setLibelle("Nom");
    pc.setTitre("Fiche d'un responsable ");
    String lien = (String) session.getValue("lien");
    String pageModif = "responsable/responsable-modif.jsp";
    String classe = "responsable.Responsable";
    String retour = "responsable/responsable-liste.jsp"; 
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%= lien %>?but=<%= retour %>"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning pull-left"  href="<%= lien + "?but="+ pageModif +"&id=" + id+"&classe=" + classe +"&nomtable=" + nomtable %>" style="margin-right: 10px">Modifier</a>
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
