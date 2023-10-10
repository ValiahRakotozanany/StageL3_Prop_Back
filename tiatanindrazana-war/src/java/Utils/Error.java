package Utils;
import com.google.gson.annotations.Expose;

public class Error {
    @Expose
    private int etat = 1;
    @Expose
    private String source = "";
    @Expose
    private String titre = "";
    @Expose
    private String message = "";
    
    public Error(){}
    
    public Error(int etat, String source, String titre, String message) {
        this.setEtat(etat);
        this.setSource(source);
        this.setTitre(titre);
        this.setMessage(message);
    }
    
    public Error(int etat, String titre, String message) {
        this.setEtat(etat);
        this.setTitre(titre);
        this.setMessage(message);
    }

    public int getEtat() {
        return etat;
    }

    public String getSource() {
        return source;
    }

    public String getTitre() {
        return titre;
    }

    public String getMessage() {
        return message;
    }

    public void setEtat(int etat) {
        this.etat = etat;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    @Override
    public String toString() {
        return "Error{" + "etat=" + etat + ", source=" + source + ", titre=" + titre + ", message=" + message + '}';
    }
    
    
   
}