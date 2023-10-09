/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package map;
import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author drana
 */
public class Responsable extends ClassMAPTable{
    private String id;
    private String nom;

    
    public Responsable(String nom) {
        this.nom = nom;
    }

    public Responsable()
    {
        this.setNomTable("responsable");
    }
    @Override
    public String getTuppleID() {
       return this.id;
    }
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("RES", "get_seq_responsable");
        setId(makePK(c));
    }

    @Override
    public String getAttributIDName() {
        return "id";
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

    public void setNom(String nom) {
        this.nom = nom;
    }
    
    
}
    