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
import java.sql.Statement;
import utilitaire.UtilDB;

/**
 *
 * @author Valiah Karen
 */
public class MaladieMembre extends ClassMAPTable {

    @Expose
    private String id;
    @Expose
    private String idMaladie;
    @Expose
    private String idMembre;
    @Expose
    private String membre;
    @Expose
    private String maladie;
    @Expose
    private String etatlib;
    @Expose
    private String nom;
    @Expose
    private String prenom;

    @Expose
    private String ingredient;
    @Expose
    private String idingredient;
    @Expose
    private String etatingredient;
    @Expose
    private String idfamille;
    @Expose
    private String idingredientmaladie;

    public String getIdingredientmaladie() {
        return idingredientmaladie;
    }

    public void setIdingredientmaladie(String idingredientmaladie) {
        this.idingredientmaladie = idingredientmaladie;
    }

    public String getIngredient() {
        return ingredient;
    }

    public void setIngredient(String ingredient) {
        this.ingredient = ingredient;
    }

    public String getIdingredient() {
        return idingredient;
    }

    public void setIdingredient(String idingredient) {
        this.idingredient = idingredient;
    }

    public String getEtatingredient() {
        return etatingredient;
    }

    public void setEtatingredient(String etatingredient) {
        this.etatingredient = etatingredient;
    }

    public String getIdfamille() {
        return idfamille;
    }

    public void setIdfamille(String idfamille) {
        this.idfamille = idfamille;
    }

    public String getMembre() {
        return membre;
    }

    public void setMembre(String membre) {
        this.membre = membre;
    }

    public String getMaladie() {
        return maladie;
    }

    public void setMaladie(String maladie) {
        this.maladie = maladie;
    }

    public String getEtatlib() {
        return etatlib;
    }

    public void setEtatlib(String etatlib) {
        this.etatlib = etatlib;
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

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdMaladie() {
        return idMaladie;
    }

    public void setIdMaladie(String idMaladie) {
        this.idMaladie = idMaladie;
    }

    public String getIdMembre() {
        return idMembre;
    }

    public void setIdMembre(String idMembre) {
        this.idMembre = idMembre;
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
        preparePk("maladiemembre", "get_seqmaladiemembre");
        setId(makePK(c));
    }

    public MaladieMembre() {
        this.setNomTable("maladiemembre");
    }

    public MaladieMembre ajoutMaladiMembre(Connection c) throws Exception {
        boolean estOuvert = false;
        MaladieMembre resp = new MaladieMembre();
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                estOuvert = true;
            }

            resp = resp.ajoutM(c, this);
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

    public MaladieMembre ajoutM(Connection c, MaladieMembre m) throws Exception {
        return (MaladieMembre) m.createObject(null, c);
    }

    public MaladieMembre[] getIngredientInterdit(String idfamille, String table, Connection c, String[] str) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                estOuvert = true;
            }
            MaladieMembre crt = new MaladieMembre();
            // if (table != null && table.compareToIgnoreCase("") != 0) {
            crt.setNomTable(table);

            if (str == null || str.length==0) {
                System.out.println("idMaladiie ==== " + this.getId());
                //}
                System.out.println("table = " + crt.getNomTable());

                return (MaladieMembre[]) CGenUtil.rechercher(crt, null, null, c, " and idfamille = '" + idfamille + "'");
            } else {
                int length = str.length;
                String apres = " and idfamille = '" + idfamille +"'";
                if(length>0){
                    apres+= " and idingredient not in (";
                }
                for (int i = 0; i < length; i++) {
                    if (i + 1 < length) {
                        apres += "'" + str[i] + "',";
                    }
                    if (i + 1 == length) {
                        apres += "'" + str[i] + "')";
                    }
                }
                System.out.println("apres = " + apres);
                return (MaladieMembre[]) CGenUtil.rechercher(crt, null, null, c, " and idfamille = '" + idfamille + "'");
            }
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

    public MaladieMembre[] listeMaladieMembre(String idmembre, String table, Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                estOuvert = true;
            }
            System.out.println("idMaladiie ==== " + this.getId());
            MaladieMembre crt = new MaladieMembre();
            // if (table != null && table.compareToIgnoreCase("") != 0) {
            crt.setNomTable(table);
            //}
            System.out.println("table = " + crt.getNomTable());
            return (MaladieMembre[]) CGenUtil.rechercher(crt, null, null, c, " and idmembre = '" + idmembre + "' and etat = 1");
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

    public void deleteMaladieMembre(String idmaladiemembre, Connection c) throws Exception {
        Statement stmt = null;
        boolean check = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                check = true;
                c.setAutoCommit(false);
                String requeteUpdate = " Update maladiemembre set etat = 0 where id = '" + idmaladiemembre + "'";
                stmt = c.createStatement();
                stmt.executeUpdate(requeteUpdate);
            }
            if (check) {
                c.commit();
            }
        } catch (Exception ex) {
            if (c != null && check) {
                c.rollback();
            }
            throw ex;
        } finally {
            if (c != null & check) {
                c.close();
            }
        }

    }

}
