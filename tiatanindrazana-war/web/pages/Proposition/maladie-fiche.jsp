<%-- 
    Document   : maladie-fiche
    Created on : 1 oct. 2023, 23:39:55
    Author     : Valiah Karen
--%>

<%@page import="map.Proposition.PlatMaladie"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.Liste"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageInsert"%>
<%@page import="map.Proposition.IngredientMaladie"%>
<%@page import="map.Proposition.IngredientMaladie_lib"%>
<%@page import="affichage.PageConsulte"%>
<%@page import="map.Proposition.Maladie"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Fiche Maladie</title>
    </head>
    <%
        Maladie a = new Maladie();
        a.setNomTable("MALADIE_lib");

        PageConsulte pc = pc = new PageConsulte(a, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin

        pc.getChampByName("id").setLibelle("id");
        pc.getChampByName("maladie").setLibelle("maladie");
        pc.getChampByName("etat").setVisible(false);
        pc.getChampByName("etatlib").setLibelle("Etat");
        //  pc.getChampByName("idpoint").setVisible(false);
        // pc.getChampByName("pa").setVisible(false);    
        //pc.getChampByName("pointindisp").setVisible(false);

        pc.setTitre("Fiche Maladie");

        //Platfille recette = new Platfille();
        Maladie base = (Maladie) (pc.getBase());
        IngredientMaladie_lib[] liste = base.getRecette("ingredientmaladie_lib", null);

        IngredientMaladie i = new IngredientMaladie();
        PageInsert pi = new PageInsert(i, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
        UserEJB u = (UserEJB) session.getAttribute("u");

        affichage.Champ[] l = new affichage.Champ[1];
        TypeObjet to = new TypeObjet();
        to.setNomTable("etatmaladie_ingredient");
// String[] op = {"a manger", "à eviter"};
        //String[] opvalue = {"1", "0"};
        l[0] = new Liste("etat", to, "VAL", "id");
        pi.getFormu().changerEnChamp(l);
        pi.getFormu().getChamp("idmaladie").setDefaut(request.getParameter("id"));
        pi.getFormu().getChamp("etat").setLibelle("Classe de l'ingredient");
        pi.getFormu().getChamp("idingredient").setPageAppel("choix/liste-ingredientMultiple.jsp");
        pi.preparerDataFormu();

        PlatMaladie plm = new PlatMaladie();
     /*   PlatMaladie[] pliste = null;//base.getPlatMaladie("platmaladie_lib", null);*/
        PageInsert pii = new PageInsert(plm, request, (user.UserEJB) session.getValue("u"));
        pii.setLien((String) session.getValue("lien"));
        pii.getFormu().changerEnChamp(l);
        pii.getFormu().getChamp("idmaladie").setDefaut(request.getParameter("id"));
        pii.getFormu().getChamp("idplat").setLibelle("plat");
        pii.getFormu().getChamp("idplat").setPageAppel("choix/list-platmaladie.jsp");
        pii.preparerDataFormu();

        /*Livreur liv = new Livreur();
    liste[1] = new Liste("idlivreur", liv, "nom", "id");
         */
        // PlatFille[]listeBase=base.decomposerBase(null);
        //double montantTotal=AdminGen.calculSommeDouble(listeBase, "qtetotal");
%>




    <div class="content-wrapper">
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <div class="box-fiche">
                    <div class="box">
                        <div class="box-title with-border">
                            <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=Proposition/maladie-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                        </div>
                        <div class="box-body">
                            <%
                                out.println(pc.getHtml());
                            %>
                            <br/>
                            <div class="box-footer">
                                <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=Proposition/plat-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                                <a class="btn btn-danger pull-left"  href="<%=(String) session.getValue("lien") + "?but=Proposition/plattyper-saisie.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Ajout </a>
                                <a class="btn btn-danger pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=disponiple&isdispo=false&id=" + request.getParameter("id")%>" style="margin-right: 10px">Non disponible</a>
                                <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=disponiple&isdispo=true&id=" + request.getParameter("id")%>" style="margin-right: 10px">Disponible</a>
                                <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=produits/recette-saisie.jsp&idproduit=" + request.getParameter("id")%>" style="margin-right: 10px">Ajouter recette</a>

                            </div>
                            <br/>

                        </div>
                    </div>
                </div>
            </div>
        </div>



        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">      
                <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="reservation-saisie" id="reservation-saisie">
                    <h2>Ingrédients</h2>

                    <%
                        pi.getFormu().makeHtmlInsertTabIndex();
                        out.println(pi.getFormu().getHtmlInsert());
                    %>
                    <input name="acte" type="hidden" id="nature" value="insertMultipleMaladie">
                    <input name="colonne" type="hidden" id="nature" value="idingredient">
                    <input name="bute" type="hidden" id="bute" value="Proposition/maladie-fiche.jsp&id=<%=request.getParameter("id")%>">
                    <input name="classe" type="hidden" id="classe" value="map.Proposition.IngredientMaladie">
                </form>

                <div class="box-fiche">
                    <div class="box">
                        <div class="box-title with-border">
                            <h1 class="box-title">Details Ingredients</h1>
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
                                            <th>Ingredient</th>
                                            <th>Maladie</th>
                                            <th>Etat de l'ingredient</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <%
                                            for (int j = 0; j < liste.length; j++) {
                                        %>
                                        <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''">
                                            <td align="center">
                                                <input type="checkbox" value="<%=liste[j].getId()%>-<%=j%>" name="id" id="checkbox0">
                                            </td>

                                            <td  align="center"><%=liste[j].getId()%></td>
                                            <td  align="center"><a href="<%=(String) session.getValue("lien")%>?but=Produit/as-ingredients-fiche.jsp&id=<%=liste[j].getId()%>"><%=liste[j].getIngredient()%></a></td>
                                            <td width="14%" align="center"><%=liste[j].getMaladie()%></td>
                                            <td width="14%" align="center"><%=liste[j].getEtatingredient()%></td>

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
            </div>

        </div>
        <div class="row">

            <div class="col-md-3"></div>
            <div class="col-md-6">
                <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="reservation-saisie" id="reservation-saisie">
                    <h2>Plats</h2>

                    <%
                        pii.getFormu().makeHtmlInsertTabIndex();
                        out.println(pii.getFormu().getHtmlInsert());
                    %>
                    <input name="acte" type="hidden" id="nature" value="insert">
                    <input name="colonne" type="hidden" id="nature" value="idplat">
                    <input name="bute" type="hidden" id="bute" value="Proposition/maladie-fiche.jsp&id=<%=request.getParameter("id")%>">
                    <input name="classe" type="hidde"n" id="classe" value="map.Proposition.PlatMaladie">
                </form>

                <div class="box-fiche">
                    <div class="box">
                        <div class="box-title with-border">
                            <h1 class="box-title">Listes</h1>
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
                                            <th>Plat</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                    

                                    </tbody>
                                </table>

                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>

</html>
