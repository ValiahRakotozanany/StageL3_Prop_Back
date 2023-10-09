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
public class Poste extends ClassMAPTable{
    String id;
    String nom;
    String idregion;
    String iddistrict;
    String idcommune;
    String idPersonne;

    public String getIdPersonne() {
        return idPersonne;
    }

    public void setIdPersonne(String idPersonne) {
        this.idPersonne = idPersonne;
    }
    
    public Poste(){
        super.setNomTable("poste");
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
        if(this.getMode().compareTo("modif")==0){
            if(Utilitaire.champNull(nom).isEmpty()){
                throw new Exception("Veuillez remplir le champ nom");
            }
        }
        this.nom = nom;
    }

    public String getIdregion() {
        return idregion;
    }

    public void setIdregion(String idregion) throws Exception {
        if(this.getMode().compareTo("modif")==0){
            if(Utilitaire.champNull(idregion).isEmpty()){
                throw new Exception("Veuillez remplir le champ region");
            }
        }
        this.idregion = idregion;
    }

    public String getIddistrict() {
        return iddistrict;
    }

    public void setIddistrict(String iddistrict) {
        this.iddistrict = iddistrict;
    }

    public String getIdcommune() {
        return idcommune;
    }

    public void setIdcommune(String idcommune) {
        this.idcommune = idcommune;
    }
    
    

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        super.setNomTable("poste");
        this.preparePk("PST", "getseqposte");
        this.setId(this.makePK(c));
    }

    
    public String getValColLibelle(){
        return this.getNom();
    }
    
    
}
