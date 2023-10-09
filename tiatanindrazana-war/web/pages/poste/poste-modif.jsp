<%-- 
<%-- 
    Document   : update-simple
    Created on : 9 mars 2023, 11:58:35
    Author     : BICI
--%>

<%@page import="antenne.Commune"%>
<%@page import="antenne.District"%>
<%@page import="map.Poste"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>

<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Poste t =new Poste();
    PageUpdate pi = new PageUpdate(t, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    pi.getFormu().getChamp("id").setAutre("readonly");
    pi.getFormu().getChamp("id").setLibelle("ID");
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
    pi.getFormu().getChamp("idPersonne").setVisible(false);
    pi.getFormu().getChamp("idregion").setLibelle("Region");
    pi.getFormu().getChamp("iddistrict").setLibelle("District");
    pi.getFormu().getChamp("idcommune").setLibelle("Commune");
    
    pi.preparerDataFormu();
    pi.setLien((String) session.getValue("lien"));
    String[] listOrdre = {"id","nom", "idregion","iddistrict","idcommune"};
    pi.getFormu().setOrdre(listOrdre);
    
    String nomtable = "poste";
    String classe = "map.Poste";
    String bute = "poste/poste-fiche.jsp";
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification d'une poste</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post">
                        <%
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <div class="row">
                            <div class="col-md-11">
                                <button class="btn btn-primary pull-right" name="Submit2" type="submit">Valider</button>
                            </div>
                            <br><br> 
                        </div>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="<%= bute %>">
                        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomtable %>">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>