/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package map;


/**
 *
 * @author drana
 */
public class V_ENTITE_LIBCOMPLET extends Entite{
    private String typeentite;
    
    @Override
    public String getTuppleID() {
     return super.getTuppleID();
    }

    @Override
    public String getAttributIDName() {
       return "id";
    }

    public String getTypeentite() {
        return typeentite;
    }

    public void setTypeentite(String typeentite) {
        this.typeentite = typeentite;
    }
    
}
