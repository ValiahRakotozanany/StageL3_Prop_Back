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
public class PlatTyper extends ClassMAPTable{

    private String id;
    private String idplat;
    private String idtypeplat;    
    
    public PlatTyper(){
        this.setNomTable("plattyper");
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdplat() {
        return idplat;
    }

    public void setIdplat(String idplat) {
        this.idplat = idplat;
    }

    public String getIdtypeplat() {
        return idtypeplat;
    }

    public void setIdtypeplat(String idtypeplat) {
        this.idtypeplat = idtypeplat;
    }
    
    
    
    @Override
    public String getTuppleID() {
        return this.id;
    }

    
     @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("platF", "getseq_plattyper");
        setId(makePK(c));
    }

    
    @Override
    public String getAttributIDName() {
        return "id";
    }
    
}
