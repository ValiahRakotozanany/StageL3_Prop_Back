
package map;

/**
 *
 * @author itu
 */
public class EntitePersonneLibComplet extends Entite{
    String rolePersonne;
    String idPersonne;

    public String getRolePersonne() {
        return rolePersonne;
    }

    public void setRolePersonne(String rolePersonne) {
        this.rolePersonne = rolePersonne;
    }

    public String getIdPersonne() {
        return idPersonne;
    }

    public void setIdPersonne(String idPersonne) {
        this.idPersonne = idPersonne;
    }
    
    public EntitePersonneLibComplet(){
        super.setNomTable("V_ENTITE_PERSONNE_LIB_COMPLET");
    }
    
    
    
    
}