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


/**
 *
 * @author drana
 */
public class Personne extends ClassMere{
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
    
    
    
    public Personne(){
        this.setNomTable("personne");
    }
    public Personne(String nom, String prenom, String telephone, String job, String sexe, String idAttente, int age, String domicile, String compteFB, String whatsapp, String mail, String region, String communes, String district, String champLibre,String cible,String atout,String attenteDetaille) throws Exception{
        this.setMode("modif");
        this.setNom(nom);
        this.setPrenom(prenom);
        this.setTelephone(telephone);
        this.setJob(job);
        this.setSexe(sexe);
        this.setIdAttente(idAttente);
        this.setAge(age);
        this.setDomicile(domicile);
        this.setCompteFB(compteFB);
        this.setWhatsapp(whatsapp);
        this.setMail(mail);
        this.setRegion(region);
        this.setCommunes(communes);
        this.setDistrict(district);
        this.setChampLibre(champLibre);
        this.setCible(cible);
        this.setAtout(atout);
        this.setAttenteDetaille(attenteDetaille);
    }
    
    public void construirePK(Connection c) throws Exception {
        preparePk("PERS", "getseqpersonne");
        setId(makePK(c));
    }

    public String getIdTypeTraitement() {
        return idTypeTraitement;
    }

    public void setIdTypeTraitement(String idTypeTraitement) {
        this.idTypeTraitement = idTypeTraitement;
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
        
        this.region = region;
    }

    public String getCommunes() {
        return communes;
    }

    public void setCommunes(String communes) throws Exception {
        
        this.communes = communes;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) throws Exception {
        
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
        if (getMode().equals("modif")){
            if (cible==null||cible.isEmpty()){
                throw new Exception("Cible obligatoire");
            }
        }
        this.cible = cible;
    }

    public String getAtout() {
        return atout;
    }

    public void setAtout(String atout) throws Exception{
        this.atout = atout;
    }

    public String getAttenteDetaille() {
        return attenteDetaille;
    }

    public void setAttenteDetaille(String attenteDetaille) throws Exception{
        this.attenteDetaille = attenteDetaille;
    }

    public Timestamp getRdv() {
        return rdv;
    }

    public void setRdv(Timestamp rdv) throws Exception{
        if (getMode().equals("modif")){
            if (rdv==null){
                throw new Exception("Rendez-vous obligatoire");
            }
        }
        this.rdv = rdv;
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
    
    public void controlerPoste(Connection c) throws Exception{
        try{
            Personne personne = new Personne();
            personne.setIdPoste(this.idPoste);
            Personne[] lPersonne = (Personne[])CGenUtil.rechercher(personne,null,null,c,"");
            if(lPersonne.length>0){
                throw new Exception("Ce poste appartient &agrave; une personne");
            }
        }catch(Exception e){
            throw e;
        }
    }

    @Override
    public void controler(Connection c) throws Exception {
    }
    
       
}
