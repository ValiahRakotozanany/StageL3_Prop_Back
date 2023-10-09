<%@page import="utilitaire.Utilitaire"%>
<%@page import="antenne.DistrictLibComplet"%>
<%@page import="affichage.PageRechercheChoix"%>
<%
    try{
    String champReturn = request.getParameter("champReturn");
    DistrictLibComplet choix = new DistrictLibComplet();
    String region = request.getParameter("region");
    if(region==null || region.equals("")){
        throw new Exception("Veuillez choisir au moins une region");
    }
    String[] regionSplitted = region.split(";");
    String listeCrt[] = {"id","nom","regiondescelib"};
    String listeInt[] = {};
    String libEntete[] = {"id","nom","regiondescelib"};
    int range = 2;
    PageRechercheChoix pr = new PageRechercheChoix(choix, request, listeCrt, listeInt, range, libEntete, libEntete.length);
    pr.setOrdre(" order by regiondescelib ASC , nom ASC");
    pr.setAWhere(" AND idRegion IN("+Utilitaire.tabToString(regionSplitted,"\'",",")+")");
    pr.setNpp(150);
    pr.setTitre("Choix District");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("commune-choix.jsp");
    pr.getFormu().getChamp("regiondescelib").setLibelle("Region");
    pr.setChampReturn(champReturn);
    System.out.println("awhere : "+pr.getAWhere());
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAff[] = {"ID","Nom","Region"};
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