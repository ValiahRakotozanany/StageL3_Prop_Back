/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package map;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author drana
 */
public class Entite  extends ClassMAPTable{
    private String id;
    private String denomination;
    private String siege;
    private int effectif;
    private String activite;
    private Date dateCreation;
    private String circonscription;
    private String contact;
    private String idType;

    public Entite(String denomination, String siege, int effectif, String activite, Date dateCreation, String circonscription, String contact) {
        this.denomination = denomination;
        this.siege = siege;
        this.effectif = effectif;
        this.activite = activite;
        this.dateCreation = dateCreation;
        this.circonscription = circonscription;
        this.contact = contact;
    }
    public Entite()
    {
        this.setNomTable("entite");
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
        preparePk("ENT", "getseqentite");
        setId(makePK(c));
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDenomination() {
        return denomination;
    }

    public void setDenomination(String denomination) throws Exception {
        if(this.getMode().equals("modif")){
            if(denomination==null||denomination.equals("")){
                throw new Exception("Denomination obligatoire");
            }
        }
        this.denomination = denomination;
    }

    public String getSiege() {
        return siege;
    }

    public void setSiege(String siege) {
        this.siege = siege;
    }

    public int getEffectif() {
        return effectif;
    }

    public void setEffectif(int effectif) {
        this.effectif = effectif;
    }

    public String getActivite() {
        return activite;
    }

    public void setActivite(String activite) {
        this.activite = activite;
    }

    public Date getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(Date dateCreation) {
        this.dateCreation = dateCreation;
    }

    public String getCirconscription() {
        return circonscription;
    }

    public void setCirconscription(String circonscription) {
        this.circonscription = circonscription;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) throws Exception {
        if(this.getMode().equals("modif")){
            if(contact==null||contact.equals("")){
                throw new Exception("Contact obligatoire");
            }
        }
        this.contact = contact;
    }

    public String getIdType() {
        return idType;
    }

    public void setIdType(String idType) throws Exception{
        if(this.getMode().equals("modif")){
            if(idType==null||idType.equals("")){
                throw new Exception("Type d'entité obligatoire");
            }
        }
        this.idType = idType;
    }

    public String getValColLibelle(){
        return this.getDenomination();
    }
    
}
