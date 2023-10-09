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
public class PersonneCommune extends ClassMAPTable{

    private String id;
    private String idPersonne;
    private String idCommune;

    public void construirePK(Connection c) throws Exception {
        preparePk("PCM", "getseqpersonnecommune");
        setId(makePK(c));
    }
    public PersonneCommune(String idPersonne, String idCommune) {
        this.idPersonne = idPersonne;
        this.idCommune = idCommune;
        this.setNomTable("personne_commune");
    }
    public PersonneCommune()
    {
        this.setNomTable("PERSONNE_COMMUNE");
    }
    
    @Override
    public String getTuppleID() {
        return this.id;
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

    public String getIdPersonne() {
        return idPersonne;
    }

    public void setIdPersonne(String idPersonne) {
        this.idPersonne = idPersonne;
    }

    public String getIdCommune() {
        return idCommune;
    }

    public void setIdCommune(String idCommune) {
        this.idCommune = idCommune;
    }
    
}
