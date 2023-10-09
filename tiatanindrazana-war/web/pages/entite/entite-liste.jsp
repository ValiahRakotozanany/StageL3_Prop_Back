
<%@page import="map.V_ENTITE_LIBCOMPLET"%>
<%@page import="map.Entite"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html"%>
<%  
    try{
   V_ENTITE_LIBCOMPLET entite = new V_ENTITE_LIBCOMPLET();
   entite.setNomTable("V_ENTITE_LIB_COMPLET");

   /*
  create view V_ENTITE_LIB_COMPLET as 
(
	select e.id,e.denomination,e.siege,e.effectif,e.activite,e.dateCreation,e.circonscription,e.contact,t.val AS typeEntite
   	from entite e join typeentite t on e.idtype=t.id
);
   
   */
    String libEntete[] = {"id","denomination","siege", "effectif", "activite","datecreation","circonscription","contact","typeentite"};
    String listeCrt[] = {"id","denomination","siege", "effectif", "activite","datecreation","circonscription","contact","typeentite"};
    String listeInt[] = {""};
    String libEnteteAffiche[] = {"Id","Denomination","Siege", "Effectif", "Activite","DateCreation","Circonscription","Contact","Type Entite"};
    
    PageRecherche pr = new PageRecherche(entite, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    pr.setApres("entite/entite-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme); 
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
    
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste entite</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=entite/entite-liste.jsp" method="post" name="prestation" id="prestation">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=entite/entite-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <% 
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>

