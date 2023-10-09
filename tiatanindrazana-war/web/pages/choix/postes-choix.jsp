

<%@page import="antenne.Commune"%>
<%@page import="antenne.District"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.Liste"%>
<%@page import="map.PosteLibComplet"%>
<%@page import="affichage.PageRechercheChoix"%>
<%
    try{
    String champReturn = request.getParameter("champReturn");
    PosteLibComplet choix = new PosteLibComplet();
    choix.setNomTable("v_poste_disponible");
    String listeCrt[] = {"nom", "idregion","iddistrict","idcommune"};
    String listeInt[] = {};
    String libEntete[] = {"id", "nom", "idregionlib","iddistrictlib","idcommunelib"};
    int range = 2;
    PageRechercheChoix pr = new PageRechercheChoix(choix, request, listeCrt, listeInt, range, libEntete, libEntete.length);
    pr.setNpp(100);
    pr.setTitre("Choix Poste");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("postes-choix.jsp");
    pr.setChampReturn(champReturn);
    
    Liste[] liste = new Liste[3]; 
    TypeObjet region = new TypeObjet();
    region.setNomTable("region");
    District district = new District();
    district.setNomTable("district");
    Commune commune = new Commune();
    commune.setNomTable("commune");
    liste[0] = new Liste("idregion", region, "val", "id"); 
    liste[1] = new Liste("iddistrict",district,"nom","id");
    liste[0].setDeroulanteDependante(liste[1],"idregion","onchange");
    liste[2] = new Liste("idcommune",commune,"nom","id");
    liste[1].setDeroulanteDependante(liste[2], "iddistrict", "onchange");
    pr.getFormu().changerEnChamp(liste);
    
    pr.getFormu().getChamp("idregion").setLibelle("Region");
    pr.getFormu().getChamp("iddistrict").setLibelle("District");
    pr.getFormu().getChamp("idcommune").setLibelle("Commune");
    

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAff[] = {"ID", "Nom", "Region","District","Commune"};
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
        <script>
            $("document").ready(()=>{
                let link = $("[onclick*='idcommune']")[0].getAttribute("onclick");
                let newLink = link.substring(0,link.length-2)+`&idDistrict=`+$("[name='iddistrict']").val()+link.substring(link.length-2,link.length);
                $("[onclick*='idcommune']")[0].setAttribute("onclick",newLink);
                $("[name='district']").on('change',()=>{
                    let newLink = link.substring(0,link.length-2)+`&idDistrict=`+$("[name='iddistrict']").val()+link.substring(link.length-2,link.length);
                    $("[onclick*='idcommune']")[0].setAttribute("onclick",newLink);
                });
            });
    </script>
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