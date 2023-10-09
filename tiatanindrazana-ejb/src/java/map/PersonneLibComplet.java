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
public class PersonneLibComplet extends Personne {
    
    String etatlib;
    String idAttenteLib;
    String regionlib;
    String communeslib;
    String districtlib;
    String idresponsablelib;
    String typeentites;
    String demandesLib;   
    String idTypeTraitementLib;

    public String getIdTypeTraitementLib() {
        return idTypeTraitementLib;
    }

    public void setIdTypeTraitementLib(String idTypeTraitementLib) {
        this.idTypeTraitementLib = idTypeTraitementLib;
    }
    
    public String getTypeentites() {
        return typeentites;
    }

    public void setTypeentites(String typeentites) {
    this.typeentites = typeentites;
    }

    public String getIdresponsablelib() {
        return idresponsablelib;
    }

    public void setIdresponsablelib(String idresponsablelib) {
        this.idresponsablelib = idresponsablelib;
    }
    
    
    
    public PersonneLibComplet(){
        super.setNomTable("v_personne_lib_complet");
    }

    public String getEtatlib() {
        return etatlib;
    }

    public void setEtatlib(String etatlib) {
        this.etatlib = etatlib;
    }

    public String getIdAttenteLib() {
        return idAttenteLib;
    }

    public void setIdAttenteLib(String idAttenteLib) {
        this.idAttenteLib = idAttenteLib;
    }

    public String getRegionlib() {
        return regionlib;
    }

    public void setRegionlib(String regionlib) {
        this.regionlib = regionlib;
    }

    public String getCommuneslib() {
        return communeslib;
    }

    public void setCommuneslib(String communeslib) {
        this.communeslib = communeslib;
    }

    public String getDistrictlib() {
        return districtlib;
    }

    public void setDistrictlib(String districtlib) {
        this.districtlib = districtlib;
    }

    public String getDemandesLib() {
        return demandesLib;
    }

    public void setDemandesLib(String demandesLib) {
        this.demandesLib = demandesLib;
    }
    
    
}
