/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package map.Proposition.Token;

/**
 *
 * @author Valiah Karen
 */
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import map.Proposition.Famille;
import map.Proposition.FamilleToken;

/**
 *
 * @author bruel
 */
public class ClientInfo {
    private ArrayList<FamilleToken> tokenUsers = new ArrayList<>();
    private HashMap<FamilleToken, Famille> clientInfo = new HashMap<>();

    public ArrayList<FamilleToken> getTokenUsers() {
        return tokenUsers;
    }

    public void setTokenUsers(ArrayList<FamilleToken> tokenUsers) {
        this.tokenUsers = tokenUsers;
    }

    public HashMap<FamilleToken, Famille> getClientInfo() {
        return clientInfo;
    }

    public void setClientInfo(HashMap<FamilleToken, Famille> clientInfo) {
        this.clientInfo = clientInfo;
    }
    
    public Famille getClient(String token) throws Exception{
        for(Map.Entry client : clientInfo.entrySet()){
            if(((FamilleToken)client.getKey()).getToken().equals(token)) {
                long now = System.currentTimeMillis();
                long dateexp = ((FamilleToken)client.getKey()).getDateexp().getTime();
                 if(now>dateexp){
                    TokenException tex = new TokenException("Session expired!");
                    tex.setEtat(-22);
                    throw tex;
                 }
                return (Famille)client.getValue();
            }
        }
        TokenException tex = new TokenException("Veuillez vous reconnecter!");
        tex.setEtat(-23);
        throw tex;
    }
    
    public FamilleToken getTokenUser(String token){
        for(FamilleToken jtc: tokenUsers){
            if(jtc.getToken().compareTo(token)==0){
                return jtc;
            }
        }
        return null;
    }
    
    public void setClient(Famille c, FamilleToken t){
        for(Map.Entry client : clientInfo.entrySet()){
            if(((Famille)client.getValue()).getId().equals(c.getId())){
                clientInfo.remove(client);
                break;
            }
        }
        clientInfo.put(t, c);
    }
    
    public void setTokenUser(FamilleToken tokenUser){
        boolean isnew = false;
        
        for(int i=0; i<tokenUsers.size(); i++){
            if(tokenUsers.get(i).getId().equals(tokenUser.getId())){
                tokenUsers.add(i, tokenUser);
                isnew = true;
                break;
            }
        }
        if(!isnew) tokenUsers.add(tokenUser);
    }
    
    public void removeTokenClient(FamilleToken jtc){
        clientInfo.remove(jtc);
    }
    
    public void removeTokenClient(String token){
        for(Map.Entry client : clientInfo.entrySet()){
            if(((FamilleToken)client.getKey()).getToken().equals(token)){
                clientInfo.remove(client.getKey());
                break;
            }
        }
    }
}

