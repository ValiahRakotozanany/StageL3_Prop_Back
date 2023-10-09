/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package map;
import bean.ClassFille;
import bean.ClassMAPTable;

import java.sql.Connection;
/**
 *
 * @author drana
 */
public class AssociationEntitePersonne extends ClassFille{
    private String id;
    private String rolePersonne;
    private String idPersonne;
    private String idEntite;

    public AssociationEntitePersonne(String rolePersonne, String idPersonne, String idEntite) {
        this.rolePersonne = rolePersonne;
        this.idPersonne = idPersonne;
        this.idEntite = idEntite;
    }
    public void construirePK(Connection c) throws Exception {
        preparePk("ASSP", "GETSEQASSOCIATIONEP");
        setId(makePK(c));
    }
    public AssociationEntitePersonne() throws Exception {
        this.setLiaisonMere("idPersonne");
        this.setNomTable("association_entite_personne");
        setNomClasseMere("map.PersonneInsertion");
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

    public String getRolePersonne() {
        return rolePersonne;
    }

    public void setRolePersonne(String rolePersonne) throws Exception{
        if(this.getMode().equals("modif")){
            if(rolePersonne == null || rolePersonne.equals("")){
                throw new Exception("Role obligatoire");
            }
        }
        this.rolePersonne = rolePersonne;
    }

    public String getIdPersonne() {
        return idPersonne;
    }

    public void setIdPersonne(String idPersonne) {
        this.idPersonne = idPersonne;
    }

    public String getIdEntite() {
        return idEntite;
    }

    public void setIdEntite(String idEntite) throws Exception {
        if(this.getMode().equals("modif")){
            if(idEntite == null || idEntite.equals("")){
                throw new Exception("Entité obligatoire");
            }
        }
        this.idEntite = idEntite;
    }
    @Override
    public ClassMAPTable createObject(String u,Connection c) throws Exception{
        System.out.println("AssociationEntitePersonne");
        return super.createObject(u, c);
    }
}