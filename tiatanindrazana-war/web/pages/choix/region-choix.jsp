
<%@page import="map.Region"%>
<%@page import="affichage.PageRechercheChoix"%>
<%
    try{
    String champReturn = request.getParameter("champReturn");
    Region choix = new Region();
    String listeCrt[] = {"id","val","desce"};
    String listeInt[] = {};
    String libEntete[] = {"id","val","desce"};
    int range = 2;
    PageRechercheChoix pr = new PageRechercheChoix(choix, request, listeCrt, listeInt, range, libEntete, libEntete.length);
    pr.setOrdre(" order by val ASC");
    pr.setNpp(50);
    pr.setTitre("Choix Region");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("region-choix.jsp");
    pr.setChampReturn(champReturn);

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAff[] = {"ID","VALEUR","DESCRIPTION"};
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