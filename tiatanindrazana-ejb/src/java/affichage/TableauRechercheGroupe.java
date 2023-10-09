/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package affichage;

import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.EtiquetteLigneCol;
import bean.ValeurCroises;
import bean.ValeurEtiquette;
import java.util.ArrayList;
import utilitaire.Utilitaire;
import java.util.HashMap;

/**
 * Objet representant une table avec les resultats de la recherche pour une recherche croisée.
 * <p>
 * Pour le génerer il faut initialiser un <code>PageRechercheGroupe</code>,
 * et pour génerer un tableau croisé utiliser:
 * <pre>
 *  pr.creerObjetPageCroise("facture/factureclient-fiche.jsp");
 * </pre>
 * </p>
 * Pour le génerer il faut initialiser une <code>PageRechercheGroupe</code>
 * @author BICI
 */
public class TableauRechercheGroupe extends TableauRecherche {

    ArrayList<String> ligne=new ArrayList();
    ArrayList<String> colonne=new ArrayList();
    HashMap<String,ValeurCroises> valeur=new HashMap<String,ValeurCroises>();
    HashMap<String,ValeurCroises> somme=new HashMap<String,ValeurCroises>();
    String[] attrLig;
    String[] attrColonne;
    public void setAttrLig(String[] a)
    {
        attrLig=a;
    }
    public void setAttrColonne(String[] c)
    {
        attrColonne=c;
    }

    /**
     * Séparer les lignes des colonnes pour être utilisé dans le tableau
     * <p>
     * Si les lignes sont dans les colonnes on les enlève.
     * </p>
     * @param lign liste des lignes
     * @param colonne liste des colonnes
     */
    public void setAttrLigneColonne(String[] lign,String[]colonne)
    {
        ArrayList<String> ligne=new ArrayList<String>();
        for(int i=0;i<lign.length;i++)
        {
            
            if(Utilitaire.estIlDedans(lign[i],colonne)==-1)
            {
                ligne.add(lign[i]);
            }
        }
        this.setAttrLig(getAttr(ligne));
        this.setAttrColonne(colonne);
    }

    /**
     * Spécifier les colonnes et les lignes de la table
     * <p>
     *  Les lignes sont les valeurs en indice pair
     *  et les colonnes sont les valeurs en indice impair
     * </p>
     * @param c valeur pour donner à la ligne ou au colonne de type String[]
     */
    public void setAttrLigneColonne(String[] c)
    {
        ArrayList<String> col=new ArrayList<String>();
        ArrayList<String> ligne=new ArrayList<String>();
        for(int i=0;i<c.length;i++)
        {
            if(i%2==0)
            {
                ligne.add(c[i]);
            }
            else
            {
                col.add(c[i]);
            }
        }
        this.setAttrLig(getAttr(ligne));
        this.setAttrColonne(getAttr(col));
    }

    /**
     * Convertir ArrayList en une simple tableau 
     * @param c liste
     * @return
     */
    public static String[] getAttr(ArrayList<String>c)
    {
        String [] attr=new String[c.size()];
        c.toArray(attr);
        return attr;
    }

    /**
     * Constructeur avec les paramètres ci-dessous
     * @param liste liste des resultats
     * @param attrLigneC listes des attributs de colonnes
     * @param attrCentre liste des attributs de sommes
     * @param lien base de lien de redirection pour les valeurs
     * @throws Exception
     */
    public TableauRechercheGroupe(ClassMAPTable[] liste, String[] attrLigneC,String[] attrCentre,String lien) throws Exception
    {
        this.setAttrLigneColonne(attrLigneC);
        transformer(liste,attrCentre,lien);
        super.setValeurEtiquette(getValeur());
    }

    /**
     * Fonction pour un simple affichage 
     * @param aAfficher les choses à afficher
     */
    public void afficher(String[] aAfficher)
    {
        for(int i=0;i<aAfficher.length;i++)
        {
            System.out.println("a Afficher "+aAfficher[i]);
        }
    }
    
