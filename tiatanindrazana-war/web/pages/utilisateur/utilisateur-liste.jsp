<%@page import="historique.MapUtilisateur"%>
<%@page import="affichage.PageRecherche"%>
<%
    try {
    MapUtilisateur cnaps = new MapUtilisateur();
    cnaps.setNomTable("utilisateur");
    String listeCrt[] = {"refuser","loginuser", "idrole", "nomuser", "teluser"};
    String listeInt[] = {"rang"};
    String libEntete[] = {"refuser","loginuser", "idrole", "nomuser","adruser","teluser"};
    PageRecherche pr = new PageRecherche(cnaps, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.getFormu().getChamp("teluser").setLibelle("telephone");
    pr.getFormu().getChamp("refuser").setLibelle("Reference");
    pr.getFormu().getChamp("loginuser").setLibelle("Login");
    pr.getFormu().getChamp("nomuser").setLibelle("Nom et prenom");
    pr.getFormu().getChamp("idrole").setLibelle("Role");
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("utilisateur/utilisateur-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste Utilisateur</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=utilisateur/utilisateur-liste.jsp" method="post" name="listeUtilisateur" id="listeUtilisateur">
            <%

                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=utilisateur/utilisateur-fiche.jsp"};
            String colonneLien[] = {"refuser"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
                                    //"refuser","loginuser", "idrole", "nomuser","adruser","teluser","rang"
            String libEnteteAffiche[] = {"R&eacute;f&eacute;rence utilisateur","Login","Role", "Nom", "Adresse", "Telephone"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
</div>
    <%} catch (Exception e) {
        e.printStackTrace();
    }
    %>