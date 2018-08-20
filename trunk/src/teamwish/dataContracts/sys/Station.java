package teamwish.dataContracts.sys;

import javax.xml.bind.annotation.XmlRootElement;
import java.sql.Date;
import java.sql.Timestamp;

@XmlRootElement
public class Station {
	private int id;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	private String name;

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	private String leader;

	public String getLeader() {
		return this.leader;
	}

	public void setLeader(String leader) {
		this.leader = leader;
	}

	private String telephone;

	public String getTelephone() {
		return this.telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	private double centerX;

	public double getCenterX() {
		return this.centerX;
	}

	public void setCenterX(double centerX) {
		this.centerX = centerX;
	}

	private double centerY;

	public double getCenterY() {
		return this.centerY;
	}

	public void setCenterY(double centerY) {
		this.centerY = centerY;
	}

	private int pId;

	public int getPId() {
		return this.pId;
	}

	public void setPId(int pId) {
		this.pId = pId;
	}

	private int zoom;

	public int getZoom() {
		return this.zoom;
	}

	public void setZoom(int zoom) {
		this.zoom = zoom;
	}

	private String code;

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	private String workTime;

	public String getWorkTime() {
		return this.workTime;
	}

	public void setWorkTime(String workTime) {
		this.workTime = workTime;
	}

	private int shiftDays;

	public int getShiftDays() {
		return this.shiftDays;
	}

	public void setShiftDays(int shiftDays) {
		this.shiftDays = shiftDays;
	}

	private Timestamp checkInTime;

	public Timestamp getCheckInTime() {
		return this.checkInTime;
	}

	public void setCheckInTime(Timestamp checkInTime) {
		this.checkInTime = checkInTime;
	}

	private String innerCode;

	public String getInnerCode() {
		return this.innerCode;
	}

	public void setInnerCode(String innerCode) {
		this.innerCode = innerCode;
	}

	private String pyCode;

	public String getPyCode() {
		return this.pyCode;
	}

	public void setPyCode(String pyCode) {
		this.pyCode = pyCode;
	}

	private String wbCode;

	public String getWbCode() {
		return this.wbCode;
	}

	public void setWbCode(String wbCode) {
		this.wbCode = wbCode;
	}

	private String shortName;

	public String getShortName() {
		return this.shortName;
	}

	public void setShortName(String shortName) {
		this.shortName = shortName;
	}

	private Boolean isUse;

	public Boolean getIsUse() {
		return this.isUse;
	}

	public void setIsUse(Boolean isUse) {
		this.isUse = isUse;
	}

	private String sCode;

	public String getSCode() {
		return this.sCode;
	}

	public void setSCode(String sCode) {
		this.sCode = sCode;
	}

	private String radioNo;

	public String getRadioNo() {
		return this.radioNo;
	}

	public void setRadioNo(String radioNo) {
		this.radioNo = radioNo;
	}

	private String caseInfoStationCode;

	public String getCaseInfoStationCode() {
		return this.caseInfoStationCode;
	}

	public void setCaseInfoStationCode(String caseInfoStationCode) {
		this.caseInfoStationCode = caseInfoStationCode;
	}

	private String serviceStationCode;

	public String getServiceStationCode() {
		return this.serviceStationCode;
	}

	public void setServiceStationCode(String serviceStationCode) {
		this.serviceStationCode = serviceStationCode;
	}

	private Timestamp updateDt;

	public Timestamp getUpdateDt() {
		return this.updateDt;
	}

	public void setUpdateDt(Timestamp updateDt) {
		this.updateDt = updateDt;
	}

	private String groupIds;

	public String getGroupIds() {
		return this.groupIds;
	}

	public void setGroupIds(String groupIds) {
		this.groupIds = groupIds;
	}

	private String type = "";

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}
	 private Boolean open;
	 public Boolean getOpen(){
	  return this.open;
	 }
	 
	 public void setOpen( Boolean open){
	  this.open = open;
	 }
	 private String icon;
	 public String getIcon(){
	  return this.icon;
	 }
	 
	 public void setIcon( String icon){
	  this.icon = icon;
	 }

}
