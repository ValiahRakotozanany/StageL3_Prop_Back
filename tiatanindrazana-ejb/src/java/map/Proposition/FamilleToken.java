/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package map.Proposition;

import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Timestamp;
import java.util.Calendar;

/**
 *
 * @author Valiah Karen
 */
public class FamilleToken extends ClassEtat{
    private String id,token,idJoueur,langue;
    private Timestamp dateexp;
    private int etat;

    public String getLangue() {
        return langue;
    }

    public void setLangue(String langue) {
        this.langue = langue;
    }

    public int getEtat() {
        return etat;
    }

    public void setEtat(int etat) {
        this.etat = etat;
    }
    
    
    public FamilleToken() {
        super.setNomTable("FamilleToken");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getIdJoueur() {
        return idJoueur;
    }

    public void setIdJoueur(String idJoueur) {
        this.idJoueur = idJoueur;
    }

    public Timestamp getDateexp() {
        return dateexp;
    }

    public void setDateexp(Timestamp dateexp) {
        Calendar c = Calendar.getInstance().getInstance();
        c.setTime(dateexp);
        c.add(Calendar.DATE, 1);
        dateexp = new Timestamp(c.getTimeInMillis());
        this.dateexp = dateexp;
    }
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    @Override
     public void construirePK(Connection c) throws Exception {
        this.preparePk("FamToken", "getseq_famtoken");
        this.setId(makePK(c));
    }
}
