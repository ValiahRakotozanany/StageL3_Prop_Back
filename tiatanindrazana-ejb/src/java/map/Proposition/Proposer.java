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
import java.util.ArrayList;
import java.util.List;
import utilitaire.UtilDB;

/**
 *
 * @author Valiah Karen
 */
public class Proposer extends ClassMAPTable {

    @Expose
    private String idplat;
    @Expose
    private String idtype;
    @Expose
    private String val;
    @Expose
    private String nomplats;
    @Expose
    private double prixadulte;
    @Expose
    private double prixenfant;
    @Expose
    private int ordre;

    @Expose
    private int nbr;
    @Expose
    private double totalprix;

    public int getNbr() {
        return nbr;
    }

    public void setNbr(int nbr) {
        this.nbr = nbr;
    }

    public double getTotalprix() {
        return totalprix;
    }

    public void setTotalprix(double totalprix) {
        this.totalprix = totalprix;
    }

    public int getOrdre() {
        return ordre;
    }

    public void setOrdre(int ordre) {
        this.ordre = ordre;
    }

    public Proposer() {
        this.setNomTable("propo_plat_bugdet");
    }

    public String getIdplat() {
        return idplat;
    }

    public void setIdplat(String idplat) {
        this.idplat = idplat;
    }

    public String getIdtype() {
        return idtype;
    }

