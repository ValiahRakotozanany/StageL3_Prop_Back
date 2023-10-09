/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package map.Proposition;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.SQLException;
import utilitaire.UtilDB;

/**
 *
 * @author Valiah Karen
 */
public class IngredientMaladie extends ClassMAPTable{
    private String id;
    private String idmaladie;
    private int etat;
    private String idingredient;
    
    

    public IngredientMaladie() {
        this.setNomTable("ingredientMaladie");
    }

    public String getIdingredient() {
        return idingredient;
    }

    public void setIdingredient(String idingredient) {
        this.idingredient = idingredient;
    }
    
    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdmaladie() {
        return idmaladie;
    }

    public void setIdmaladie(String idmaladie) {
        this.idmaladie = idmaladie;
    }

    public int getEtat() {
        return etat;
    }

    public void setEtat(int etat) {
        this.etat = etat;
    }
    
    
      @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("ingM", "getseq_ingredientmaladie");
        setId(makePK(c));
    }
    
    @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    public void dupliquerEtInserer(String user, String[]idIngredients) throws Exception{
        IngredientMaladie[] responses = new IngredientMaladie[idIngredients.length];
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            for(int i=0; i<responses.length; i++){
                responses[i] = (IngredientMaladie)this.dupliquer(user, c);
                responses[i].setIdingredient(idIngredients[i]);
                responses[i].createObject(user, c);
            }
            c.commit();
        } catch (Exception e) {
            if(c!=null)c.rollback();
            e.printStackTrace();
            throw e;
        } finally{
            if(c!=null)c.close();
        }
    }
}
