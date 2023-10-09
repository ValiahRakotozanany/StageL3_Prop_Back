/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package map.Proposition;

import java.sql.Connection;

/**
 *
 * @author Valiah Karen
 */
public class Platfille_lib extends Platfille{
      private String ingredient;
    private String unite;
    private String ETATINGREDIENT_LIB;

    public String getETATINGREDIENT_LIB() {
        return ETATINGREDIENT_LIB;
    }

    public void setETATINGREDIENT_LIB(String ETATINGREDIENT_LIB) {
        this.ETATINGREDIENT_LIB = ETATINGREDIENT_LIB;
    }
        

   public String getIngredient() {
        return ingredient;
    }

    public void setIngredient(String ingredient) {
        this.ingredient = ingredient;
    }

    public String getUnite() {
        return unite;
    }

    public void setUnite(String unite) {
        this.unite = unite;
    }

    public Platfille_lib() {
        this.setNomTable("platfille_lib");
    }
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("plat", "getseq_maladie");
        setId(makePK(c));
    }

    
    
}
