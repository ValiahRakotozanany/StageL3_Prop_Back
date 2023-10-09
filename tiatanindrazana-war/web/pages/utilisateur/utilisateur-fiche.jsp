<%-- 
    Document   : as-ordonnerpaiement-fiche
    Created on : 8 d�c. 2016, 08:28:08
    Author     : Joe
--%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="mg.allosakafo.fin.*"%>
<%@page import="utilisateur.Utilisateur"%>
<%
    Utilisateur a = new Utilisateur();
    //a.setNomTable("as_paiement_libelle");
    PageConsulte pc = pc = new PageConsulte(a, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    pc.getChampByName("pwduser").setVisible(false);
    pc.getChampByName("Refuser").setLibelle("Reference utilisateur");
    pc.getChampByName("Loginuser").setLibelle("Login");
    pc.getChampByName("Nomuser").setLibelle("Nom");
    pc.getChampByName("Teluser").setLibelle("Telephone");
    pc.getChampByName("Idrole").setLibelle("Role");
    pc.setTitre("Utilisateur fiche");

    // MapUtilisateur orp = (MapUtilisateur) pc.getBase();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=utilisateur/utilisateur-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=utilisateur/utilisateur-modif.jsp&refuser=" + request.getParameter("refuser")%>" style="margin-right: 10px">Modifier</a>

                        <a class="btn btn-primary pull-right"  href="<%=(String) session.getValue("lien") + "?but=utilisateur/apresUtilisateur.jsp&acte=activer&idUser=" + request.getParameter("refuser")%>" style="margin-right: 10px">Activ&eacute;</a>
                        <a class="btn btn-danger pull-right"  href="<%=(String) session.getValue("lien") + "?but=utilisateur/apresUtilisateur.jsp&acte=desactiver&idUser=" + request.getParameter("refuser")%>" style="margin-right: 10px">D&eacute;sactiv&eacute;</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%out.println(pc.getBasPage());%>
</div>