/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package map.Proposition;

/**
 *
 * @author Valiah Karen
 */
public class IngredientMaladie_lib extends IngredientMaladie{
    private String ingredient;
    private String maladie;
    private String etatingredient;

    public IngredientMaladie_lib(){
        this.setNomTable("ingredientmaladie_lib");
    }
    public String getIngredient() {
        return ingredient;
    }

    public String getEtatingredient() {
        return etatingredient;
    }

    public void setEtatingredient(String etatingredient) {
        this.etatingredient = etatingredient;
    }

    public void setIngredient(String ingredient) {
        this.ingredient = ingredient;
    }

    public String getMaladie() {
        return maladie;
    }

    public void setMaladie(String maladie) {
        this.maladie = maladie;
    }
    
    
}
