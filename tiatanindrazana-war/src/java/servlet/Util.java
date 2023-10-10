/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import com.google.gson.GsonBuilder;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.BufferedReader;
import java.io.IOException;

/**
 *
 * @author Valiah Karen
 */
public class Util {
     public static Gson getGson(){
        return new GsonBuilder()
                    .excludeFieldsWithoutExposeAnnotation()
                    .setDateFormat("yyyy-MM-dd HH:mm:ss.SSS")
                    .create();
    }
    
    public static Gson getGsonAllFields(){
        return new GsonBuilder()
                    .setDateFormat("yyyy-MM-dd HH:mm:ss.SSS")
                    .create();
    }
    
    public static String getJsonBody(BufferedReader reader) throws IOException{
        String json = "";
        String line;
        while((line = reader.readLine()) != null){
            json += line;
            json += System.lineSeparator();
        }
        return json;
    }
    
    public static JsonObject parseJSON(String json){
        JsonElement elm = new JsonParser().parse(json);
        if(elm.isJsonNull()){
            return null;
        }
        return elm.getAsJsonObject();
    }
}
