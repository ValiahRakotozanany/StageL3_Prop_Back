/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package map.Proposition;

import bean.CGenUtil;
import bean.ClassMAPTable;
import com.google.gson.annotations.Expose;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.Statement;
import java.util.Formatter;
import utilitaire.UtilDB;

/**
 *
 * @author Valiah Karen
 */
public class Famille extends ClassMAPTable{
    @Expose
    private String id;
    @Expose
    private String nomfamille;
    @Expose
    private String email;
    @Expose
    private String motdepasse;
    @Expose
    private String token;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    
    public Famille(){
        this.setNomTable("famille");
    }
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNomfamille() {
        return nomfamille;
    }

    public void setNomfamille(String nomfamille) {
        this.nomfamille = nomfamille;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMotdepasse() {
        return motdepasse;
    }

    public void setMotdepasse(String motdepasse) {
        this.motdepasse = motdepasse;
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
        preparePk("famille", "getseq_famille");
        setId(makePK(c));
    }

    public Famille(String nomfamille, String email, String motdepasse) {
        this.setNomTable("Famille");
        this.nomfamille = nomfamille;
        this.email = email;
        this.motdepasse = motdepasse;
    }
    
    
    public Famille(String email, String motdepasse) {
        this.setNomTable("Famille");
        this.email = email;
        this.motdepasse = motdepasse;
    }
    
     public static Famille inscription(Connection c, Famille client) throws Exception {      
        String mdpTemp = client.getMotdepasse();
        
        client.createObject(null, c);
        return connect(c, client.getEmail(), mdpTemp, "");
    }
     public Famille inscription(Connection c) throws Exception{
       boolean estOuvert = false;
       Famille resp = null;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                estOuvert = true;
            }

            resp = Famille.inscription(c, this);
            if (c != null && estOuvert) {
                c.commit();
            }
        } catch(Exception ex){
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
    
    
    public static Famille connect(Connection c, String email, String mdp, String language) throws Exception {
        boolean check = false;
        Statement stmt = null;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                check = true;
                c.setAutoCommit(false);
            }
            
            ;
            Famille client = new Famille();
            client.setEmail(email);
            client.setMotdepasse(mdp);
            client = client.testLogin(c);
            
           // String requeteUpdate = " Update tokenclient set etat = 11 where idJoueur = '"+ client.getId() +"'";
            //stmt = c.createStatement();
            ///stmt.executeUpdate(requeteUpdate);
            FamilleToken tokenUser = new FamilleToken();
            tokenUser.setIduser(client.getTuppleID());
            tokenUser.setIdfamille(client.getTuppleID());
            tokenUser.setToken(encryptTxt(email + mdp + new java.sql.Timestamp(System.currentTimeMillis())));
            tokenUser.setDateexp(new java.sql.Timestamp(System.currentTimeMillis()));
            if(language==null||language.isEmpty()) language = "mg";
            tokenUser.setLangue(language);
            tokenUser.construirePK(c);
            tokenUser.insertToTable(c);
            client.setToken(tokenUser.getToken());
            ClientStatic.setClientInfo(client, tokenUser);
            
            if (check)
                c.commit();
            return client;
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
    
    public Famille testLogin(Connection c) throws Exception {
        Famille temp = new Famille();
        temp.setNomTable("famille");
        boolean estOuvert = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                estOuvert = true;
            }
            temp.setEmail(this.getEmail());
            System.out.println("MAIL======"+this.getEmail());
            Famille[] liste = (Famille[]) CGenUtil.rechercher(temp, null, null, c, " and email = '"+this.getEmail()+"' and motdepasse = '"+this.getMotdepasse()+"'");
            
            if (liste.length > 0) {
                temp = liste[0];
              //  Configuration[] conf = (Configuration[]) CGenUtil.rechercher(new Configuration(), null, null, c, " and code = '05' order by libelle asc ");
              /*  if (conf.length < 2) {
                    throw new Exception("Erreur configuration introuvable");
                }
                //String prefixe = conf[0].getValeur();
                String suffixe = conf[1].getValeur();
                String passCrypt = historique.ParamCryptUtil.encryptPassword(prefixe + this.getPwd() + suffixe);
                
                System.out.println(temp.getPwd() + " : " + this.getPwd() + " : " + passCrypt);*/
               /* if (temp.getPwd().compareTo(passCrypt) == 0)
                    return temp;*/
                /*else
                    throw new Exception("Erreur de Login ");*/
                
                return temp;
            } else {
                throw new Exception("Erreur de Login ");
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && estOuvert == true) {
                c.close();
            }
        }
    }
   
    public static String encryptTxt(String txt) throws Exception {
        MessageDigest crypt = MessageDigest.getInstance("SHA-1");
        crypt.reset();
        crypt.update(txt.getBytes("UTF-8"));
        return byteToHex(crypt.digest());
    }
 public static String byteToHex(byte[] hash) {
        String result;
        try (Formatter formatter = new Formatter()) {
            for (byte b : hash) {
                formatter.format("%02x", b);
            }
            result = formatter.toString();
        }
        return result;
    }

    
}
