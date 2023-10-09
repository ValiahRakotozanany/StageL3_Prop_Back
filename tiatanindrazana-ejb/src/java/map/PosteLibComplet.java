/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package map;

/**
 *
 * @author itu
 */
public class PosteLibComplet extends Poste{
    String idregionlib;
    String iddistrictlib;
    String idcommunelib;
    String nompersonne;
    String prenompersonne;

    public String getIdregionlib() {
        return idregionlib;
    }

    public void setIdregionlib(String idregionlib) {
        this.idregionlib = idregionlib;
    }

    public String getIddistrictlib() {
        return iddistrictlib;
    }

    public void setIddistrictlib(String iddistrictlib) {
        this.iddistrictlib = iddistrictlib;
    }

    public String getIdcommunelib() {
        return idcommunelib;
    }

    public void setIdcommunelib(String idcommunelib) {
        this.idcommunelib = idcommunelib;
    }

    public String getNompersonne() {
        return this.nompersonne;
    }

    public void setNompersonne(String nompersonne) {
        this.nompersonne = nompersonne;
    }

    public String getPrenompersonne() {
        return this.prenompersonne;
    }

    public void setPrenompersonne(String prenompersonne) {
        this.prenompersonne = prenompersonne;
    }

    
    public PosteLibComplet(){
        super.setNomTable("v_poste_lib_complet");
    }
    
}
