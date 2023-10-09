package antenne;

public class DistrictLibComplet extends District{

    private String regiondescelib;
    private String regionvallib;

    public DistrictLibComplet()throws Exception{
        this.setNomTable("districtlibcomplet");
    }

    public String getRegiondescelib() {
        return this.regiondescelib;
    }

    public void setRegiondescelib(String regiondescelib) {
        this.regiondescelib = regiondescelib;
    }

    public String getRegionvallib() {
        return this.regionvallib;
    }

    public void setRegionvallib(String regionvallib) {
        this.regionvallib = regionvallib;
    }
    
    public String getValColLibelle(){
        return this.getNom();
    }


    

}
