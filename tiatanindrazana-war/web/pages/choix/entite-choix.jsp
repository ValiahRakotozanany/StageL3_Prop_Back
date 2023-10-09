<%@page import="map.Entite"%>
<%@page import="affichage.PageRechercheChoix"%>
<%
try{
    String champReturn = request.getParameter("champReturn");
    Entite choix = new Entite();
    choix.setNomTable("entite");

    String listeCrt[] = {"id","denomination"};
    String listeInt[] = {};
    String libEntete[] = {"id","denomination"};
    int range = 2;
    PageRechercheChoix pr = new PageRechercheChoix(choix, request, listeCrt, listeInt, range, libEntete, libEntete.length);
    pr.setNpp(100);
    pr.setTitre("Choix entité");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("entite-choix.jsp");
    pr.setChampReturn(champReturn);

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAff[] = {"ID","Dénomination"};
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
                <form action="apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% 
                        
                        out.println(pr.getTableau().getHtmlWithRadioButton()); %>
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