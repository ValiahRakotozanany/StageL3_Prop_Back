<%@page import="lc.Direction"%>
<%@page import="affichage.Liste"%>
<%@page import="utilisateur.Role"%>
<%@page import="affichage.PageInsert"%>
<%@page import="historique.MapUtilisateur"%>
<%@page import="bean.CGenUtil"%>   
<% 
    try{
    MapUtilisateur user = new MapUtilisateur();

        PageInsert pi = new PageInsert(user, request, (user.UserEJB) session.getValue("u"));
        pi.getFormu().getChamp("loginuser").setLibelle("login");
        pi.getFormu().getChamp("pwduser").setLibelle("mot de passe");
        pi.getFormu().getChamp("idrole").setLibelle("role");
        pi.getFormu().getChamp("nomuser").setLibelle("nom");
        pi.getFormu().getChamp("teluser").setLibelle("num�ro de t�l�phone");
         pi.getFormu().getChamp("pwduser").setType("password");
        affichage.Champ[] liste = new affichage.Champ[2];
        Role ou = new Role();
        liste[0] = new Liste("idrole", ou, "descrole", "idrole");
        Direction dir = new Direction();
        liste[1] = new Liste("adruser", dir, "libelledir", "iddir");
        pi.getFormu().changerEnChamp(liste);
        pi.setLien((String) session.getValue("lien"));
         pi.preparerDataFormu();
  %>
  <div class="content-wrapper">
    <h1>Saisie utilisateur</h1>    <!--  -->
    <form action="<%=pi.getLien()%>?but=utilisateur/apresUtilisateur.jsp" method="post" name="utilisateur-saisie" id="utilisateur-saisie">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
   
    <input name="acte" type="hidden" id="acte" value="insert">
    <input name="bute" type="hidden" id="bute" value="utilisateur/utilisateur-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="historique.MapUtilisateur">
    </form>
    
</div>
    <%}catch(Exception ex){
    ex.printStackTrace();
}%>

