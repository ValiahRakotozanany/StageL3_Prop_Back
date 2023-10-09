<%@page import="utilitaire.Utilitaire"%>
<%-- <%@page import="antenne.CommuneLibComplet"%> --%>
<%@page import="affichage.PageRechercheChoix"%>
<%@page import="map.CommuneLibComplet"%>
<%
    try{
    String champReturn = request.getParameter("champReturn");
    CommuneLibComplet choix = new CommuneLibComplet();
    //choix.setNomTable("commune");
    String district = request.getParameter("idDistrict");
    if(district==null  || district.equals("")){
        throw new Exception("Veuillez au moins choisir une district");
    }
    String[] districtSplitted = district.split(";");
    String listeCrt[] = {"id","nom","idregionlib","iddistrictlib"};
    String listeInt[] = {};
    String libEntete[] = {"id","nom","idregionlib","iddistrictlib"};
    int range = 2;
    PageRechercheChoix pr = new PageRechercheChoix(choix, request, listeCrt, listeInt, range, libEntete, libEntete.length);
    pr.setOrdre(" order by idregionlib ASC,iddistrictlib  ASC,  nom ASC");
    pr.setAWhere(" AND idDistrict IN("+Utilitaire.tabToString(districtSplitted,"\'",",")+")");
    pr.setNpp(200);
    //if(district!=null) pr.setAWhere(" and iddistrict='"+district+"' ");
    pr.setTitre("Choix Commune");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("commune-choix.jsp");
    pr.getFormu().getChamp("idregionlib").setLibelle("Region");
    pr.getFormu().getChamp("iddistrictlib").setLibelle("District");
    pr.setChampReturn(champReturn);

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAff[] = {"ID","Nom","Region","District"};
    pr.getTableau().setLibeEntete(libEnteteAff);
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title><%= pr.getTitre() %></title>
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='../elements/css.jsp'/>
    </head>
    <body class="skin-blue sidebar-mini">
        <div class="wrapper">
            <section class="content-header">
                <h1><%= pr.getTitre() %></h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=champReturn%>" method="post" name="fcdetailsliste" id="fcdetailsliste">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <form action="apresChoixMultiple.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% 
                        
                        out.println(pr.getTableau().getHtmlWithMultipleCheckbox()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>
<%
	} catch (Exception e) {
		e.printStackTrace();
%>
    <script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
<% }%>