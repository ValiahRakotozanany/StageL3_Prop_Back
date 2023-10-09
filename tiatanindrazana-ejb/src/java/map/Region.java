package map;

import java.sql.Connection;
import bean.*;

public class Region extends TypeObjet{

    public Region(){
        this.setNomTable("region");
    }
   @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("REG", "getseqregion");
        this.setId(makePK(c));
    }

    @Override
    public ClassMAPTable createObject(String iduser, Connection con) throws Exception {
        this.setDesce(this.getVal());
        return super.createObject(iduser,con);
    }
    
}
