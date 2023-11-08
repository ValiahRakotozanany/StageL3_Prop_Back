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
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
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

    @Expose
    private Platfille_lib[] ingredients;

    @Expose
    private int etat;

    @Expose
    private Date dateproposition;

    public int getEtat() {
        return etat;
    }

    public void setEtat(int etat) {
        this.etat = etat;
    }

    public Platfille_lib[] getIngredients() {
        return ingredients;
    }

    public void setIngredients(Connection c) throws Exception {

        boolean estOuvert = false;
        try {

            c = new UtilDB().GetConn();
            estOuvert = true;

            //System.out.println("idMaladiie ==== " + this.getId());            
            // if (table != null && table.compareToIgnoreCase("") != 0) {            
            //}
            System.out.println("table = " + this.getNomTable());
            this.ingredients = (Platfille_lib[]) CGenUtil.rechercher(new Platfille_lib(), null, null, c, " and idplat = '" + this.getIdplat() + "'");
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

    /* public void setIngredients(Platfille_lib[] ingredients) {
        this.ingredients = ingredients;
    }
     */
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

    public Date getDateproposition() {
        return dateproposition;
    }

    public void setDateproposition(Date dateproposition) {
        this.dateproposition = dateproposition;
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

    public ArrayList<ArrayList<Proposer>> generateCombinations(ArrayList<ArrayList<Proposer>> typesOfPlats) {
        ArrayList<ArrayList<Proposer>> combinations = new ArrayList<>();
        generateCombinationsHelper(typesOfPlats, 0, new ArrayList<>(), combinations);
        return combinations;
    }

    private void generateCombinationsHelper(ArrayList<ArrayList<Proposer>> typesOfPlats, int index, List<Proposer> currentCombination, ArrayList<ArrayList<Proposer>> combinations) {
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

    public ArrayList<ArrayList<Proposer>> propAvecBudgetEtNbrPers(ArrayList<ArrayList<Proposer>> listeTotal, double budget1, double budget2, int nombrePers) throws Exception {

        ArrayList<ArrayList<Proposer>> newProp = new ArrayList<ArrayList<Proposer>>();
        for (int i = 0; i < listeTotal.size(); i++) {
            double somme = 0;
            int nbr = 1;
            for (int j = 0; j < listeTotal.get(i).size(); j++) {
                somme += (listeTotal.get(i).get(j).getPrixenfant() * nombrePers / nbr);
                listeTotal.get(i).get(j).setTotalprix((listeTotal.get(i).get(j).getPrixenfant() * nombrePers / nbr));
                listeTotal.get(i).get(j).setIngredients(null);
                listeTotal.get(i).get(j).setNbr((nombrePers / nbr));
                nbr = nbr + 1;
                System.out.println(" somme + nom plat + noombre = " + somme + " , " + listeTotal.get(i).get(j).getNomplats() + " , " + listeTotal.get(i).get(j).getNbr());
            }

            if (somme <= budget2 && somme >= budget1) {
                System.out.println(" somme = " + somme);
                newProp.add(listeTotal.get(i));
                somme = 0;
            }
        }
        if (budget2 <= 0) {
            return listeTotal;
        }
        return newProp;
    }

    //-------PLANNING
    public ArrayList<ArrayList<Proposer>> generateCombinationPlanning(ArrayList<ArrayList<Proposer>> typesOfPlats) {
        ArrayList<ArrayList<Proposer>> combinations = new ArrayList<>();
        int[] indices = new int[typesOfPlats.size()];

        while (indices[0] < typesOfPlats.get(0).size()) {
            ArrayList<Proposer> combination = new ArrayList<>();
            for (int i = 0; i < indices.length; i++) {
                if (typesOfPlats.get(i).size() != 0) {
                    combination.add(typesOfPlats.get(i).get(indices[i]));
                    typesOfPlats.get(i).remove(typesOfPlats.get(i).get(indices[i]));
                    //  indices = new int[typesOfPlats.size()];             
                }
            }
            combinations.add(combination);

            for (int i = indices.length - 1; i >= 0; i--) {
                if (indices[i] < typesOfPlats.get(i).size() - 1) {
                    indices[i]++;
                    break;
                } else if (i > 0) {
                    indices[i] = 0;
                } else {
                    indices[0]++;
                }
            }
        }

        return combinations;
    }

    public ArrayList<ArrayList<Proposer>> propPlanning(ArrayList<ArrayList<Proposer>> listeTotal, double budget1, double budget2, int nombrePers, String idFamille) throws Exception {

        ArrayList<ArrayList<Proposer>> newProp = new ArrayList<ArrayList<Proposer>>();
        for (int i = 0; i < listeTotal.size(); i++) {
            double somme = 0;
            int nbr = 1;
            for (int j = 0; j < listeTotal.get(i).size(); j++) {
                somme += (listeTotal.get(i).get(j).getPrixenfant() * nombrePers / nbr);
                listeTotal.get(i).get(j).setTotalprix((listeTotal.get(i).get(j).getPrixenfant() * nombrePers / nbr));
                listeTotal.get(i).get(j).setIngredients(null);
                listeTotal.get(i).get(j).setNbr((nombrePers / nbr));
                nbr = nbr + 1;
                System.out.println(" somme + nom plat + noombre = " + somme + " , " + listeTotal.get(i).get(j).getNomplats() + " , " + listeTotal.get(i).get(j).getNbr());
            }

            if (somme <= budget2 && somme >= budget1) {
                System.out.println(" somme = " + somme);
                newProp.add(listeTotal.get(i));
                somme = 0;
            }
            listeTotal = newProp;
        }
        if (budget2 <= 0) {
            return listeTotal;
        }
        int ln = 7;
        Proposer[] dernierePlanning = this.listePropPlanning(idFamille, null, 1);
        if (dernierePlanning.length == 0) {
            if (listeTotal.size() < 7) {
                ln = listeTotal.size();
            }
            for (int i = 0; i < ln; i++) {
                for (int j = 0; j < listeTotal.get(i).size(); j++) {
                    listeTotal.get(i).get(j).createObject("1", null);
                }
            }
            return listeTotal;
//if(dernierePlanning[i].getIdplat()==)

        } else {
            //if (Date.valueOf(LocalDate.now()).getDate() - dernierePlanning[dernierePlanning.length - 1].getDateproposition().getDate() >= 4) {
                //Uptade eto
                this.modifProp(idFamille, null, 2);//, dernierePlanning[dernierePlanning.length - 1].getDateproposition());
                Proposer[] dernierePlann = this.listePropPlanning(idFamille, null, 2);
                for (int i = 0; i < dernierePlann.length; i++) {
                    for (ArrayList<Proposer> proposer : listeTotal) {
                        for (int j = 0; j < proposer.size(); j++) {
                            if (proposer.get(j).getIdplat() != dernierePlanning[i].getIdplat()) {
                                proposer.get(j).createObject("1", null);
                            }
                        }
                    }
//if(dernierePlanning[i].getIdplat()==)
                }
                return listeTotal;
            //}
         ///   return listeTotal;

        }
        //return listeTotal;
    }

    public Proposer[] listePropPlanning(String idFamille, Connection c, int etat) throws Exception {

        boolean estOuvert = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                estOuvert = true;
            }
            System.out.println("idFamille ==== " + idFamille);
            Proposer crt = new Proposer();
            crt.setNomTable("PROPOSITIONFILLE");
            return (Proposer[]) CGenUtil.rechercher(crt, null, null, c, " and idfamille = '" + idFamille + "' and etat =" + etat);
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

    public void modifProp(String idfamille, Connection c, int etat) throws Exception {
        Statement stmt = null;
        boolean check = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                check = true;
                c.setAutoCommit(false);
                String requeteUpdate = " Update propositionfille set etat = " + etat + " where idfamille = '" + idfamille + "' and ROWID IN ( SELECT ROWID FROM (    SELECT ROWID    FROM propositionfille    WHERE IDFAMILLE = '"+idfamille+"'  ORDER BY DATEPROPOSITION DESC  )  WHERE ROWNUM <= 7)'";
                System.out.println(" REQUETE MODIF == " + requeteUpdate);
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


    /*
    public static ArrayList<ArrayList<Proposer>> generateCombinationPlanningg(ArrayList<ArrayList<Proposer>> typesOfPlats) {
        ArrayList<ArrayList<Proposer>> combinations = new ArrayList<>();
        generatePlanning(typesOfPlats, 0, new ArrayList<>(), combinations, new ArrayList<Proposer>());
        return combinations;
    }

    private static void generatePlanning(ArrayList<ArrayList<Proposer>> typesOfPlats, int index, List<Proposer> currentCombination, ArrayList<ArrayList<Proposer>> combinations, ArrayList<Proposer> usedPlats) {
        System.out.println(" index = " + index);
        if (index == typesOfPlats.size()) {
            combinations.add(new ArrayList<>(currentCombination));
            return;
        }

        List<Proposer> currentTypePlats = typesOfPlats.get(index);

        for (Proposer plat : currentTypePlats) {
            for (int i = 0; i < usedPlats.size(); i++) {
                System.out.println(" plat USEDPLATS +== " + usedPlats.get(i).getNomplats());
            }
            if (!usedPlats.contains(plat)) {
                currentCombination.add(plat);
                usedPlats.add(plat);
                System.out.println("plat = " + plat.getNomplats() + " - id et ordre =  " + plat.getIdtype() + " - " + plat.getOrdre());
                generatePlanning(typesOfPlats, index + 1, currentCombination, combinations, usedPlats);
                currentCombination.remove(currentCombination.size() - 1);
                //usedPlats.remove(plat);
            }
        }
    }

    private static boolean isPlatUsed(Proposer plat, ArrayList<ArrayList<Proposer>> combi) {
        for (ArrayList<Proposer> comb : combi) {
            for (Proposer pl : comb) {
                if (pl.getIdplat() == plat.getIdplat() && pl.getIdtype() == plat.getIdtype()) {

                    return true;
                }
            }
        }
        return false;
    }
     */
    //private
    /*
    public static List<List<Proposer>> genererPropositions(ArrayList<Proposer> plats, List<String> typesChoisis, double budget) {
        List<List<Plat>> propositions = new ArrayList<>();
        Map<String, Integer> typesRestants = new HashMap<>();

// Compter le nombre de plats restants pour chaque type choisi
        for (String type : typesChoisis) {
            typesRestants.put(type, 0);
        }

// Générer les propositions
        for (Proposer plat : plats) {
            if (typesChoisis.contains(plat.getType()) && plat.getPrixParPersonne() <= budget && typesRestants.get(plat.getType()) < 3) {
                List<Plat> proposition = new ArrayList<>();
                proposition.add(plat­);
                propositions.add(pro­position);
                typesRestants.put(pl­at.getType(), typesRestants.get(pl­at.getType()) + 1);
            }
        }

// Ajouter les plats restants pour chaque type choisi
        for (String type : typesChoisis) {
            int platsRestants = 3 - typesRestants.get(ty­pe);
            for (Plat plat : plats) {
                if (plat.getType().equa­ls(type) && plat.getPrixParPerso­nne() <= budget && platsRestants > 0) {
                    propositions.get(pro­positions.size() - 1).add(plat);
                    platsRestants--;
                }
            }
        }

        return propositions;
    }

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
/*
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PropositionGenerator­ {
public static class Plat {
private String nom;
private String type;
private double prixParPersonne;

public Plat(String nom, String type, double prixParPersonne) {
this.nom = nom;
this.type = type;
this.prixParPersonne­ = prixParPersonne;
}

public String getNom() {
return nom;
}

public String getType() {
return type;
}

public double getPrixParPersonne()­ {
return prixParPersonne;
}
}

public static List<List<Plat>> genererPropositions(­List<Plat> plats, List<String> typesChoisis, double budget) {
List<List<Plat>> propositions = new ArrayList<>();
Map<String, Integer> typesRestants = new HashMap<>();

// Compter le nombre de plats restants pour chaque type choisi
for (String type : typesChoisis) {
typesRestants.put(ty­pe, 0);
}

// Générer les propositions
for (Plat plat : plats) {
if (typesChoisis.contai­ns(plat.getType()) && plat.getPrixParPerso­nne() <= budget && typesRestants.get(pl­at.getType()) < 3) {
List<Plat> proposition = new ArrayList<>();
proposition.add(plat­);
propositions.add(pro­position);
typesRestants.put(pl­at.getType(), typesRestants.get(pl­at.getType()) + 1);
}
}

// Ajouter les plats restants pour chaque type choisi
for (String type : typesChoisis) {
int platsRestants = 3 - typesRestants.get(ty­pe);
for (Plat plat : plats) {
if (plat.getType().equa­ls(type) && plat.getPrixParPerso­nne() <= budget && platsRestants > 0) {
propositions.get(pro­positions.size() - 1).add(plat);
platsRestants--;
}
}
}

return propositions;
}

public static void main(String[] args) {
// Exemple d'utilisation
List<Plat> plats = new ArrayList<>();
plats.add(new Plat("Plat 1", "Type 1", 10.0));
plats.add(new Plat("Plat 2", "Type 2", 15.0));
plats.add(new Plat("Plat 3", "Type 1", 12.0));
plats.add(new Plat("Plat 4", "Type 3", 8.0));
plats.add(new Plat("Plat 5", "Type 2", 14.0));
plats.add(new Plat("Plat 6", "Type 1", 11.0));
plats.add(new Plat("Plat 7", "Type 3", 9.0));

List<String> typesChoisis = new ArrayList<>();
typesChoisis.add("Ty­pe 1");
typesChoisis.add("Ty­pe 2");
typesChoisis.add("Ty­pe 3");

double budget = 30.0;

List<List<Plat>> propositions = genererPropositions(­plats, typesChoisis, budget);

// Afficher les propositions
for (int i = 0; i < propositions.size();­ i++) {
System.out.println("­Proposition " + (i + 1) + ":");
for (Plat plat : propositions.get(i))­ {
System.out.println("­- " + plat.getNom() + " (" + plat.getType() + ") - Prix par personne: " + plat.getPrixParPerso­nne());
}
System.out.println()­;
}
}
}*/
