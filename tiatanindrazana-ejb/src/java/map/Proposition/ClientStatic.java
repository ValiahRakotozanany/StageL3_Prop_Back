/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package map.Proposition;

/**
 *
 * @author Valiah Karen
 *//*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import map.Proposition.Token.ClientInfo;
import map.Proposition.Token.TokenException;
import utilitaire.Utilitaire;

/**
 *
 * @author bruel
 */
public class ClientStatic {
    static ClientInfo clientsDatas;
    static boolean aChange;

    public static ClientInfo getClientsDatas() {
        return clientsDatas;
    }

    public static void setClientsDatas(ClientInfo clientsDatas) {
        ClientStatic.clientsDatas = clientsDatas;
    }

    public static boolean isaChange() {
        return aChange;
    }

    public static void setaChange(boolean aChange) {
        ClientStatic.aChange = aChange;
    }
    
    public static void setClientInfo(Famille client, FamilleToken token) throws Exception{
        if(clientsDatas==null){
            clientsDatas = new ClientInfo();
        }
        clientsDatas.setClient(client, token);
        clientsDatas.setTokenUser(token);
    }
    
    public static void removeClientInfo(String token) throws Exception{
        if(clientsDatas==null){
            throw new Exception("Disconnected successfully!");
        } else {
            clientsDatas.removeTokenClient(token);
        }
    }
    
    public static Famille findUserbyToken(String token) throws Exception{
        token = checkValidToken(token);
        return clientsDatas.getClient(token);
    }
    public static FamilleToken findTokenUserbyToken(String token)throws Exception{
        token = checkValidToken(token);
        return clientsDatas.getTokenUser(token);
    }
    
    public static String checkValidToken(String token)throws Exception{
        if(token==null||token.isEmpty()) {
            TokenException tex = new TokenException("No Token found!");
            tex.setEtat(-21);
            throw tex;
        }
        String[]method = Utilitaire.split(token, " ");
        if(method.length!=2 || !method[0].equals("Bearer")){
            TokenException tex = new TokenException("Invalid Authorization!");
            tex.setEtat(-20);
            throw tex;
        }
        return method[1];
    }
}