    /**
     * 
     * @param liste liste des objets
     * @param attrLigne liste des attributs en ligne
     * @param attrCol liste des attributs en colonne
     * @param attrCentre liste des attributs à sommer
     * @param lien
     * @throws Exception
     */
    public TableauRechercheGroupe(ClassMAPTable[] liste, String[] attrLigne,String[]attrCol,String[] attrCentre,String lien) throws Exception
    {
        this.setAttrLigneColonne(attrLigne,attrCol);
        transformer(liste,attrCentre,lien);
        super.setValeurEtiquette(getValeur());
    }

    /**
     *  Transformer les listes de resultat en liste de valeur croisées
     * <p>
     *  On va avoir un hashmap avec comme clé "colonne::ligne"
     * </p>
     * @param liste Classe de mapping à la base de données
     * @param attrCentre liste des lignes de somme
     * @param lie lien de base pour la rédirection
     * @throws Exception
     */
    public void transformer(ClassMAPTable[] liste,String[] attrCentre,String lie) throws Exception
    {
        if(liste.length==0) return;
        String lien=lie;
        for(int i=0; i<liste.length;i++)
        {   
            double[] valeurCentre=new double[attrCentre.length];
            for(int iCentre=0;iCentre<attrCentre.length;iCentre++)
                valeurCentre[iCentre]=(double)CGenUtil.getValeurFieldByMethod(liste[i], attrCentre[iCentre]);
        
            String lig=transformer(liste[i], this.attrLig);
            String col=transformer(liste[i],this.attrColonne);
            if(estDejaDansListe(ligne, lig)==false)
            {
                ligne.add(lig);
            }            
            
            if(estDejaDansListe(colonne, col)==false)
            {
                colonne.add(col);
            }
            ValeurCroises valCroise=new ValeurCroises(valeurCentre,lien+makeLien(lig,col));
            valeur.put(lig+"::"+col, valCroise);
            getSomme(lig,valeurCentre,lien+makeLien(lig,""));
            getSomme(col,valeurCentre,lien+makeLien("",col));   
        }
    }

    /**
     * Cette fonction permet de calculer les valeurs d'une valeur croisé
     * <p>
     *  Si une valeur croisée avec la clé donnée existe on va sommer aux nouvelles valeurs 
     * </p>
     * @param ligCol clé de la valeur croisé
     * @param valeur liste des sommes du valeur croisé
     * @param lien lien pour la redirection de la valeur croisé
     */
    public  void getSomme(String ligCol,double[] valeur,String lien)
    {
        ValeurCroises efaAo=somme.get(ligCol);
        if(efaAo!=null)
        {
            double[] nouvelleVal=new double[valeur.length];
            for(int i=0;i<valeur.length;i++)
            {
                nouvelleVal[i]=efaAo.getListeVal()[i]+valeur[i];
            }
            efaAo.setListeVal(nouvelleVal);
        }
        else
        {
            somme.put(ligCol, new ValeurCroises(valeur,lien));
        }
        
    }

    /**
     * Définir la valeur d'une valeur croisée
     * <p>
     *  Si pour une clé donnée a déjà une valeur croisée on va sommer la valeur à ajouter
     * à la valeur
     * </p>
     * @param ligCol chaine de caractère 
     * @param valeur un nombre à virgule flottante 
     * @param lien chaine de caractère 
     */
    public  void getSomme(String ligCol,double valeur,String lien)
    {
        ValeurCroises efaAo=somme.get(ligCol);
        if(efaAo!=null)
        {
            
            efaAo.setValeur(efaAo.getValeur()+valeur);
        }
        else
        {
            somme.put(ligCol, new ValeurCroises(valeur,lien));
        }
    }

    /**
     * Sert à formatter un lien pour avoir les paramètres de lignes et de colonnes
     * pour rédirection depuis le chiffre
     * @param ligne valeur sur la ligne
     * @param colonne valeur sur la colonne
     * @return paramètre GET formatté URL avec la valeur de la ligne et de la colonne concernée
     */
    public String makeLien(String ligne,String colonne)
    {
        String[] listeL=getAttrSansSep(ligne);
        
        String[] listeC=getAttrSansSep(colonne);
        String retour="";
        if(ligne!=null&&ligne.compareToIgnoreCase("")!=0)
        {
            for(int l=0;l<attrLig.length;l++)
            {
                retour=retour+"&"+attrLig[l]+"="+ValeurEtiquette.formatter(listeL[l]);
            }
        }
        if(colonne!=null&&colonne.compareToIgnoreCase("")!=0)
        {
            for(int c=0;c<attrColonne.length;c++)
            {
                retour=retour+"&"+attrColonne[c]+"="+ValeurEtiquette.formatter(listeC[c]);
            }
        }
        return retour;
    }

