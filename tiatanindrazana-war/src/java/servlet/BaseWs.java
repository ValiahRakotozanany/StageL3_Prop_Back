/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import com.google.gson.Gson;
import javax.servlet.http.HttpServlet;

/**
 *
 * @author Valiah Karen
 */
public class BaseWs extends HttpServlet {
      Gson gsonReceive = Util.getGsonAllFields();
    Gson gsonSend = Util.getGson();
    String contentType = "application/json;charset=UTF-8";    
}
