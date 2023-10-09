
<%@page import="map.CommuneLibComplet"%>
<%@page import="antenne.*"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    CommuneLibComplet commune = new CommuneLibComplet();
    commune.setNomTable("v_commune_lib_complet");
    String listeCrt[] = {"id", "iddistrictlib","nom"};
    String listeInt[] = {};
    String libEntete[] = {"id","iddistrictlib", "nom"};
    PageRecherche pr = new PageRecherche(commune, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Liste Commune");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("commune/commune-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    pr.getFormu().getChamp("iddistrictlib").setLibelle("District");
    pr.getFormu().getChamp("nom").setLibelle("Commune");
    String lienTableau[] = {pr.getLien() + "?but=commune/commune-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    String libEnteteAffiche[] = {"ID","District","Libelle"};
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