    public void setIdtype(String idtype) {
        this.idtype = idtype;
    }

    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }

    public String getNomplats() {
        return nomplats;
    }

    public void setNomplats(String nomplats) {
        this.nomplats = nomplats;
    }

    public double getPrixadulte() {
        return prixadulte;
    }

    public void setPrixadulte(double prixadulte) {
        this.prixadulte = prixadulte;
    }

    public double getPrixenfant() {
        return prixenfant;
    }

    public void setPrixenfant(double prixenfant) {
        this.prixenfant = prixenfant;
    }

    @Override
    public String getTuppleID() {
        return this.idplat;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public Proposer[] getPropositionJour(String idfamille, String table, Connection c, String[] ingredients, String[] type) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                estOuvert = true;
            }
            MaladieMembre crt = new MaladieMembre();
            MaladieMembre[] ing = crt.getIngredientInterdit(idfamille, table, c, ingredients);
            // if (table != null && table.compareToIgnoreCase("") != 0) {
            crt.setNomTable(table);
            String apres = "";
            if (type != null || type.length > 0) {
                apres += " and (";
                for (int i = 0; i < type.length; i++) {
                    if (i + 1 < type.length) {
                        apres += " idtype = '" + type[i] + "' or ";
                    }
                    if (i + 1 == type.length) {
                        apres += " idtype = '" + type[i] + "') ";
                    }
                }
                System.out.println("aprestype = " + apres);
            }

            if (ing != null || ing.length > 0) {
                apres += " and idplat not in ( SELECT p.IDPLAT  FROM PLATFILLE p WHERE p.ETATINGREDIENT =1 and p.IDINGREDIENT  IN (";
                for (int i = 0; i < ing.length; i++) {
                    if (i + 1 < ing.length) {
                        apres += "'" + ing[i].getIdingredient() + "',";
                    }
                    if (i + 1 == ing.length) {
                        apres += "'" + ing[i].getIdingredient() + "'))";
                    }
                }
                apres += " order by ordre asc";
                System.out.println("apres = " + apres);

            }
            return (Proposer[]) CGenUtil.rechercher(new Proposer(), null, null, c, apres);

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

    public ArrayList<ArrayList<Proposer>> dispatchProp(Proposer[] listeplat, String[] type) {
        int size = 0;
        ArrayList<ArrayList<Proposer>> dispatch = new ArrayList<ArrayList<Proposer>>();
        for (int j = 0; j < type.length; j++) {
            ArrayList<Proposer> p = new ArrayList<>();
            for (int i = 0; i < listeplat.length; i++) {
                if (listeplat[i].getIdtype().compareTo(type[j]) == 0) {
                    p.add(listeplat[i]);
                    System.out.print(" type = " + i + ", ==>" + listeplat[i].getNomplats() + " - " + listeplat[i].getIdtype());
                }
            }
            dispatch.add(p);
        }
        return dispatch;
    }

    public static ArrayList<ArrayList<Proposer>> generateCombinations(ArrayList<ArrayList<Proposer>> typesOfPlats) {
        ArrayList<ArrayList<Proposer>> combinations = new ArrayList<>();
        generateCombinationsHelper(typesOfPlats, 0, new ArrayList<>(), combinations);
        return combinations;
    }

    private static void generateCombinationsHelper(ArrayList<ArrayList<Proposer>> typesOfPlats, int index, List<Proposer> currentCombination, ArrayList<ArrayList<Proposer>> combinations) {
        System.out.println(" index = " + index);
        if (index == typesOfPlats.size()) {
            combinations.add(new ArrayList<>(currentCombination));
            return;
        }

        List<Proposer> currentTypePlats = typesOfPlats.get(index);
        for (Proposer plat : currentTypePlats) {
            currentCombination.add(plat);
            generateCombinationsHelper(typesOfPlats, index + 1, currentCombination, combinations);
            currentCombination.remove(currentCombination.size() - 1);
        }
    }

    public ArrayList<ArrayList<Proposer>> propAvecBudgetEtNbrPers(ArrayList<ArrayList<Proposer>> listeTotal, double budget1, double budget2, int nombrePers) {

        ArrayList<ArrayList<Proposer>> newProp = new ArrayList<ArrayList<Proposer>>();
        for (int i = 0; i < listeTotal.size(); i++) {
            double somme = 0;
            int nbr = 1;
            for (int j = 0; j < listeTotal.get(i).size(); j++) {
                somme += (listeTotal.get(i).get(j).getPrixenfant() * nombrePers / nbr);
                listeTotal.get(i).get(j).setTotalprix((listeTotal.get(i).get(j).getPrixenfant() * nombrePers / nbr));
                listeTotal.get(i).get(j).setNbr((nombrePers / nbr));
                nbr = nbr + 1;
            }
            
            if (somme <= budget2 && somme >= budget1) {
                newProp.add(listeTotal.get(i));
            }            
        }
        if (budget2 <= 0) {
            return listeTotal;
        }
        return newProp;
    }
    //private

    /*
    

    public static ArrayList<Proposer> genererPropositionjour(Proposer[] listePlat, int lengthType, int index, ArrayList<Proposer> Propfinal, int tl, int iteration, int isuite) {
        int i = iteration;
        if (i < listePlat.length) {
            if (index < listePlat.length) {
                //   Proposer[] proposer = new Proposer[lengthType];
                System.out.println("type liste i et index === >" + listePlat[i].getIdtype() + " ______ +" + listePlat[index].getIdtype() + " , i = " + i);
                if ((listePlat[i].getIdtype().compareTo(listePlat[index].getIdtype())) != 0) {
                    //Propfinal.add(listePlat[index]);                    
                    System.out.println("tl = " + tl + " , i = " + i + " , index = " + index);
                    if (tl < lengthType) {
                        if (index + 1 == listePlat.length) {
                            i++;
                            iteration++;
                        } else {
                            // proposer[tl] = listePlat[index];
                            System.out.println(" liste index == " + listePlat[index].getNomplats());
                            System.out.println(" liste index == " + listePlat[index].getIdtype());
                            //  Propfinal.add(proposer);
                            if (i + 1 < listePlat.length) {
                                Propfinal.add(listePlat[index]);
                                Propfinal.add(listePlat[isuite - 1]);
                                for (int j = 0; j < Propfinal.size(); j++) {
                                    System.out.println(Propfinal.get(j).getNomplats() + " NomPlats TAFIDITRA");
                                }

                                tl = tl + 1;
                                System.out.println(" Plat miditra " + listePlat[index].getNomplats() + " - ");
                                System.out.println(" mbola tsy mety fa averina index == " + (index + 1) + (tl + 1));
                                genererPropositionjour(listePlat, lengthType, index + 1, Propfinal, tl + 1, index, i);
                                Propfinal.add(listePlat[isuite - 1]);
                                System.out.println(" Plat miditra voalohany nefa farany ===" + listePlat[isuite - 1].getNomplats() + " - ");
                            } else {
                                return Propfinal;
                            }
                        }
                    } else {
                        tl = 0;
                        genererPropositionjour(listePlat, lengthType, index + 1, Propfinal, 0, isuite, isuite + 1);
                    }
                }
                if (listePlat[i].getIdtype().compareTo(listePlat[index].getIdtype()) == 0) {
                    genererPropositionjour(listePlat, lengthType, index + 1, Propfinal, tl, i, i + 1);
                }
            }
            index = i + 1;
            System.out.println("index ,niova satria iova ny i = " + index);
            tl = 0;
            genererPropositionjour(listePlat, lengthType, index + 1, Propfinal, tl, i + 1, i + 2);
        } else {
            return Propfinal;
        }

        return Propfinal;

    }
     */
}
