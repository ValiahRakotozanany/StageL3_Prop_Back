/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package map;
import bean.CGenUtil;
import bean.ClassMere;
import bean.ClassMAPTable;
import bean.TypeObjet;
import constante.ConstanteEtat;
import java.sql.Connection;
import java.sql.Timestamp;

import utilitaire.Utilitaire;
import antenne.*;
import utilitaire.UtilDB;


/**
 *
 * @author drana
 */
public class PersonneInsertion extends ClassMere{
    private String id;
    private String nom;
    private String prenom;
    private String telephone;
    private String job;
    private String sexe;
    private String idAttente;
    private int age;
    private String domicile;
    private String compteFB;
    private String whatsapp;
    private String mail;
    private String region;
    private String communes;
    private String district;
    private String champLibre;
    private String idresponsable;
    private String traitement;
    private String idTypeTraitement;
    private String demandes;
    private String idPoste;
    private String cible;
    private String atout;
    private String attenteDetaille;
    private Timestamp rdv;

    public PersonneInsertion(){
        this.setNomTable("v_virtual_personne_insertion");
    }
    public PersonneInsertion(String nom, String prenom, String telephone, String job, String sexe, String idAttente,int age, String domicile, String compteFB, String whatsapp, String mail, String region, String communes, String district, String champLibre) {
        this.nom = nom;
        this.prenom = prenom;
        this.telephone = telephone;
        this.job = job;
        this.sexe = sexe;
        this.idAttente = idAttente;
        this.age = age;
        this.domicile = domicile;
        this.compteFB = compteFB;
        this.whatsapp = whatsapp;
        this.mail = mail;
        this.region = region;
        this.communes = communes;
        this.district = district;
        this.champLibre = champLibre;
    }

    public String getDemandes() {
        return demandes;
    }

    public void setDemandes(String demandes) throws Exception {
        if(this.getMode().compareTo("modif")==0){
            if(Utilitaire.champNull(demandes).isEmpty()){
                throw new Exception("Veuillez remplir le champ demande");
            }
        }
        this.demandes = demandes;
    }

    public String getIdPoste() {
        return idPoste;
    }

    public void setIdPoste(String idPoste) {
        this.idPoste = idPoste;
    }

    public String getIdTypeTraitement() {
        return idTypeTraitement;
    }

    public void setIdTypeTraitement(String idTypeTraitement) {
        this.idTypeTraitement = idTypeTraitement;
    }
    
    
    
    public void construirePK(Connection c) throws Exception {
        preparePk("PERS", "getseqpersonne");
        setId(makePK(c));
    }
    
