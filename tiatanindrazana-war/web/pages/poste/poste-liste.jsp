

<%@page import="user.UserEJB"%>
<%@page import="antenne.Commune"%>
<%@page import="antenne.District"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.Liste"%>
<%@page import="map.PosteLibComplet"%>
<%@page import="affichage.PageRecherche"%>
<% try{ 
    UserEJB user = (user.UserEJB) session.getValue("u");
    if(user.getUser().getIdrole().compareToIgnoreCase("dg")==0){
    PosteLibComplet t = new PosteLibComplet();
    String[] etatPosteVal = {"v_poste_lib_complet","v_poste_disponible", "v_poste_non_disponible"};
    String[] etatPosteAff = {"Tous", "Disponible", "Non disponible"};
    t.setNomTable(etatPosteVal[0]);
    if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
        t.setNomTable(request.getParameter("etat"));
    }
    String listeCrt[] = {"nom", "idregionlib","iddistrictlib","idcommunelib","nompersonne","prenompersonne"};
    String listeInt[] = {};
    String libEntete[] = {"id", "nom", "idregionlib","iddistrictlib","idcommunelib","idPersonne","nompersonne","prenompersonne"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Liste des postes");
    pr.setUtilisateur(user);
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("poste/poste-liste.jsp");
    
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
    
    pr.getFormu().getChamp("idregionlib").setLibelle("Region");
    pr.getFormu().getChamp("iddistrictlib").setLibelle("District");
    pr.getFormu().getChamp("idcommunelib").setLibelle("Commune");
    
    pr.getFormu().getChamp("nompersonne").setLibelle("Nom Personne");
    pr.getFormu().getChamp("prenompersonne").setLibelle("Pr&eacute;nom Personne");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=poste/poste-fiche.jsp", pr.getLien() + "?but=personne/inscription-fiche.jsp"};
    String colonneLien[] = {"id","idPersonne"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    //Definition des libelles ï¿½ afficher
    String libEnteteAffiche[] = {"ID", "Nom", "Region","District","Commune","ID Personne","Nom Personne","Pr&eacute;nom Personne"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
%>
<script>
    function getEtatPoste(){
        document.listePoste.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post" name="listePoste" id="listePoste">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat : 
                    <select name="etat" class="champ" id="etat" onchange="getEtatPoste()" >
                        <%for(int i=0; i<etatPosteVal.length; i++){
                            String selected = etatPosteVal[i].equalsIgnoreCase(t.getNomTable()) ? "selected" : "";
                        %>
                        <option value="<%=etatPosteVal[i]%>" <%=selected%>><%=etatPosteAff[i]%></option>
                        <%}%>
                    </select>
                </div>
            </div>
        </form>
        <br>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
    <%
        }else{
%>

    <div class="content-wrapper">
        <p>Vous n'êtes pas autorisé à voir !</p>
    </div>

<%
        }
    }catch(Exception e){

        e.printStackTrace();
    }
%>



