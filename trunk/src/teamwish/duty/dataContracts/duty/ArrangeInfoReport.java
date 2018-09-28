package teamwish.duty.dataContracts.duty;

import java.sql.Date;
import java.sql.Timestamp;

import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement
public class ArrangeInfoReport {
    private int stationId = 0;
    private String stationName;
    private int staffId = 0;
    private int staffStationId;
    private String staffStationName;
    private String staffState = "";
	private String staffName = "";
    private String staffPic = "";
    private String staffCode = "";
    private String staffPhone = "";
    private String post = "";
    private String shiftInfos = "";
    private String shiftState = "";
    private String lastPosTime = "";
    private String deviceInfos = "";
    private String workDt = "";
    private String fromTime;
    private String toTime = "";
    private String state = "";
    private String shiftType = "";
    private String shiftName = "";
    private String idPath;
    private String namePath = "";
    private int orderIndex = 0;
    private int position = 0;
    private String positionName ="";


	public int getStationId() {
        return this.stationId;
    }

    public void setStationId(int stationId) {
        this.stationId = stationId;
    }

    public String getStationName() {
        return this.stationName;
    }

    public void setStationName(String stationName) {
        this.stationName = stationName;
    }

    public int getStaffId() {
        return this.staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public int getStaffStationId() {
        return this.staffStationId;
    }

    public void setStaffStationId(int staffStationId) {
        this.staffStationId = staffStationId;
    }

    public String getStaffStationName() {
        return this.staffStationName;
    }

    public void setStaffStationName(String staffStationName) {
        this.staffStationName = staffStationName;
    }

    public String getStaffName() {
        return this.staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public String getStaffPic() {
        return this.staffPic;
    }

    public void setStaffPic(String staffPic) {
        this.staffPic = staffPic;
    }

    public String getStaffCode() {
        return this.staffCode;
    }

    public void setStaffCode(String staffCode) {
        this.staffCode = staffCode;
    }

    public String getStaffPhone() {
        return this.staffPhone;
    }

    public void setStaffPhone(String staffPhone) {
        this.staffPhone = staffPhone;
    }

    public String getPost() {
        return this.post;
    }

    public void setPost(String post) {
        this.post = post;
    }

    public String getShiftInfos() {
        return this.shiftInfos;
    }

    public void setShiftInfos(String shiftInfos) {
        this.shiftInfos = shiftInfos;
    }

    public String getShiftState() {
        return this.shiftState;
    }

    public void setShiftState(String shiftState) {
        this.shiftState = shiftState;
    }

    public String getLastPosTime() {
        return this.lastPosTime;
    }

    public void setLastPosTime(String lastPosTime) {
        this.lastPosTime = lastPosTime;
    }

    public String getDeviceInfos() {
        return this.deviceInfos;
    }

    public void setDeviceInfos(String deviceInfos) {
        this.deviceInfos = deviceInfos;
    }

    public String getWorkDt() {
        return this.workDt;
    }

    public void setWorkDt(String workDt) {
        this.workDt = workDt;
    }

    public String getFromTime() {
        return this.fromTime;
    }

    public void setFromTime(String fromTime) {
        this.fromTime = fromTime;
    }

    public String getToTime() {
        return this.toTime;
    }

    public void setToTime(String toTime) {
        this.toTime = toTime;
    }

    public String getState() {
        return this.state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getShiftType() {
        return this.shiftType;
    }

    public void setShiftType(String shiftType) {
        this.shiftType = shiftType;
    }

    public String getShiftName() {
        return this.shiftName;
    }

    public void setShiftName(String shiftName) {
        this.shiftName = shiftName;
    }

    public String getIdPath() {
        return this.idPath;
    }

    public void setIdPath(String idPath) {
        this.idPath = idPath;
    }

    public String getNamePath() {
        return this.namePath;
    }

    public void setNamePath(String namePath) {
        this.namePath = namePath;
    }
       
	 public int getOrderIndex(){
	  return this.orderIndex;
	 }
	 
	 public void setOrderIndex(int orderIndex){
	  this.orderIndex = orderIndex;
	 }
	 
	 public int getPosition() {
		return position;
	}

	public void setPosition(int position) {
		this.position = position;
	}

	public String getPositionName() {
		return positionName;
	}

	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}	
	
	public String getStaffState() {
		return staffState;
	}

	public void setStaffState(String staffState) {
		this.staffState = staffState;
	}
}
