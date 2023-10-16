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
import java.sql.Date;
import utilitaire.UtilDB;

/**
 *
 * @author Valiah Karen
 */
public class Membre extends ClassMAPTable {
    @Expose
    private String id;
    @Expose
    private String idfamille;
    @Expose
    private String nom;
    @Expose
    private String prenom;
    @Expose
    private Date datenaissance;

    public Membre() {
        this.setNomTable("membre");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdfamille() {
        return idfamille;
    }

    public void setIdfamille(String idfamille) {
        this.idfamille = idfamille;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public Date getDatenaissance() {
        return datenaissance;
    }

    public void setDatenaissance(Date datenaissance) {
        /* int year = (datenaissance.getYear()+1900);
        int month = (datenaissance.getMonth()+1);
        int date  =  (datenaissance.getDate());*/
        this.datenaissance = datenaissance;//new Date(year,month,date);
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("membre", "getseq_membre");
        setId(makePK(c));
    }

    public Membre ajoutMembre(Connection c,Membre f) throws Exception {
        boolean estOuvert = false;
        Membre resp = new Membre();
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                estOuvert = true;
            }

            resp = resp.ajoutM(c, f);
            if (c != null && estOuvert) {
                c.commit();
            }
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null && estOuvert) {
                c.close();
            }
        }
        return resp;
    }

    public Membre ajoutM(Connection c, Membre m) throws Exception {
        return (Membre) m.createObject(null, c);
    }

    public Membre[] listeMembre(String idfamille, String table, Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                estOuvert = true;
            }
            System.out.println("idfamille ==== " + idfamille);
            Membre crt = new Membre();
            if (table != null && table.compareToIgnoreCase("") != 0) {
                crt.setNomTable(table);
            }
            System.out.println("table = " + crt.getNomTable());
            return (Membre[]) CGenUtil.rechercher(crt, null, null, c, " and idfamille = '" + idfamille + "'");
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
