

<%@page import="user.UserEJB"%>
<%@page import="antenne.Commune"%>
<%@page import="antenne.District"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.Liste"%>
<%@page import="map.PosteLibComplet"%>
<%@page import="affichage.PageRecherche"%>
<% try{ 
    UserEJB u = (UserEJB) session.getValue("u");
    if(u.getUser().getIdrole().equals("dg")){
    PosteLibComplet t = new PosteLibComplet();
    t.setNomTable("v_poste_lib_complet");
   
    String listeCrt[] = {"idPersonne"};
    String listeInt[] = {};
    String libEntete[] = {"id", "nom", "idregionlib","iddistrictlib","idcommunelib","nompersonne","prenompersonne"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Liste des postes");
    pr.setUtilisateur(u);
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("poste/poste-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    //Definition des libelles ï¿½ afficher
    String libEnteteAffiche[] = {"ID", "Nom", "Region","District","Commune","Nom Personne","Pr&eacute;nom Personne"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
%>
<script>
    function getEtatPoste(){
        document.listePoste.submit();
    }
</script>
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <br>
        <%
            out.println(pr.getTableau().getHtml());
        %>
    </section>

    <%
        }else{
%>

    <section class="content-header">
        
    </section>
    <section class="content">
        <br>
        Vous n'êtes pas autorisé à voir !
    </section>

<%
        }
    
    }catch(Exception e){

        e.printStackTrace();
    }
%>



