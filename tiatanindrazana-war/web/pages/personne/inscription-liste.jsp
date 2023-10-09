

<%@page import="responsable.Responsable"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.Liste"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="map.PersonneLibComplet"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    PersonneLibComplet t = new PersonneLibComplet();
    String nomtable = "v_personne_lib_complet";
    String etat = Utilitaire.champNull(request.getParameter("etat"));
    if(etat.compareTo("")!=0){
        nomtable = etat;
    }
    t.setNomTable(nomtable);
    String listeCrt[] = {"id","nom","prenom","telephone","job","idAttente","sexe","age","domicile","mail","compteFB","whatsapp","regionlib","districtlib","communeslib","idresponsable","typeentites","demandeslib","cible"};
    String listeInt[] = {"age"};
    String libEntete[] = {"id","nom","prenom","telephone","job","idAttenteLib","sexe","age","domicile","mail","compteFB","whatsapp","etatlib","regionlib","districtlib","communeslib","idresponsablelib","demandeslib"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Liste des antennes");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("personne/inscription-liste.jsp");
    
    Liste[] liste = new Liste[4];
    TypeObjet attente = new TypeObjet();
    attente.setNomTable("attente");
    liste[0] = new Liste("idAttente",attente,"val","id");
    Responsable responsable = new Responsable();
    liste[1] = new Liste("idresponsable",responsable,"nom","id");
    TypeObjet typeentite = new TypeObjet();
    typeentite.setNomTable("typeentite");
    liste[2] = new Liste("typeentites",typeentite,"val","val");
    TypeObjet typecible=new TypeObjet();
    typecible.setNomTable("cible");
    liste[3]=new Liste("cible",typecible,"val","id");
    pr.getFormu().changerEnChamp(liste);
    pr.getFormu().getChamp("age1").setLibelle("Age min");
    pr.getFormu().getChamp("age2").setLibelle("Age max");
    pr.getFormu().getChamp("nom").setLibelle("Nom");
    pr.getFormu().getChamp("id").setLibelle("ID");
    pr.getFormu().getChamp("prenom").setLibelle("Prenom");
    pr.getFormu().getChamp("telephone").setLibelle("Telephone");
    pr.getFormu().getChamp("job").setLibelle("Poste actuel");
    pr.getFormu().getChamp("idAttente").setLibelle("Attente");
    pr.getFormu().getChamp("sexe").setLibelle("Sexe");
    pr.getFormu().getChamp("domicile").setLibelle("Adresse");
    pr.getFormu().getChamp("mail").setLibelle("Mail");
    pr.getFormu().getChamp("compteFB").setLibelle("Compte FB");
    pr.getFormu().getChamp("whatsapp").setLibelle("Whatsapp");
    pr.getFormu().getChamp("regionlib").setLibelle("Region");
    pr.getFormu().getChamp("districtlib").setLibelle("District");
    pr.getFormu().getChamp("communeslib").setLibelle("Commune(s)");
    pr.getFormu().getChamp("idresponsable").setLibelle("Responsable");
    pr.getFormu().getChamp("demandeslib").setLibelle("Demandes");
    pr.getFormu().getChamp("typeentites").setLibelle("Appartenance &agrave; un groupe");
    pr.getFormu().getChamp("cible").setLibelle("Cible");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=personne/inscription-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    //Definition des libelles � afficher
    String libEnteteAffiche[] = {"ID","Nom","Prenom","Telephone","Poste actuel","Attente","Sexe","Age","Adresse","Mail","Compte FB","Whatsapp","Etat","Region","District","Communes","Responsable","Demandes"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post" id="form-personne">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <center> 
                <select style="padding: 10px" name="etat" onchange="submitForm()" >
                <option value="v_personne_lib_complet" <% if(nomtable.compareTo("v_personne_lib_complet")==0) out.print("selected"); %> >Tous</option>
                <option value="v_personne_lib_complet_c" <% if(nomtable.compareTo("v_personne_lib_complet_c")==0) out.print("selected"); %> >Cr&eacute;&eacute;</option>
                <option value="v_personne_lib_complet_i" <% if(nomtable.compareTo("v_personne_lib_complet_i")==0) out.print("selected"); %> >Interview&eacute;</option>
                <option value="v_personne_lib_complet_v" <% if(nomtable.compareTo("v_personne_lib_complet_v")==0) out.print("selected"); %> >Trait&eacute;</option>
                <option value="v_personne_lib_complet_a" <% if(nomtable.compareTo("v_personne_lib_complet_a")==0) out.print("selected"); %> >Refus&eacute;</option>
               </select>
           </center>
        </form>
            
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            /*---28-08-2023---*/
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
    <script>
        function submitForm(){
            var form = document.getElementById("form-personne");
            form.submit();
        }
    </script>
    <%
    }catch(Exception e){

        e.printStackTrace();
    }
%>
