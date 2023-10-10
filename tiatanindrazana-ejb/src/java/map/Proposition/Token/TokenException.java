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
public class TokenException extends Exception{
    int isEmpty;
    int loginError;
    int passwordError;
    int etat;
    
    public TokenException(){
        super();
    }
    
    public TokenException(String message){
        super(message);
    }

    public int getIsEmpty() {
        return isEmpty;
    }

    public void setIsEmpty(int isEmpty) {
        this.isEmpty = isEmpty;
    }

    public int getLoginError() {
        return loginError;
    }

    public void setLoginError(int loginError) {
        this.loginError = loginError;
    }

    public int getPasswordError() {
        return passwordError;
    }

    public void setPasswordError(int passwordError) {
        this.passwordError = passwordError;
    }

    public int getEtat() {
        return etat;
    }

    public void setEtat(int etat) {
        this.etat = etat;
    }
    
    
}

