/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package map;

import bean.CGenUtil;
import bean.ClassMAPTable;
import constante.ConstanteEtat;
import java.sql.Connection;
import utilitaire.Utilitaire;

/**
 *
 * @author itu
 */
public class PersonneValide extends ClassMAPTable{
    
    String idPersonne;
    String idresponsable;
    String traitement;
    String idTypeTraitement;
    String idPoste;
    

    public String getIdTypeTraitement() {
        return idTypeTraitement;
    }

    public void setIdTypeTraitement(String idTypeTraitement) {
        this.idTypeTraitement = idTypeTraitement;
    }
    
    

    @Override
    public boolean isSynchro() {
        return false; //To change body of generated methods, choose Tools | Templates.
    }

    public String getIdPoste() {
        return idPoste;
    }

    public void setIdPoste(String idPoste) throws Exception {
        if(this.getMode().equals("modif")){
            if(Utilitaire.champNull(idPoste).isEmpty()){
                throw new Exception("Veuillez remplir le champ poste");
            }
        }
        this.idPoste = idPoste;
    }

    
    
    public PersonneValide() {
        super.setNomTable("personne_valide_virtuel");
    }
    
    @Override
    public String getTuppleID() {
        return idPersonne;
    }

    @Override
    public String getAttributIDName() {
        return "idPersonne";
    }

    public String getIdPersonne() {
        return idPersonne;
    }

    public void setIdPersonne(String idPersonne) {
        this.idPersonne = idPersonne;
    }


    public String getIdresponsable() {
        return idresponsable;
    }

    public void setIdresponsable(String idresponsable) throws Exception {
        if(this.getMode().equals("modif")){
            if(Utilitaire.champNull(idresponsable).isEmpty()){
                throw new Exception("Veuillez remplir le champ responsable");
            }
        }
        this.idresponsable = idresponsable;
    }

    public String getTraitement() {
        return traitement;
    }

    public void setTraitement(String traitement) throws Exception {
        if(this.getMode().equals("modif")){
            if(Utilitaire.champNull(traitement).compareTo("")==0){
                throw new Exception("Veuillez remplir le champ traitement");
            }
        }
        this.traitement = traitement;
    }
    
        
    
    


    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        ClassMAPTable retour = null;
        try{
            
            
            Personne personne = new Personne();
            personne = (Personne)personne.getById(this.idPersonne, "personne", c);
            if(personne!=null){
                if(personne.getEtat()==0){
                    throw new Exception("Inscription de personne annulé");
                }
                if(personne.getEtat()==0){
                    throw new Exception("Inscription de personne déjà validé");
                }
                personne.setEtat(ConstanteEtat.getEtatValider());
                personne.setTraitement(traitement);
                personne.setIdresponsable(idresponsable);
                personne.setIdTypeTraitement(idTypeTraitement);
                personne.updateToTableWithHisto(u, c);
                
                if(!Utilitaire.champNull(idPoste).isEmpty()){
                    String[] itemPoste=idPoste.split(";");
                    for(int i=0; i<itemPoste.length; i++)
                    {
                       Poste p = new Poste();
                       p = (Poste)p.getById(itemPoste[i], "poste", c);
                       if(p!=null){
                           if(p.getIdPersonne()!=null) throw new Exception(String.format("Le poste %s appartient a une autre personne", p.getNom()));
                           p.setIdPersonne(idPersonne);
                           p.updateToTableWithHisto(u, c);
                       }else{
                           throw new Exception("Poste introuvable");
                       }
                    }
                }
            }else{
                throw new Exception("Personne introuvable");
            }
        }catch(Exception e){
            e.printStackTrace();
            throw e;
        }
        return retour;
    }

    
    
    
    
    
    
    
    
}
