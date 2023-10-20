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
public class Platfille extends ClassMAPTable{
    @Expose
    private String id ;
    @Expose
    private String idplat;
    @Expose
    private String idingredient;
    @Expose
    private double valeuradulte ;
    @Expose
    private double valeurenfant;
    @Expose
    private String remarque ;
    @Expose
    private String etatingredient;

    public String getEtatingredient() {
        return etatingredient;
    }

    public void setEtatingredient(String etatingredient) {
        this.etatingredient = etatingredient;
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

    public String getIdingredient() {
        return idingredient;
    }

    public void setIdingredient(String idingredient) {
        this.idingredient = idingredient;
    }

    public double getValeuradulte() {
        return valeuradulte;
    }

    public void setValeuradulte(double valeuradulte) {
        this.valeuradulte = valeuradulte;
    }

    public double getValeurenfant() {
        return valeurenfant;
    }

    public void setValeurenfant(double valeurenfant) {
        this.valeurenfant = valeurenfant;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public Platfille() {
        this.setNomTable("platfille");
    }
    
    public Platfille(String nomtable){
        this.setNomTable(nomtable);
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
        preparePk("platF", "getseq_platfille");
        setId(makePK(c));
    }

}
