/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package map.Proposition;

import bean.ClassMAPTable;
import com.google.gson.annotations.Expose;
import java.sql.Connection;

/**
 *
 * @author Valiah Karen
 */
public class MaladieMembre extends ClassMAPTable{
    @Expose
    private String id;
    @Expose
    private String idMaladie;
    @Expose
    private String idMembre;

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

    public String getIdMembre() {
        return idMembre;
    }

    public void setIdMembre(String idMembre) {
        this.idMembre = idMembre;
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
        preparePk("maladiemembre", "get_seqmaladiemembre");
        setId(makePK(c));
    }
    
}
