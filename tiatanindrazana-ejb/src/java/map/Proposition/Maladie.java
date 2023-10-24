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
public class Maladie extends ClassMAPTable {

    @Expose
    private String id;
    @Expose
    private String maladie;
    @Expose
    private int etat;
    @Expose
    private String etatlib;
    private int nbrMaladie;
    private int limitNombre;

    public int getNbrMaladie() {
        return nbrMaladie;
    }

    public void setNbrMaladie(int nbrMaladie) {
        this.nbrMaladie = nbrMaladie;
    }

    public int getLimitNombre() {
        return limitNombre;
    }

    public void setLimitNombre(int limitNombre) {
        this.limitNombre = limitNombre;
    }

    public String getEtatlib() {
        return etatlib;
    }

    public void setEtatlib(String etatlib) {
        this.etatlib = etatlib;
    }

    public Maladie() {
        this.setNomTable("maladie");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMaladie() {
        return maladie;
    }

    public void setMaladie(String maladie) {
        this.maladie = maladie;
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

    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("maladie", "getseq_maladie");
        setId(makePK(c));
    }

    public IngredientMaladie_lib[] getRecette(String table, Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                estOuvert = true;
            }
            System.out.println("idMaladiie ==== " + this.getId());
            IngredientMaladie_lib crt = new IngredientMaladie_lib();
            if (table != null && table.compareToIgnoreCase("") != 0) {
                crt.setNomTable(table);
            }
            System.out.println("table = " + crt.getNomTable());
            return (IngredientMaladie_lib[]) CGenUtil.rechercher(crt, null, null, c, " and id = '" + this.getId() + "'");
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

    public PlatMaladie[] getPlatMaladie(String table, Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                estOuvert = true;
            }
            System.out.println("idMaladiie ==== " + this.getId());
            PlatMaladie crt = new PlatMaladie();
            // if (table != null && table.compareToIgnoreCase("") != 0) {
            crt.setNomTable(table);
            //}
            System.out.println("table = " + crt.getNomTable());
            return (PlatMaladie[]) CGenUtil.rechercher(crt, null, null, c, " and id = '" + this.getId() + "'");
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

    public Maladie[] listeMaladie(String table, Connection c) throws Exception {
        //Maladie[] mm =(Maladie[])CGenUtil.rechercher(m, null, null, c, "");
        boolean estOuvert = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                estOuvert = true;
            }
            System.out.println("idMaladiie ==== " + this.getId());
            Maladie crt = new Maladie();
            // if (table != null && table.compareToIgnoreCase("") != 0) {
            crt.setNomTable(table);
            //}
            System.out.println("table = " + crt.getNomTable());
            return (Maladie[]) CGenUtil.rechercher(crt, null, null, c, "");
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

    public Maladie[] statMaladie(String table, Connection c,int limit) throws Exception {
        //Maladie[] mm =(Maladie[])CGenUtil.rechercher(m, null, null, c, "");
        boolean estOuvert = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                estOuvert = true;
            }
            System.out.println("idMaladiie ==== " + this.getId());
            Maladie crt = new Maladie();
            // if (table != null && table.compareToIgnoreCase("") != 0) {
            crt.setNomTable(table);
            crt.setLimitNombre(limit);
            //}
            System.out.println("table = " + crt.getNomTable());
            String requete = "SELECT count(IDMALADIE) AS nbrMaladie,IDMALADIE as id ,MALADIE FROM MALADIEMEMBRE_LIB ml  \n"
                    + " WHERE ROWNUM <= "+(crt.getLimitNombre()+1)+"  GROUP BY IDMALADIE,MALADIE ORDER BY count(IDMALADIE) DESC";
            return (Maladie[]) CGenUtil.rechercher(crt, requete, c);
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
