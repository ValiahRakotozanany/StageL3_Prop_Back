/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package map.Proposition;

import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.ClassMere;
import java.sql.Connection;
import map.PersonneCommune;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author Valiah Karen
 */
public class Plat extends ClassMAPTable {

    private String id;
    private String nomplats;
    private String descri;
    private String idplattyper;
    private String idtypeplat;
    private String typeplat;

    public String getIdplattyper() {
        return idplattyper;
    }

    public void setIdplattyper(String idplattyper) {
        this.idplattyper = idplattyper;
    }

    public String getIdtypeplat() {
        return idtypeplat;
    }

    public void setIdtypeplat(String idtypeplat) {
        this.idtypeplat = idtypeplat;
    }

    public String getTypeplat() {
        return typeplat;
    }

    public void setTypeplat(String typeplat) {
        this.typeplat = typeplat;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNomplats() {
        return nomplats;
    }

    public void setNomplats(String nomplats) {
        this.nomplats = nomplats;
    }

    public String getDescri() {
        return descri;
    }

    public void setDescri(String descri) {
        this.descri = descri;
    }

    public Plat() {
        this.setNomTable("plat");
    }

    @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("plat", "getseq_plat");
        setId(makePK(c));
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public Plat[] getTypePlat(String table, Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                estOuvert = true;
            }
            Plat p = new Plat();
            if (table != null && table.compareToIgnoreCase("") != 0) {
                p.setNomTable(table);
            }
            System.out.println("table = " + p.getNomTable());
            p.setNomTable("PLATTYPER_lib");
            return (Plat[]) CGenUtil.rechercher(p, null, null, c, " and id= '" + this.getId() + "'");
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

    public Platfille_lib[] getRecette(String table, Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                estOuvert = true;
            }
            System.out.println("idPLAAAt ==== " + this.getId());
            Platfille_lib crt = new Platfille_lib();
            if (table != null && table.compareToIgnoreCase("") != 0) {
                crt.setNomTable(table);
            }
            System.out.println("table = " + crt.getNomTable());
            return (Platfille_lib[]) CGenUtil.rechercher(crt, null, null, c, " and idPlat = '" + this.getId() + "'");
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
