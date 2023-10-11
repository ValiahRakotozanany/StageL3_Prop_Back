/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package map.Proposition;

import bean.ClassMAPTable;
import com.google.gson.annotations.Expose;
import java.sql.Connection;
import utilitaire.UtilDB;

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
    
    public MaladieMembre(){
        this.setNomTable("maladiemembre");
    }
    
    public MaladieMembre ajoutMaladiMembre(Connection c) throws Exception {
        boolean estOuvert = false;
        MaladieMembre resp = new MaladieMembre();
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                estOuvert = true;
            }

            resp = resp.ajoutM(c, this);
            if (c != null && estOuvert) {
                c.commit();
            }
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null && estOuvert) {
                c.close();
            }
        }
        return resp;
    }

    public MaladieMembre ajoutM(Connection c, MaladieMembre m) throws Exception {
        return (MaladieMembre) m.createObject(null, c);
    }
    
    

    
}
