<%-- 
    Document   : maladie-liste
    Created on : 1 oct. 2023, 23:12:20
    Author     : Valiah Karen
--%>

<%@page import="map.Proposition.Maladie"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Maladie</title>
    </head>
 

<% 
    try{
    Maladie plat = new Maladie();
    //plat.setNomTable("plat");
    String listeCrt[] = {"id","maladie"};
    String listeInt[] = {};
    String libEntete[] = {"id", "maladie"};
  PageRecherche pr = new PageRecherche(plat, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Liste Maladie");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("Proposition/maladie-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>

       
 <div class="wrapper">   
    <aside class="main-sidebar">

                <section class="sidebar">

                    <div class="user-panel">
                        <div class="pull-left image">
                            <img src="../../dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
                        </div>
                       
                    </div>

                    <form action="#" method="get" class="sidebar-form">
                        <div class="input-group">
                            <input type="text" name="q" class="form-control" placeholder="Search...">
                            <span class="input-group-btn">
                                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                                </button>
                            </span>
                        </div>
                    </form>

                    <ul class="sidebar-menu" data-widget="tree">
                        <li class="header"></li>
                        <li class="treeview">
                            <a href="#">
                                <i class="fa fa-dashboard"></i> <span>Maladie</span>
                                <span class="pull-right-container">
                                    <i class="fa fa-angle-left pull-right"></i>
                                </span>
                            </a>
                            <ul class="treeview-menu" data-widget="tree">
                                <li><a href="module.jsp?but=Proposition/maladie-liste.jsp"><i class="fa fa-circle-o"></i> Liste</a></li>
                                <li><a href="module.jsp?but=Proposition/maladie-saisie.jsp"><i class="fa fa-circle-o"></i> Ajout</a></li>
                            </ul>
                        </li>
                        <li class="treeview" data-widget="tree">
                            <a href="#">
                                <i class="fa fa-files-o"></i>
                                <span>Plat</span>
                                <span class="pull-right-container">
                                    <span class="label label-primary pull-right"></span>
                                </span>
                            </a>
                            <ul class="treeview-menu" data-widget="tree">
                                <li><a href="module.jsp?but=Proposition/plat-liste.jsp"><i class="fa fa-circle-o"></i>Liste</a></li>
                                <li><a href="module.jsp?but=Proposition/plat-saisie.jsp"><i class="fa fa-circle-o"></i> Ajout </a></li>                                                                
                            </ul>
                        </li>
                        <li class="treeview">
                            <a href="#">
                                <i class="fa fa-files-o"></i>
                                <span>Ingredient</span>
                                <span class="pull-right-container">
                                    <span class="label label-primary pull-right"></span>
                                </span>
                            </a>
                            <ul class="treeview-menu">
                                <li><a href="module.jsp?but=Proposition/ingredient-liste.jsp"><i class="fa fa-circle-o"></i>Liste</a></li>
                                <li><a href="module.jsp?but=Proposition/ingredient-saisie.jsp"><i class="fa fa-circle-o"></i> Ajout </a></li>                                                                
                            </ul>
                        </li>
                        <li>
                           <a href="module.jsp?but=Proposition/Statistique.jsp">
                                <i class="fa fa-th"></i> <span>Statistiques</span>
                                <span class="pull-right-container">
                                    <small class="label pull-right bg-green">new</small>
                                </span>
                            </a>
                        </li>
                        
                    </ul>
                </section>

            </aside>
<div class="content-wrapper">  
    <section class="content-header">
        <h1>Liste Maladies</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=Proposition/maladie-liste.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>

        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=Proposition/maladie-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id", "maladie"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
    <div class="box-footer">
                           <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=Proposition/Maladie-saisie.jsp"%>" style="margin-right: 10px">Ajouter recette</a>
                        </div>
</div>
    <%}catch(Exception e){e.printStackTrace();}%>
>
 </div>
</html>
