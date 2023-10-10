/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package map.Proposition;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Valiah Karen
 */
public class PlatMaladie extends ClassMAPTable{
    private String id;
    private String idMaladie;
    private String idplat ;
    private String etat;
    private String etat_lib;
    
    private String plat;

    public String getPlat() {
        return plat;
    }

    public void setPlat(String plat) {
        this.plat = plat;
    }
    
    
    
    public PlatMaladie(){
        this.setNomTable("Platmaladie");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdMaladie() {
        return idMaladie;
    }

    public void setIdMaladie(String idMaladie) {
        this.idMaladie = idMaladie;
    }

    public String getIdplat() {
        return idplat;
    }

    public void setIdplat(String idplat) {
        this.idplat = idplat;
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
    public void construirePK(Connection c) throws Exception {
        preparePk("platmaladie", "getseq_platmaladie");
        setId(makePK(c));
    }
}