    /**
     * Initialiser les valeurs d'etiquette à vide
     * @param retour un tableau bidimensionnel (ValeurEtiquette[][]) 
     */
    public static void init(ValeurEtiquette[][] retour)
    {
        for(int i=0;i<retour.length;i++)
        {
            for(int j=0;j<retour[i].length;j++)
            {
                retour[i][j]=new ValeurEtiquette("","");
            }
        }
    }
    /**
     * Transformer les valeurs croisées en liste de valeurs etiquette 
     * de taille niveau 1 le nombre de lignes
     * et de taille niveau 2 le nombre de colonnes
     * @return valeurs croisées en liste de valeurs etiquettes
     * @throws Exception
     */
    public ValeurEtiquette[][] getValeur() throws Exception
    {
        int nbLigne=attrLig.length;
        int nbColonne=attrColonne.length;
        ValeurEtiquette[][] retour=new ValeurEtiquette[ligne.size()+nbColonne+1][colonne.size()+nbLigne+1];
        init(retour);
        for(int i=attrColonne.length;i<ligne.size()+attrColonne.length;i++) // Remplir gauche par ligne
        {
            String[] listeLigne=getAttrSansSep(ligne.get(i-attrColonne.length));
            for(int c=0;c<listeLigne.length;c++)
            {
                retour[i][c]=new ValeurEtiquette(listeLigne[c],"");
            }
        }
        
        for(int i=attrLig.length;i<colonne.size()+attrLig.length;i++) // Remplir haut par colonne
        {
            String[] listeColonne=getAttrSansSep(colonne.get(i-attrLig.length));
            for(int c=0;c<listeColonne.length;c++)
            {
                
                retour[c][i]=new ValeurEtiquette(listeColonne[c],"");
            }
        }
            
       
        for(int iLigne=nbColonne;iLigne<ligne.size()+nbColonne+1;iLigne++)
        {
            for(int iColonne=nbLigne;iColonne<colonne.size()+nbLigne+1;iColonne++)
            {
                ValeurCroises val=null;
                if(iLigne==ligne.size()+nbColonne&&(iColonne<colonne.size()+nbLigne)) val=somme.get(colonne.get(iColonne-nbLigne));
                else if(iColonne==colonne.size()+nbLigne&&(iLigne<ligne.size()+nbColonne)) val=somme.get(ligne.get(iLigne-nbColonne));
                else if((iLigne<ligne.size()+nbColonne)&&(iColonne<colonne.size()+nbLigne))val=valeur.get(ligne.get(iLigne-nbColonne)+"::"+colonne.get(iColonne-nbLigne));
                if(val!=null)
                {
                    retour[iLigne][iColonne]=new ValeurEtiquette(val);
                }
                
            }
        }
        return retour;
    }

    /**
     * Convertir une chaine de charactère representant les valeurs de plusieurs attributs en tableau
     * @param valeur valeur de plusieurs attributs séparés par ..
     * @return un tableau de chaînes de caractères (String[])
     */
    public static String[] getAttrSansSep(String valeur)
    {
        String[] retour=valeur.split("\\.\\.");
        if(retour.length<=1)
        {
            String[] ret={valeur,""};
            return ret;
        }
        return retour;
    }

