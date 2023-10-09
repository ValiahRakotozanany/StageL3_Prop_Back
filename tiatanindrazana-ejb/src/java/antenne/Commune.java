package antenne;

import java.sql.Connection;

import bean.ClassMAPTable;

public class Commune extends ClassMAPTable{

    private String id,nom,iddistrict; 

    @Override
    public String getTuppleID() {
        return this.getId();
    }

     @Override
    public void construirePK(Connection c) throws Exception {
        this.setNomTable("Commune");
        this.preparePk("COMM", "getseqcommune");
        setId(makePK(c));
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public Commune()throws Exception{
        this.setNomTable("Commune");
    }

    public Commune(String id,String nom,String iddistrict)throws Exception{
        this.setNomTable("Commune");
        this.id=id;
        this.nom=nom;
        this.iddistrict=iddistrict;
    }


    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNom() {
        return this.nom;
    }

    public void setNom(String nom) throws Exception{
        if(this.getMode().equals("modif")){
            if(nom==null||nom.equals("")){
                throw new Exception("Le nom de commune est obligatoire");
            }
        }
        this.nom = nom;
    }

    public String getIddistrict() {
        return this.iddistrict;
    }

    public void setIddistrict(String iddistrict) {
        this.iddistrict = iddistrict;
    }

    public String getValColLibelle(){
        return this.getNom();
    }
    
}
