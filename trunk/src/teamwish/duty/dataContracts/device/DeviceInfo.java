package teamwish.duty.dataContracts.device;

import javax.xml.bind.annotation.XmlRootElement;
import java.sql.Date;
import java.sql.Timestamp;

@XmlRootElement
public class DeviceInfo {
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

	private String type;

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	private int videoType;

	public int getVideoType() {
		return this.videoType;
	}

	public void setVideoType(int videoType) {
		this.videoType = videoType;
	}

	private int stationId;

	public int getStationId() {
		return this.stationId;
	}

	public void setStationId(int stationId) {
		this.stationId = stationId;
	}

	private String param;

	public String getParam() {
		return this.param;
	}

	public void setParam(String param) {
		this.param = param;
	}

	private String code;

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	private String state;

	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	private int regionId;

	public int getRegionId() {
		return this.regionId;
	}

	public void setRegionId(int regionId) {
		this.regionId = regionId;
	}

	private int shiftType;

	public int getShiftType() {
		return this.shiftType;
	}

	public void setShiftType(int shiftType) {
		this.shiftType = shiftType;
	}

	private double longitude;

	public double getLongitude() {
		return this.longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	private double latitude;

	public double getLatitude() {
		return this.latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	private String address;

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	private Timestamp lastPosTime;

	public Timestamp getLastPosTime() {
		return this.lastPosTime;
	}

	public void setLastPosTime(Timestamp lastPosTime) {
		this.lastPosTime = lastPosTime;
	}

	private int serviceId;

	public int getServiceId() {
		return this.serviceId;
	}

	public void setServiceId(int serviceId) {
		this.serviceId = serviceId;
	}

	private String staff_code;

	public String getStaff_code() {
		return this.staff_code;
	}

	public void setStaff_code(String staff_code) {
		this.staff_code = staff_code;
	}

	private String remark;

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	private Boolean isUse;

	public Boolean getIsUse() {
		return this.isUse;
	}

	public void setIsUse(Boolean isUse) {
		this.isUse = isUse;
	}

	private String userName;

	public String getUserName() {
		return this.userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	private int userId;

	public int getUserId() {
		return this.userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	private int bindType;

	public int getBindType() {
		return this.bindType;
	}

	public void setBindType(int bindType) {
		this.bindType = bindType;
	}

	private String deviceState;

	public String getDeviceState() {
		return this.deviceState;
	}

	public void setDeviceState(String deviceState) {
		this.deviceState = deviceState;
	}

	private int deviceLogId;

	public int getDeviceLogId() {
		return this.deviceLogId;
	}

	public void setDeviceLogId(int deviceLogId) {
		this.deviceLogId = deviceLogId;
	}

	private Timestamp updateDt;

	public Timestamp getUpdateDt() {
		return this.updateDt;
	}

	public void setUpdateDt(Timestamp updateDt) {
		this.updateDt = updateDt;
	}

	private double prevX;

	public double getPrevX() {
		return this.prevX;
	}

	public void setPrevX(double prevX) {
		this.prevX = prevX;
	}

	private double prevY;

	public double getPrevY() {
		return this.prevY;
	}

	public void setPrevY(double prevY) {
		this.prevY = prevY;
	}

	private Timestamp prePosTime;

	public Timestamp getPrePosTime() {
		return this.prePosTime;
	}

	public void setPrePosTime(Timestamp prePosTime) {
		this.prePosTime = prePosTime;
	}

	private int prior;

	public int getPrior() {
		return this.prior;
	}

	public void setPrior(int prior) {
		this.prior = prior;
	}

	private String manufacturer;

	public String getManufacturer() {
		return this.manufacturer;
	}

	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}

	private String assembleType;

	public String getAssembleType() {
		return this.assembleType;
	}

	public void setAssembleType(String assembleType) {
		this.assembleType = assembleType;
	}

	private String assembleCode;

	public String getAssembleCode() {
		return this.assembleCode;
	}

	public void setAssembleCode(String assembleCode) {
		this.assembleCode = assembleCode;
	}

	private String sCode;

	public String getSCode() {
		return this.sCode;
	}

	public void setSCode(String sCode) {
		this.sCode = sCode;
	}
}
