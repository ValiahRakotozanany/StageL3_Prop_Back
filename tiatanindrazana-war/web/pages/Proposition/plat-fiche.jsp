<%-- 
    Document   : plat-fiche.jsp
    Created on : 29 sept. 2023, 22:48:31
    Author     : Valiah Karen
--%>

<%@page import="map.Proposition.Platfille_lib"%>
<%@page import="map.Proposition.Plat"%>
<%@page import="map.Proposition.Platfille"%>
<%@page import="java.util.HashMap"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    Plat a = new Plat();
    a.setNomTable("plat");

    PageConsulte pc = pc = new PageConsulte(a, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin

    pc.getChampByName("id").setLibelle("id");
    pc.getChampByName("nomplats").setLibelle("Plat");
    pc.getChampByName("descri").setLibelle("Descri");
    //  pc.getChampByName("idpoint").setVisible(false);
    // pc.getChampByName("pa").setVisible(false);    
    //pc.getChampByName("pointindisp").setVisible(false);

    pc.setTitre("Consultation Plats");

    Platfille recette = new Platfille();

    Plat base = (Plat) (pc.getBase());
    Platfille_lib[] liste = base.getRecette("platfille_lib", null);

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
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=Proposition/plat-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=Proposition/plat-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                            <a class="btn btn-danger pull-left"  href="<%=(String) session.getValue("lien") + "?but=Proposition/plattyper-saisie.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Ajout TYPE PLAT</a>
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
            <form action="module.jsp?but=apresTarif.jsp" method="post" >
                <div class="box-fiche">
                    <div class="box">
                        <div class="box-title with-border">
                            <h1 class="box-title">Ajout recette</h1>
                        </div>
                        <div class="box-body">

                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Identifiant</th>                                        
                                        <th colspan="2" >Ingredient</th>
                                        <th colspan="2" >Etat de l'ingredient</th>
                                        <th>Quantit&eacute; Adulte</th>
                                        <th>Quantit&eacute; Enfant</th>
                                        <th>Remarque </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td  align="center">
                                            <input name="idplat" type="hidden" value="<%=request.getParameter("id")%>"><%=request.getParameter("id")%>
                                        </td>
                                        <td  align="center">
                                            <input name="idingredient" type="textbox" class="form-control" id="idingredientslibelle" value="" tabindex="2" readonly ><input type="hidden" value="" name="idingredients" id="idingredients">                                        
                                            <input name="choix" type="button" class="submit" onclick="pagePopUp('choix/liste-ingredient.jsp?champReturn=idingredient&apresLienPageAppel=')" value="...">
                                        </td>
                                        <td>
                                              <select name="etatingredient"  class="form-control" id="etatingredient">
                                                  <option value='1'>Obligatoire</option>
                                                  <option value='0'>Facultatif</option>
                                              </select>
                                        </td> 
                                        <td width="14%" align="center">
                                            <input name="valeuradulte" type="textbox" class="form-control" id="valeurenfant" value="0" onblur="calculer('quantiteA')" tabindex="3">
                                        </td>
                                        <td width="14%" align="center">
                                            <input name="valeurenfant" type="textbox" class="form-control" id="valeurenfant" value="0" onblur="calculer('quantiteE')" tabindex="3">
                                        </td>
                                        <td width="14%" align="center">
                                            <input name="remarque" type="text" class="form-control" id="remarque" value="0">
                                        </td>

                                    </tr>
                                </tbody>
                            </table>

                            <input name="acte" type="hidden" id="nature" value="insert">
                            <input name="bute" type="hidden" id="bute" value="Proposition/plat-fiche.jsp&id=<%=request.getParameter("id")%>">
                            <input name="classe" type="hidden" id="classe" value="map.Proposition.Platfille">
                        </div>                      
                        <div class="box-footer">
                            <button type="submit" name="Submit2" class="btn btn-success pull-right" style="margin-right: 25px;">Ajouter ligne</button>
                        </div>


                    </div>
                </div>
            </form>


                    <div class="box-fiche">
                        <div class="box">
                            <div class="box-title with-border">
                                <h1 class="box-title">D&eacute;tails Recettes</h1>
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
                                                <th>Quantit&eacute;</th>
                                                <th>Quantité enfant</th>
                                                <th>Unit&eacute;</th>
                                                <th>Remarque</th>
                                                <th>Etat ingredient</th>
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

                                                <td  align="center"><%=liste[i].getId()%></td>
                                                <td  align="center"><a href="<%=(String) session.getValue("lien")%>?but=produits/as-ingredients-fiche.jsp&id=<%=liste[i].getId()%>"><%=liste[i].getIngredient()%></a></td>
                                                <td width="14%" align="center"><input type="text" id="quantite<%=i%>" name="quantite" value="<%=liste[i].getValeuradulte()%>"></td>
                                                <td width="14%" align="center"><input type="text" id="quantite<%=i%>" name="quantite" value="<%=liste[i].getValeurenfant()%>"></td>

                                                <td  align="right"><%=liste[i].getUnite()%></td>
                                                <td  align="right"><%=liste[i].getRemarque()%></td>
                                                <td  align="right"><%=liste[i].getETATINGREDIENT_LIB()%></td>
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


    </div>                   


