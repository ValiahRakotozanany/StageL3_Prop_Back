

<%@page import="antenne.District"%>
<%@page import="map.Attente"%>
<%@page import="map.AssociationEntitePersonne"%>
<%@page import="map.PersonneInsertion"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="constante.ConstanteAffichage" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0-rc.0/js/select2.min.js"></script>
<%
    try{
    //Variable de navigation
    String classeMere = "map.PersonneInsertion";
    String classeFille = "map.AssociationEntitePersonne";
    String butApresPost = "personne/inscription-liste.jsp";
    String colonneMere = "idPersonne";
    //Definition de l'affichage
    String id = request.getParameter("id");
    PersonneInsertion mere = new PersonneInsertion();   
    AssociationEntitePersonne fille = new AssociationEntitePersonne();
    fille.setIdPersonne(id);
    AssociationEntitePersonne[] details = (AssociationEntitePersonne[])CGenUtil.rechercher(fille, null, null, "");  
    PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, details, request, (user.UserEJB) session.getValue("u"), 2);
    //Information globale
    pi.setLien((String) session.getValue("lien"));
    //Modification affichage m re
    pi.getFormu().getChamp("job").setLibelle("Poste actuel *");
    pi.getFormu().getChamp("compteFB").setLibelle("Compte FB");
    pi.getFormu().getChamp("idresponsable").setVisible(false);
    pi.getFormu().getChamp("traitement").setVisible(false);
    pi.getFormu().getChamp("idPoste").setVisible(false);
    pi.getFormu().getChamp("demandes").setAutre("readonly");
    pi.getFormu().getChamp("demandes").setLibelle("Demandes *");
    pi.getFormu().getChamp("demandes").setPageAppel("choix/demandes-choix.jsp");
    pi.getFormu().getChamp("idTypeTraitement").setVisible(false);

    Attente attente = new Attente();
    attente.setNomTable("attente");
    /*TypeObjet region = new TypeObjet();
    region.setNomTable("region");
    District district = new District();
    district.setNomTable("district");*/
    affichage.Liste[] liste = new affichage.Liste[2];
    liste[0] = new Liste("idAttente", attente, "val", "id"); 
    String[] valeurs = {"M","F"};
    String[] affiches = {"homme","femme"};
    liste[1] = new Liste("sexe" ,affiches,valeurs);
    /*liste[2] = new Liste("region", region, "val", "id"); 
    liste[3] = new Liste("district",district,"nom","id");
    liste[2].setDeroulanteDependante(liste[3],"idregion","onchange");*/

    /* Changement 23-08-2023 */
    pi.getFormu().getChamp("region").setPageAppel("choix/region-choix.jsp");
    pi.getFormu().getChamp("district").setPageAppel("choix/district-choix.jsp");
    //pi.getFormu().getChamp("region").setAutre("onchange='handleChange()'");
    /*-----------------------*/
    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("idAttente").setLibelle("Quels sont vos attentes ? *");
    pi.getFormu().getChamp("champLibre").setLibelle("Remarque *");
    pi.getFormu().getChamp("champLibre").setType("textarea");
    pi.getFormu().getChamp("champLibre").setCss("big-textarea");
    pi.getFormu().getChamp("communes").setPageAppel("choix/commune-choix.jsp");
    pi.getFormu().getChamp("region").setAutre("readOnly");
    pi.getFormu().getChamp("communes").setAutre("readOnly");
    pi.getFormu().getChamp("district").setAutre("readOnly");
    pi.getFormu().getChamp("nom").setLibelle("Nom *");
    pi.getFormu().getChamp("prenom").setLibelle("Prenom");
    pi.getFormu().getChamp("telephone").setLibelle("Telephone *");
    pi.getFormu().getChamp("region").setLibelle("Region *");
    pi.getFormu().getChamp("district").setLibelle("District *");
    pi.getFormu().getChamp("communes").setLibelle("Communes *");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("cible").setVisible(false);
    pi.getFormu().getChamp("attenteDetaille").setLibelle("Attentes detaill&eacute;es*");
    pi.getFormu().getChamp("atout").setLibelle("Atouts*");
    pi.getFormu().getChamp("rdv").setLibelle("Rendez-vous");
    pi.getFormu().getChamp("rdv").setAutre("readonly");
    pi.getFormu().getChamp("rdv").setType(ConstanteAffichage.timestamp);
    pi.getFormufle().getChamp("rolePersonne_0").setLibelle("Role");
    pi.getFormufle().getChamp("idEntite_0").setLibelle("Entit&eacute;");
    for(int i=0;i < pi.getFormufle().getChampFille("idEntite").length;i++){
        pi.getFormufle().getChampFille("idEntite")[i].setPageAppel("choix/entite-choix.jsp","idEntite_"+i+";idEntitelibelle_"+i);
        pi.getFormufle().getChampFille("idEntite")[i].setAutre("readOnly");
    }
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("idPersonne"),false); 
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"),false); 
    String[] listOrdre = {"id","nom", "prenom","age","sexe","domicile","job","mail","compteFB","whatsapp","telephone","region","district","communes","idAttente","attenteDetaille","atout","champLibre","traitement","idresponsable","idPoste","demandes","etat","idTypeTraitement","cible","rdv"};
    pi.getFormu().setOrdre(listOrdre);
    //Preparer affichage
    pi.preparerDataFormu();
    pi.getFormu().makeHtmlInsertTabIndex();
    pi.getFormufle().makeHtmlInsertTableauIndex();
    
