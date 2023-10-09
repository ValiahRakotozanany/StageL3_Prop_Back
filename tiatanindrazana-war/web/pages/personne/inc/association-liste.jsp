
<%@page import="map.EntitePersonneLibComplet"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    EntitePersonneLibComplet t = new EntitePersonneLibComplet();
    t.setNomTable("V_ENTITE_PERSONNE_LIB_COMPLET");
    String listeCrt[] = {"idPersonne"};
    String listeInt[] = {};
    String libEntete[] = {"id","denomination","siege","effectif","activite","dateCreation","circonscription","contact"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Liste des associations");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("personne/inc/association-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    
    //Definition des libelles à afficher
    String libEnteteAffiche[] = {"ID","Denomination","Siege","Effectif","Activite","Date de creation","Circonscription","Contact"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
%>

<div class="">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        
        <%
            out.println(pr.getTableau().getHtml());%>
        <br>
    </section>
</div>
    <%
    }catch(Exception e){

        e.printStackTrace();
    }
%>



