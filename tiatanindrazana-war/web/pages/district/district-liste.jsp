
<%@page import="antenne.*"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    DistrictLibComplet district = new DistrictLibComplet();
    district.setNomTable("districtlibcomplet");
    String listeCrt[] = {"id", "regionvallib","nom"};
    String listeInt[] = {};
    String libEntete[] = {"id", "regionvallib", "nom"};
    PageRecherche pr = new PageRecherche(district, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Liste district");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("district/district-liste.jsp");
    pr.getFormu().getChamp("regionvallib").setLibelle("Region");
    pr.getFormu().getChamp("nom").setLibelle("District");
    pr.getFormu().getChamp("id").setLibelle("Id");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    String lienTableau[] = {pr.getLien() + "?but=district/district-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    String libEnteteAffiche[] = {"ID", "Region", "District"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
    <%
    }catch(Exception e){

        e.printStackTrace();
    }
%>



