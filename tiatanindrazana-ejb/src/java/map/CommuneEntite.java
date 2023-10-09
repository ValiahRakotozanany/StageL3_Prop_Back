package map;

public class CommuneEntite extends CommuneLibComplet{
    private String typeentite;
    private int effectif;
    public CommuneEntite() throws Exception {
//        this.setNomTable("v_commune_entite_lib_complet");{
    }

    public String getTypeentite() {
        return typeentite;
    }

    public void setTypeentite(String typeentite) {
        this.typeentite = typeentite;
    }

    public int getEffectif() {
        return effectif;
    }

    public void setEffectif(int effectif) {
        this.effectif = effectif;
    }
}
