
<%@ page import="antenne.*" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
        //Variable de navigation
        String classeMere = "antenne.District";
        String classeFille = "antenne.Commune";
        String butApresPost = "district/district-liste.jsp";
        String colonneMere = "iddistrict";

        //Definition de l'affichage
        String id = request.getParameter("id");
        District  mere = new District();
        mere.setNomTable("District");   
        Commune fille = new Commune();
        fille.setNomTable("Commune");
        fille.setIddistrict(id);
        Commune[] details = (Commune[])CGenUtil.rechercher(fille, null, null, "");  
        PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, details, request, (user.UserEJB) session.getValue("u"), 2);

        //Information globale
        pi.setLien((String) session.getValue("lien"));

        //Modification affichage mère
        affichage.Champ[] liste = new affichage.Champ[1];
        TypeObjet region=new TypeObjet();
        region.setNomTable("region");

        liste[0] = new Liste("idregion", region, "val", "id");
        pi.getFormu().changerEnChamp(liste);

        pi.getFormu().getChamp("idregion").setLibelle("Region");
        pi.getFormu().getChamp("nom").setLibelle("Libelle");

        pi.getFormufle().getChamp("id_0").setLibelle("ID_Commune");
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("iddistrict"),false);
        affichage.Champ.setAutre(pi.getFormufle().getChampFille("id"),"readonly");
        pi.getFormufle().getChamp("nom_0").setLibelle("Libelle");       
        
        //Preparer affichage
        pi.preparerDataFormu();
        pi.getFormu().makeHtmlInsertTabIndex();
        pi.getFormufle().makeHtmlInsertTableauIndex();
        String titre="Page modification district";
    
%>
<div class="content-wrapper">
        <h1><%=titre%></h1>
        <form action="<%=(String) session.getValue("lien")%>?but=apresMultiple.jsp&id=<%out.print(request.getParameter("id"));%>" method="post">
            <div class="row">
                <div class="col-md-10 col-md-offset-1">
                <%    
                    out.println(pi.getFormu().getHtmlInsert());
                %>
                </div>
            </div>  
            <div class="row">
                <div class="col-md-10 col-md-offset-1">
                    <%
                        out.println(pi.getFormufle().getHtmlTableauInsert());
                    %>
                </div>
            </div>           
            <input name="acte" type="hidden" id="acte" value="updateInsert">
            <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
            <input name="classe" type="hidden" id="classe" value="<%= classeMere %>">
            <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
            <input name="classefille" type="hidden" id="classefille" value="<%= classeFille %>">
            <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=pi.getNombreLigne()%>">
            <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMere %>">                        
        </form>  
</div>
<%
	} catch (Exception e) {
		e.printStackTrace();
%>
    <script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
<% }%>
