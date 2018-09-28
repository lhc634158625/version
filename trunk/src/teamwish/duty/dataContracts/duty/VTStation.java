package teamwish.duty.dataContracts.duty;

import java.sql.Date;
import java.sql.Timestamp;

import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement
public class VTStation {
    private int id = 0;
    private int pid = 0;
    private String path = "";
    private int tLevel =1;
    
    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    public int getPId() {
        return this.id;
    }

    public void setPId(int pid) {
        this.pid = pid;
    }

    public String getPath() {
        return this.path;
    }

    public void setPath(String path) {
        this.path = path;
    }
    
    public int getTLevel() {
        return this.tLevel;
    }

    public void setTLevel(int tLevel) {
        this.tLevel = tLevel;
    }
}
