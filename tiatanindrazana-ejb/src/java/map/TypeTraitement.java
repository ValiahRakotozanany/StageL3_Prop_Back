package map;

import bean.ClassMAPTable;
import java.sql.Connection;

public class TypeTraitement extends ClassMAPTable{

    private String id;
    private String nom; 

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) throws Exception {
        if(this.getMode().equals("modif")){
            if(nom == null || nom.equals("")){
                throw new Exception("Nom obligatoire");
            }
        }
        this.nom = nom;
    }

    public TypeTraitement() {
        this.setNomTable("type_traitement");
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public void construirePK(Connection c) throws Exception {
       this.preparePk("TYPT", "getseqtypetraitement");
       this.setId(makePK(c));
    }
    
    
    
}
