/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package antenne;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author QAngela
 */
public class PersonneRegion extends ClassMAPTable{

    private String id,idPersonne,idRegion;

    
    public PersonneRegion(){
        this.setNomTable("personne_region");
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

    public void setIdPersonne(String idPersonne) {
        this.idPersonne = idPersonne;
    }

    public String getIdRegion() {
        return idRegion;
    }

    public void setIdRegion(String idRegion) {
        this.idRegion = idRegion;
    }
       
     @Override
    public String getTuppleID() {
        return this.getId();
    }

     @Override
    public void construirePK(Connection c) throws Exception {
        this.setNomTable("personne_region");
        this.preparePk("PRE", "getseqpersonneregion");
        setId(makePK(c));
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    
   
}