%>
<div class="content-wrapper">
    <div class="row">
        
            <div class="box-fiche">
                <div class="box">
                    <h1>Interview antenne</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresMultiple.jsp&id=<%out.print(request.getParameter("id"));%>" method="post">
                        <div class="row">
                            <div class="col-md-10 col-md-offset-1">
                            <%    
                                out.println(pi.getFormu().getHtmlInsert());
                            %>
                            </div>
                        </div>  
                        <div class="row">
                            <div class="col-md-10 col-md-offset-1">
                                <%
                                    out.println(pi.getFormufle().getHtmlTableauInsert());
                                %>
                            </div>
                        </div>           
                        <input name="acte" type="hidden" id="acte" value="interview">
                        <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
                        <input name="classe" type="hidden" id="classe" value="<%= classeMere %>">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="classefille" type="hidden" id="classefille" value="<%= classeFille %>">
                        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=pi.getNombreLigne()%>">
                        <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMere %>">                        
                    </form>
                </div>
            </div>
    </div>
</div>

<script>
   $(document).ready(() => {
        let linkRegion=$("[onclick*='district']")[0].getAttribute("onclick");
        let previousValue = $("#region").val();
        let newLinkRegion=linkRegion.substring(0,linkRegion.length-2)+`&region=`+$("#region").val()+linkRegion.substring(linkRegion.length-2,linkRegion.length);
        setInterval(() => {
            let currentValue = $("#region").val();
            if (currentValue !== previousValue) {
                console.log(currentValue);
                let newLinkRegion = linkRegion.substring(0,linkRegion.length-2)+`&region=`+$("#region").val()+linkRegion.substring(linkRegion.length-2,linkRegion.length);
                $("[onclick*='district']")[0].setAttribute("onclick",newLinkRegion);
                previousValue = currentValue;
            }
        }, 1000);

        let linkDistricit=$("[onclick*='communes']")[0].getAttribute("onclick");
        let previousValueDistrict = $("#district").val();
        let newLinkDistricit=linkDistricit.substring(0,linkDistricit.length-2)+`&idDistrict=`+$("#district").val()+linkDistricit.substring(linkDistricit.length-2,linkDistricit.length);
        setInterval(() => {
            let currentValue = $("#district").val();
            if (currentValue !== previousValueDistrict) {
                console.log(currentValue);
                let newLinkDistricit = linkDistricit.substring(0,linkDistricit.length-2)+`&idDistrict=`+$("#district").val()+linkDistricit.substring(linkDistricit.length-2,linkDistricit.length);
                $("[onclick*='communes']")[0].setAttribute("onclick",newLinkDistricit);
                previousValueDistrict = currentValue;
            }
        }, 1000);
    });

</script>
<%
    }catch (Exception e){
        e.printStackTrace();
    }
%>