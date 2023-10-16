/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package map.Proposition;

import bean.CGenUtil;
import bean.ClassMAPTable;
import com.google.gson.annotations.Expose;
import java.sql.Connection;
import utilitaire.UtilDB;

/**
 *
 * @author Valiah Karen
 */
public class Typeplat extends ClassMAPTable{
    @Expose
    private String id;
    @Expose
    private String VAL;
    @Expose
    private int etat;

    public Typeplat(){
        this.setNomTable("typeplat");
    }
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getVAL() {
        return VAL;
    }

    public void setVAL(String VAL) {
        this.VAL = VAL;
    }


    public int getEtat() {
        return etat;
    }

    public void setEtat(int etat) {
        this.etat = etat;
    }

    @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    public Typeplat[] listeType(String table, Connection c) throws Exception{
        //Maladie[] mm =(Maladie[])CGenUtil.rechercher(m, null, null, c, "");
          boolean estOuvert = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                estOuvert = true;
            }
            System.out.println("idMaladiie ==== ");
            Typeplat crt = new Typeplat();
           // if (table != null && table.compareToIgnoreCase("") != 0) {
                crt.setNomTable(table);
            //}
            System.out.println("table = " + crt.getNomTable());
            return (Typeplat[])CGenUtil.rechercher(crt, null, null, c, "");
        } catch (Exception e) {
            if (c != null) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && estOuvert == true) {
                c.close();
            }
        }
    }
}
