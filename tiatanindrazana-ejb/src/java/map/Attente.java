/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package map;
import bean.TypeObjet;
import java.sql.Connection;

/**
 *
 * @author drana
 */
public class Attente extends TypeObjet{
    public Attente()
    {
        this.setNomTable("attente");
    }
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("ATT", "get_seq_attente");
        setId(makePK(c));
    }
}

