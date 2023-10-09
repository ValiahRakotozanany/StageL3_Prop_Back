/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package map;

import antenne.Commune;

/**
 *
 * @author itu
 */
public class CommuneLibComplet extends Commune{
    String idDistrictLib;
    String idRegion;
    String idRegionLib;

    public CommuneLibComplet() throws Exception {
        this.setNomTable("v_commune_lib_complet");
    }

    public String getIdDistrictLib() {
        return idDistrictLib;
    }

    public void setIdDistrictLib(String idDistrictLib) {
        this.idDistrictLib = idDistrictLib;
    }

    public String getIdRegion() {
        return idRegion;
    }

    public void setIdRegion(String idRegion) {
        this.idRegion = idRegion;
    }

    public String getIdRegionLib() {
        return idRegionLib;
    }

    public void setIdRegionLib(String idRegionLib) {
        this.idRegionLib = idRegionLib;
    }


    @Override
    public String toString() {
        return "CommuneLibComplet{" +
                "idDistrictLib='" + idDistrictLib + '\'' +
                ", idRegion='" + idRegion + '\'' +
                ", idRegionLib='" + idRegionLib + '\'' +
                '}';
    }
}
