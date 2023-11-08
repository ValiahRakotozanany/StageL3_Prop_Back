<%-- 
    Document   : plat-saisie
    Created on : 1 oct. 2023, 17:40:41
    Author     : Valiah Karen
--%>

<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.PageInsert"%>
<%@page import="map.Proposition.Plat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Ajout Plat</title>
    </head> 

<%
    //String autreparsley = "data-parsley-range='[8, 40]' required";
    Plat  a = new Plat();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));    
    
    //affichage.Champ[] liste = new affichage.Champ[1];
    
    /*TypeObjet op = new TypeObjet();
    op.setNomTable("plat");
    liste[0] = new Liste("typeproduit", op, "VAL", "id");
    */
    //pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("nomplats").setLibelle("Nom Plat");
    pi.getFormu().getChamp("descri").setType("textarea");
        
    /*pi.getFormu().getChamp("code").setLibelle("Code");
    pi.getFormu().getChamp("designation").setLibelle("Libelle");
    pi.getFormu().getChamp("seuil").setLibelle("Seuil");
    pi.getFormu().getChamp("unite").setLibelle("Unité");
    pi.getFormu().getChamp("presentation").setLibelle("Presentation");
    pi.getFormu().getChamp("typearticle").setLibelle("Type");
    pi.getFormu().getChamp("groupee").setLibelle("Groupe");
    pi.getFormu().getChamp("sousgroupe").setLibelle("Sous groupe");
    pi.getFormu().getChamp("chapitre").setLibelle("Chapitre");
    pi.getFormu().getChamp("constante").setLibelle("Constante");*/
    
    pi.preparerDataFormu();
%>



       
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
    <h1>Nouveau Plat</h1>
    <!--  -->
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="starticle" id="starticle">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="Proposition/plat-saisie.jsp">
    <input name="classe" type="hidden" id="classe" value="map.Proposition.Plat">
    </form>
</div>
    
 </div>
    </html>