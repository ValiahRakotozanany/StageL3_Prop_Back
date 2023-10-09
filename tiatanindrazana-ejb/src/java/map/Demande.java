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
public class Demande extends ClassMAPTable{
    String id;
    String nom;
    
    public Demande(){
        super.setNomTable("demande");
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
        super.setNomTable("demande");
        this.preparePk("DMD", "getseqdemande");
        this.setId(this.makePK(c));
    }
    
    public String getValColLibelle(){
        return this.getNom();
    }

}
