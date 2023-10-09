<%-- 
    Document   : plattyper-saisie.jsp
    Created on : 1 oct. 2023, 21:33:25
    Author     : Valiah Karen
--%>

<%@page import="map.Proposition.Plat"%>
<%@page import="bean.CGenUtil"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.PageInsert"%>
<%@page import="map.Proposition.PlatTyper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Type plat</title>
    </head>

    <%
        //String autreparsley = "data-parsley-range='[8, 40]' required";
        PlatTyper a = new PlatTyper();
        PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));

        affichage.Champ[] l = new affichage.Champ[1];

        TypeObjet op = new TypeObjet();
        op.setNomTable("typeplat");
        l[0] = new Liste("idtypeplat", op, "VAL", "id");

        pi.getFormu().changerEnChamp(l);

        //pi.getFormu().getChamp("idplat").setVisible(false);
        pi.getFormu().getChamp("idplat").setDefaut(request.getParameter("id"));
        pi.getFormu().getChamp("idplat").setAutre("readonly='true'");
        /*pi.getFormu().getChamp("designation").setLibelle("Libelle");
        pi.getFormu().getChamp("seuil").setLibelle("Seuil");
        pi.getFormu().getChamp("unite").setLibelle("Unité");
        pi.getFormu().getChamp("presentation").setLibelle("Presentation");
        pi.getFormu().getChamp("typearticle").setLibelle("Type");
        pi.getFormu().getChamp("groupee").setLibelle("Groupe");
        pi.getFormu().getChamp("sousgroupe").setLibelle("Sous groupe");
        pi.getFormu().getChamp("chapitre").setLibelle("Chapitre");
        pi.getFormu().getChamp("constante").setLibelle("Constante");*/
        System.out.println("ID  ==|||||  > " + request.getParameter("id"));
        pi.preparerDataFormu();
        Plat plat = new Plat();
        plat.setId(request.getParameter("id"));
        Plat[] liste = plat.getTypePlat(null, null);


    %>
    <div class="content-wrapper">
        <h1>Ajout type de Plat</h1>
        <!--  -->
        <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="starticle" id="starticle">
            <input name="acte" type="hidden" id="nature" value="insert"> 
            <input name="bute" type="hidden" id="bute" value="Proposition/plattyper-saisie.jsp&id=<%=request.getParameter("id")%>">
            <input name="classe" type="hidden" id="classe" value="map.Proposition.PlatTyper">
            <%
                pi.getFormu().makeHtmlInsertTabIndex();
                out.println(pi.getFormu().getHtmlInsert());
            %>

        </form>
        <div class="box-fiche">
            <div class="box">
                <div class="box-title with-border">
                    <h1 class="box-title">Types du plat</h1>
                </div>
                
                <form action="<%=(String) session.getValue("lien")%>?but=modifierEtatMultiple.jsp" method="post" name="incident" id="incident">
                    <div class="box-body table-responsive">
                        <input type="hidden" name="bute" value="produits/as-produits-fiche.jsp&id=<%=request.getParameter("id")%>"/>

                        <button type="submit" name="acte" value="modifier_recette" class="btn btn-success pull-right" style="margin-right: 25px;" >Modifier</button> 
                        <button type="submit" name="acte" value="supprimer_recette" class="btn btn-danger pull-left" style="margin-right: 25px;" >Supprimer</button> 

                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th align="center" valign="top" style="background-color:#bed1dd">
                                        <input onclick="CocheToutCheckbox(this, 'id')" type="checkbox">
                                    </th>
                                    <th> Id</th>
                                    <th>Types</th>
                                </tr>
                            </thead>

                            <tbody>
                                <%
                                    for (int i = 0; i < liste.length; i++) {
                                %>
                                <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''">
                                    <td align="center">
                                        <input type="checkbox" value="<%=liste[i].getId()%>-<%=i%>" name="id" id="checkbox0">
                                    </td>

                                    <td  align="center"><%=liste[i].getNomplats()%></td>                                                                     
                                    <td  align="center"><%=liste[i].getTypeplat()%></td>                                                                     
                                </tr>
                                <%
                                    }
                                %>

                            </tbody>
                        </table>

                    </div>
                </form>
            </div>

        </div>
</html>
</html>
