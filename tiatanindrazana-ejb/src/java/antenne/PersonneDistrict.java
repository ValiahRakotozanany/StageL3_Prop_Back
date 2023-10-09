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
public class PersonneDistrict extends ClassMAPTable{
      private String id,idPersonne,idDistrict;

    
    public PersonneDistrict(){
        this.setNomTable("personne_district");
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

    public String getIdDistrict() {
        return idDistrict;
    }

    public void setIdDistrict(String idDistrict) {
        this.idDistrict = idDistrict;
    }
   
    @Override
    public String getTuppleID() {
        return this.getId();
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.setNomTable("personne_district");
        this.preparePk("PDIS", "getseqpersonnedisctrict");
        setId(makePK(c));
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    
    
}
