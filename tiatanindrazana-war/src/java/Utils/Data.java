package Utils;
import bean.ClassMAPTable;
import com.google.gson.annotations.Expose;
public class Data {
    @Expose
    private ClassMAPTable[] data;
    @Expose
    private String token;
    @Expose
    private Error error;

    @Expose
    private String message;

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
    
    
    public Data(ClassMAPTable[] data ,Error error) {
        this.setData(data);
        this.setToken("");
        this.setError(error);
    }
    public Data(String d){
        this.setMessage(d);
    }

    public ClassMAPTable[] getData() {
        return data;
    }

    public void setData(ClassMAPTable[] data) {
        this.data = data;
    }
    
    public void setToken(String token){
        this.token = token;
    }
    
    public String getToken(){
        return this.token;
    }

    public void setError(Error error) {
        this.error = error;
    }

    public Error getError() {
        return error;
    }
    
    
    
}