    /**
     * Génerer une  représentation de l'objet selon une liste d'attrubut
     * @param e objet à extraire la valeur
     * @param attr  nom de l'attribut
     * @return valeurs des attributs séparés par ..
     * @throws Exception
     */
    public static String transformer(ClassMAPTable e, String[] attr) throws Exception
    {
        String retour="";
        
        for(int iLigne=0;iLigne<attr.length;iLigne++)
        {
            String valeurLigne="";
            Object o=CGenUtil.getValeurFieldByMethod(e, attr[iLigne]);
            
            if(o!=null)
            {
                valeurLigne=o.toString();
            }
            retour=retour+valeurLigne;
            if(iLigne<attr.length-1&&valeurLigne.compareToIgnoreCase("")!=0)
            {
                retour=retour+"..";
            }
        }
        return retour;
        
    }
    /**
     * Fonction pour verifier si la valeur se trouve dans liste
     * @param liste de type ArrayList<String>
     * @param valeur de type String 
     * @return true or false
     * @throws Exception
     */
    public static boolean estDejaDansListe(ArrayList<String> liste,String valeur) throws Exception
    {
        for(String val:liste)
        {
            if(val.compareToIgnoreCase(valeur)==0) return true;
        }
        return false;
    }

    /**
     * @deprecated n'est utilisé nul part
     * Permet de voir si l'etiquette existe dejà 
     * @param liste
     * @param valeur
     * @return
     * @throws Exception
     */
    public boolean estDejaDansEtiquette(ArrayList<EtiquetteLigneCol> liste,EtiquetteLigneCol valeur) throws Exception
    {
        for(EtiquetteLigneCol lc:liste)
        {
            return lc.comparer(valeur);
        }
        return false;
    }

    /**
     * 
     * @return proportion des colonnes du tableau en pourcentage
     */
    public int[] getPropEntet() {

        int[] ret = new int[colonne.size()+attrLig.length+1];
        for (int i = 0; i < ret.length; i++) {
            ret[i] = 100 / ret.length;
        }
        return ret;

        
    }
    public void makeHtml() throws Exception {
        if (getValeurEtiquette() == null || getValeurEtiquette().length == 0) {
            return;
        }
        String temp = "";
        String tempcsv = "";
        String tempxml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?> \r\n <tableau>";
        temp += "<div class=\"row\">";
        temp += "<div class=\"row col-md-12\">";
        temp += "<div class=\"box\">";
        temp += "<div class=\"box-header\">";
        temp += "<h3 class=\"box-title\" align=\"center\">" + getTitre() + "</h3>";
        temp += "</div>";
        temp += "<div class=\"box-body table-responsive no-padding\">";
        temp += "<div id=\"selectnonee\">";
        temp += "<table width=\"" + getTailleTableau() + "\" border=\"0\" align=\"center\" cellpadding=\"3\" cellspacing=\"3\" class=\"table table-hover table-bordered\">";
        int nombreLigne = 0, nombreColonne = 0;
        nombreLigne = getValeurEtiquette().length;

        
        nombreColonne = getValeurEtiquette()[0].length;
        
        temp += "<tbody>";
        for (int i = 0; i < nombreLigne; i++) 
        {

            temp += "<tr>";
            tempxml += "<row>";
            int j = 0, l = 0;
            for (j = 0; j < nombreColonne; j++) 
            {  
                String lien="";
                String apresLien="";
                if(getValeurEtiquette()[i][j].getLien()!=null&&getValeurEtiquette()[i][j].getLien().compareTo("")!=0)
                {
                    lien="<a href='"+getValeurEtiquette()[i][j].getLien() +"'>";
                    apresLien="</a>";
                }
                temp += "<td width=\"" + getPropEntet()[j] + "%\" align=\"" + getValeurEtiquette()[i][j].getAlign() + "\" >" + lien + Utilitaire.champNull(getValeurEtiquette()[i][j].getValeur()) + apresLien + "</td>";
               
                tempcsv += Utilitaire.verifNumerique(getValeurEtiquette()[i][j].getValeur());
                //tempxml += "<" + getLibelleAffiche()[j] + ">" + Utilitaire.verifNumerique(getValeurEtiquette()[i][j].getValeur()) + "</" + getLibelleAffiche()[j] + ">\r\n";
                if (j != nombreColonne - 1) {
                    tempcsv += ";";
                }
            }
            temp += "</tr>";
            tempcsv += "\r\n";
            tempxml += "</row>\r\n";
        }
        temp += "</tbody>";
        tempxml += "</tableau>\r\n";
        temp += "</table>";
        temp += "</div>";
        temp += "</div>";
        temp += "</div>";
        temp += "</div>";
        temp += "</div>";
        setHtml(temp);
        setExpcsv(tempcsv);
        setExpxml(tempxml);
    }
}
