/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package map;

import bean.ClassMAPTable;
import java.sql.Connection;
import utilitaire.Utilitaire;

/**
 *
 * @author itu
 */
public class PersonneDemande extends ClassMAPTable{
    String id;
    String idPersonne;
    String idDemande;

    public PersonneDemande() {
        super.setNomTable("personne_demande");
    }

    
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdPersonne() {
        return idPersonne;
    }

    public void setIdPersonne(String idPersonne) throws Exception {
        if(this.getMode().equals("modif")){
            if(Utilitaire.champNull(idPersonne).isEmpty()){
                throw new Exception("Veuillez remplir le champ personne");
            }
        }
        this.idPersonne = idPersonne;
    }

    public String getIdDemande() {
        return idDemande;
    }

    public void setIdDemande(String idDemande) throws Exception {
        if(this.getMode().equals("modif")){
            if(Utilitaire.champNull(idDemande).isEmpty()){
                throw new Exception("Veuillez remplir le champ demande");
            }
        }
        this.idDemande = idDemande;
    }

    public PersonneDemande(String idPersonne, String idDemande) {
        super.setNomTable("personne_demande");
        this.idPersonne = idPersonne;
        this.idDemande = idDemande;
    }
    
    
    

    @Override
    public void construirePK(Connection c) throws Exception {
        super.setNomTable("personne_demande");
        this.preparePk("PDMD", "getseqpersonnedemande");
        this.setId(this.makePK(c));
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    
}
