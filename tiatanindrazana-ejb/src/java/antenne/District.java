package antenne;

import java.sql.Connection;
import bean.*;

public class District extends ClassMAPTable{

   private String id,idregion,nom;

   @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("DIST", "getseqdistrict");
        this.setId(makePK(c));
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public District(){
        this.setNomTable("district");
    }

    public District(String id,String idregion,String nom)throws Exception{
        this.setNomTable("district");
        this.id=id;
        this.idregion=idregion;
        this.nom=nom;
    }


    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdregion() {
        return this.idregion;
    }

    public void setIdregion(String idregion) {
        this.idregion = idregion;
    }

    public String getNom() {
        return this.nom;
    }

    public void setNom(String nom) throws Exception {
        if(this.getMode().equals("modif")){
            if(nom==null||nom.equals("")){
                throw new Exception("Le nom de district ne peut pas être vide");
            }
        }
        this.nom = nom;
    }
    

    @Override
    public ClassMAPTable createObject(String iduser, Connection con) throws Exception {
        ClassMAPTable retour=super.createObject(iduser,con);
        Commune commune=new Commune();
        commune.setNomTable("Commune");
        commune.setNom("Non specifie");
        commune.setIddistrict(this.getId());
        commune.createObject(iduser, con);
        return retour;
    }
    
}
