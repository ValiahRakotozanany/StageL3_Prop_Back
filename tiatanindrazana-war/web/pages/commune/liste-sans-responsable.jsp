

<%@page import="map.Region"%>
<%@page import="antenne.District"%>
<%@page import="map.CommuneLibComplet"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="affichage.Liste"%>
<% try{ 
    CommuneLibComplet t = new CommuneLibComplet();
    t.setNomTable("V_COMMUNE_SANS_RESPONSABLE");
    String listeCrt[] = { "nom","iddistrict","idregion"};
    String listeInt[] = {};
    String libEntete[] = {"idregionlib","iddistrictlib", "nom"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Liste des communes sans responsables");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("commune/liste-sans-responsable.jsp");
    
    
    Liste[] liste = new Liste[2];
    District district = new District();
    liste[0] = new Liste("iddistrict",district,"nom","id");
    Region region = new Region();
    liste[1] = new Liste("idregion",region,"val","id");
    liste[1].setApresW(" AND val!='-' ");
    pr.getFormu().changerEnChamp(liste);
    pr.getFormu().getChamp("nom").setLibelle("Nom du commune");
    pr.getFormu().getChamp("iddistrict").setLibelle("Nom du district");
    pr.getFormu().getChamp("idregion").setLibelle("Nom du region");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=commune/commune-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    //Definition des libelles � afficher
    String libEnteteAffiche[] = {"Region","District","Commune"};
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



