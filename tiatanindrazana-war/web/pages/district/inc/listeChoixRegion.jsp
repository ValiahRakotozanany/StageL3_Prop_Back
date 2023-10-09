
<%@page import="bean.*"%>
<%@page import="affichage.PageRechercheChoix"%>

<%
    String champReturn = request.getParameter("champReturn");
    TypeObjet choix = new TypeObjet();
    choix.setNomTable("region");

    String listeCrt[] = {"id","val","desce"};
    String listeInt[] = {};
    String libEntete[] = {"id","val","desce"};
    int range = 2;
    PageRechercheChoix pr = new PageRechercheChoix(choix, request, listeCrt, listeInt, range, libEntete, libEntete.length);
    pr.setTitre("Page choix Region");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("district/listeChoixRegion.jsp");
    pr.setChampReturn(champReturn);
    
    pr.getFormu().getChamp("id").setLibelle("ID_Region");
    pr.getFormu().getChamp("val").setLibelle("Region");
    pr.getFormu().getChamp("desce").setLibelle("Libelle");

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAff[] = {"ID","Region","Libelle"};
    pr.getTableau().setLibeEntete(libEnteteAff);
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title><%= pr.getTitre() %></title>
        <script type="text/javascript">
            function getChoix() {
                setTimeout("document.listeRegion.submit()", 800);
            }
        </script>
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='../../elements/css.jsp'/>
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
                <form action="../../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="listeRegion" id="listeRegion">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% 
                        
                        out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../../elements/js.jsp'/>
    </body>
</html>