    @Override
    public String getTuppleID() {
       return this.id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
 
    @Override
    public ClassMAPTable createObject(String u,Connection c)throws Exception{
       this.setNomTable("personne");
        super.createObject(u, c);
        if(!Utilitaire.champNull(communes).isEmpty()){
            String[] itemCommune=communes.split(";");
            for(int i=0; i<itemCommune.length; i++)
            {
                PersonneCommune p=new PersonneCommune(id,itemCommune[i]);
                p.createObject(u, c);
            }
        }  
        if(!Utilitaire.champNull(demandes).isEmpty()){
            String[] itemDemande=demandes.split(";");
            for(int i=0; i<itemDemande.length; i++)
            {
                PersonneDemande p=new PersonneDemande(id,itemDemande[i]);
                p.createObject(u, c);
            }
        }
        return this;
    }

    @Override
    public int updateToTableWithHisto(String refUser, Connection c) throws Exception {
        this.setNomTable("personne");
        int retour = super.updateToTableWithHisto(refUser, c);
        PersonneDistrict personneDistrict= new PersonneDistrict();
        personneDistrict.deleteToTable(String.format(" idPersonne = '%s'",this.id),c);
        PersonneRegion personneRegion=new PersonneRegion();
        personneRegion.deleteToTable(String.format(" idPersonne = '%s'",this.id),c);
        PersonneCommune pc = new PersonneCommune();
        pc.deleteToTable(String.format(" idPersonne = '%s'",this.id),c);
        this.insertPersonneRegion(refUser,c);
        this.insertPersonneDistrict(refUser,c);
        if(!Utilitaire.champNull(communes).isEmpty()){
            String[] itemCommune=communes.split(";");
            for(int i=0; i<itemCommune.length; i++)
            {
                PersonneCommune p=new PersonneCommune(id,itemCommune[i]);
                p.createObject(refUser, c);
            }
        }  
        PersonneDemande pd = new PersonneDemande();
        pd.deleteToTable(String.format(" idPersonne = '%s'",this.id),c);
        if(!Utilitaire.champNull(demandes).isEmpty()){
            String[] itemDemande=demandes.split(";");
            for(int i=0; i<itemDemande.length; i++)
            {
                PersonneDemande p=new PersonneDemande(id,itemDemande[i]);
                p.createObject(refUser, c);
            }
        }
        return retour;
    }

    public Timestamp getRdv() {
        return rdv;
    }

    public void setRdv(Timestamp rdv) {
        this.rdv = rdv;
    }

    public String getIdresponsable() {
        return idresponsable;
    }

    public void setIdresponsable(String idresponsable) {
        this.idresponsable = idresponsable;
    }

    public String getTraitement() {
        return traitement;
    }

    public void setTraitement(String traitement) {
        this.traitement = traitement;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    
    public String getNom() {
        return nom;
    }

    public void setNom(String nom) throws Exception {
        if(this.getMode().equals("modif")){
            if(nom==null||nom.trim().equals("")){
                throw new Exception("nom obligatoire");
            }
        }
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    

    public String getSexe() {
        return sexe;
    }

    public void setSexe(String sexe) {
        this.sexe = sexe;
    }

    public String getDomicile() {
        return domicile;
    }

    public void setDomicile(String domicile) {
        this.domicile = domicile;
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) throws Exception {
        if(this.getMode().equals("modif")){
            if(job==null||job.trim().equals("")){
                throw new Exception("Poste obligatoire");
            }
        }
        this.job = job;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) throws Exception {
        if(this.getMode().equals("modif")){
            if(telephone==null||telephone.trim().equals("")){
                throw new Exception("Telephone obligatoire");
            }
        }
        this.telephone = telephone;
    }

    public String getCompteFB() {
        return compteFB;
    }

    public void setCompteFB(String compteFB) {
        this.compteFB = compteFB;
    }

    public String getWhatsapp() {
        return whatsapp;
    }

    public void setWhatsapp(String whatsapp) {
        this.whatsapp = whatsapp;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) throws Exception {
        if(this.getMode().equals("modif")){
            if(region==null||region.trim().equals("")){
                throw new Exception("Region obligatoire");
            }
        }
        this.region = region;
    }

    public String getCommunes() {
        return communes;
    }

    public void setCommunes(String communes) throws Exception {
        if(this.getMode().equals("modif")){
            if(communes==null||communes.trim().equals("")){
                throw new Exception("Commune obligatoire");
            }
        }
        this.communes = communes;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) throws Exception {
        if(this.getMode().equals("modif")){
            if(district==null||district.trim().equals("")){
                throw new Exception("Poste obligatoire");
            }
        }
        this.district = district;
    }
     public String getChampLibre() {
        return champLibre;
    }

    public void setChampLibre(String ChampLibre) {
        this.champLibre = ChampLibre;
    }

    public String getIdAttente() {
        return idAttente;
    }

    public void setIdAttente(String idAttente) {
        this.idAttente = idAttente;
    }


    public String getCible() {
        return cible;
    }



    public void setCible(String cible) throws Exception{
        this.cible = cible;
    }

    public String getAtout() {
        return atout;
    }

    public void setAtout(String atout) throws Exception{
        if (getMode().equals("modif")){
            if (atout==null||atout.isEmpty()){
                throw new Exception("Atout obligatoire");
            }
        }
        this.atout = atout;
    }

    public String getAttenteDetaille() {
        return attenteDetaille;
    }

    public void setAttenteDetaille(String attenteDetaille) throws Exception{
        if (getMode().equals("modif")){
            if (attenteDetaille==null||attenteDetaille.isEmpty()){
                throw new Exception("Attente obligatoire");
            }
        }
        this.attenteDetaille = attenteDetaille;
    }

    @Override
    public void controleAnnulerVisa(Connection c) throws Exception {
        if(this.getEtat()>=ConstanteEtat.getEtatValider()){
            throw new Exception("Personne d�j� valid�");
        }
    }

    @Override
    public void controleAnnuler(Connection c) throws Exception {
        if(this.getEtat()>=ConstanteEtat.getEtatValider()){
            throw new Exception("Personne d�j� valid�");
        }
    }
    
    @Override
    public void controlerUpdate(Connection c) throws Exception {
        Personne pers = new Personne();
        pers = (Personne)pers.getById(id, "personne", c);
        if(pers==null){
            throw new Exception("Aucune personne correcpondant pour cet id");
        }
        if(this.getEtat()<ConstanteEtat.getEtatCreer()){
            throw new Exception("Cette personne ne peut plus etre modifier");
        }
    }



    public void controllerDistrict(Connection c) throws Exception {
        int indice = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                indice = 1;
            }
            String[] districtSplitted = district.split(";");
            String regionSplittedFormatted = Utilitaire.tabToString(region.split(";"), "'", ",");
            String districtSplittedFormatted = Utilitaire.tabToString(districtSplitted, "'", ",");
            District critere =new District(); 
            Object[] resultat = CGenUtil.rechercher(critere, null, null, c," AND id IN(" + districtSplittedFormatted + ") AND idRegion IN (" + regionSplittedFormatted + ")");
            if (resultat.length != districtSplitted.length) {
                throw new Exception("Les régions et les districts ne concordent pas");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null && indice==1) {
                c.close();
            }
        }
    }
    public void controllerCommune(Connection c, String communes, String district) throws Exception {
        int indice = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                indice = 1;
            }
            String[] communeSplitted = communes.split(";");
            String districtSplittedFormatted = Utilitaire.tabToString(district.split(";"), "'", ",");
            String communeSplittedFormatted = Utilitaire.tabToString(communeSplitted, "'", ",");
            Commune critere = new Commune();
            Object[] resultat = CGenUtil.rechercher(critere, null, null, c, " AND id IN(" + communeSplittedFormatted + ") AND idDistrict IN(" + districtSplittedFormatted + ")");
            if (resultat.length != communeSplitted.length) {
                throw new Exception("Les districts et les communes ne concordent pas");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null && indice==1) {
                c.close();
            }
        }
    }
    
     public void insertPersonneRegion(String u, Connection c) throws Exception {
        int indice = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                indice = 1;
            }
            String[] regionSplitted = region.split(";");
            for (int i = 0; i < regionSplitted.length; i++) {
                PersonneRegion personneRegion = new PersonneRegion();
                personneRegion.setIdRegion(regionSplitted[i]);
                personneRegion.setIdPersonne(this.getId()); 
                personneRegion.createObject(u, c);
            }
            if (indice==1) 
                c.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            if (indice==1) 
                c.rollback();
            throw ex;
        } finally {
            if (c != null && indice==1) {
                c.close();
            }
        }
    }

     public void insertPersonneDistrict(String u, Connection c) throws Exception {
        int indice = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                indice = 1;
            }
            String[] districtSplitted = district.split(";");
            for (int i = 0; i < districtSplitted.length; i++) {
                PersonneDistrict personneDistrict = new PersonneDistrict();
                personneDistrict.setIdDistrict(districtSplitted[i]);
                personneDistrict.setIdPersonne(this.getId());
                personneDistrict.createObject(u, c);
            }
            if (indice == 1)
                c.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            if (indice == 1)
                c.rollback();
            throw ex;
        } finally {
            if (indice == 1)
                c.close();
        }
    }

}
