/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package map.Proposition;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;

/**
 *
 * @author Valiah Karen
 */
public class Ingredient extends ClassMAPTable{
    private String id;
    private String nom;
    private double prixachat ;
    private int unite ;
    private double valeur ;
    private Date datesaisondebut;
    private Date datesaisonfin;
    private String unite_lib;
    

    public String getUnite_lib() {
        return unite_lib;
    }

    public void setUnite_lib(String unite_lib) {
        this.unite_lib = unite_lib;
    }        
    
    public Ingredient() {
        this.setNomTable("ingredient");
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

    public double getPrixachat() {
        return prixachat;
    }

    public void setPrixachat(double prixachat) {
        this.prixachat = prixachat;
    }

   

    public int getUnite() {
        return unite;
    }

    public void setUnite(int unite) {
        this.unite = unite;
    }

    public void setUnite(String unite) throws Exception {
        if(this.getMode().compareTo("modif")==0){
            if(Utilitaire.champNull(unite).isEmpty()){
                throw new Exception("Veuillez remplir le champ region");
            }
            else{
                this.unite = Integer.parseInt(unite);
            }
        }
        
        
    }

    public double getValeur() {
        return valeur;
    }

    public void setValeur(double valeur) {
        this.valeur = valeur;
    }

    public Date getDatesaisondebut() {
        return datesaisondebut;
    }

    public void setDatesaisondebut(Date datesaisondebut) {
        this.datesaisondebut = datesaisondebut;
    }

    public Date getDatesaisonfin() {
        return datesaisonfin;
    }

    public void setDatesaisonfin(Date datesaisonfin) {
        this.datesaisonfin = datesaisonfin;
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
        preparePk("ing", "getseq_ingredient");
        setId(makePK(c));
    }
}
