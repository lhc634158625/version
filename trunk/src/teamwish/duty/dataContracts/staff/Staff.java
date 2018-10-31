package teamwish.duty.dataContracts.staff;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import teamwish.duty.dataContracts.device.DeviceInfo;
import teamwish.duty.dataContracts.point.PointInfoDevice;

import java.sql.Date;
import java.sql.Timestamp;

import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement
@ApiModel(description = "警员信息")
public class Staff {
    private int id;
    private String name;
    private String gender;
    private String state;
    private Double longitude;
    private Double latitude;
    private Integer stationId;
    private String stationName;
    private String telephone;
    private Integer position;
    private String positionName;
    private Integer shiftType;
    private Integer regionId;
    private String code = "";
    private String pyCode = "";
    private String address = "";
    private Integer timeType;
    private Integer serviceId;
    private String lastPosTime;
    private Boolean isDel;
    private String idCode;
    private String leaderPost = "";
    private String nonLeaderPost = "";
    private String posType;
    private String shiftState;
    private String updateDt;
    @ApiModelProperty(value = "当前勤务")
    private String shiftInfos = "";
    @ApiModelProperty(value = "设备")
    private java.util.ArrayList<DeviceInfo> deviceInfos;
    @ApiModelProperty(value = "设备")
    private String deviceInfosStr = "";
    @ApiModelProperty(value = "照片")
    private String pic = "";

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return this.gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getState() {
        return this.state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public Double getLongitude() {
        return this.longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public Double getLatitude() {
        return this.latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Integer getStationId() {
        return this.stationId;
    }

    public void setStationId(Integer stationId) {
        this.stationId = stationId;
    }

    public String getStationName() {
        return this.stationName;
    }

    public void setStationName(String stationName) {
        this.stationName = stationName;
    }

    public String getTelephone() {
        return this.telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public Integer getPosition() {
        return this.position;
    }

    public void setPosition(Integer position) {
        this.position = position;
    }

    public String getPositionName() {
        return this.positionName;
    }

    public void setPositionName(String positionName) {
        this.positionName = positionName;
    }

    public Integer getShiftType() {
        return this.shiftType;
    }

    public void setShiftType(Integer shiftType) {
        this.shiftType = shiftType;
    }

    public Integer getRegionId() {
        return this.regionId;
    }

    public void setRegionId(Integer regionId) {
        this.regionId = regionId;
    }

    public String getCode() {
        return this.code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getPyCode() {
        return this.pyCode;
    }

    public void setPyCode(String pyCode) {
        this.pyCode = pyCode;
    }

    public String getAddress() {
        return this.address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getTimeType() {
        return this.timeType;
    }

    public void setTimeType(Integer timeType) {
        this.timeType = timeType;
    }

    public Integer getServiceId() {
        return this.serviceId;
    }

    public void setServiceId(Integer serviceId) {
        this.serviceId = serviceId;
    }

    public String getLastPosTime() {
        return this.lastPosTime;
    }

    public void setLastPosTime(String lastPosTime) {
        this.lastPosTime = lastPosTime;
    }

    public Boolean getIsDel() {
        return this.isDel;
    }

    public void setIsDel(Boolean isDel) {
        this.isDel = isDel;
    }

    public String getIdCode() {
        return this.idCode;
    }

    public void setIdCode(String idCode) {
        this.idCode = idCode;
    }

    public String getLeaderPost() {
        return this.leaderPost;
    }

    public void setLeaderPost(String leaderPost) {
        this.leaderPost = leaderPost;
    }

    public String getNonLeaderPost() {
        return this.nonLeaderPost;
    }

    public void setNonLeaderPost(String nonLeaderPost) {
        this.nonLeaderPost = nonLeaderPost;
    }

    public String getPosType() {
        return this.posType;
    }

    public void setPosType(String posType) {
        this.posType = posType;
    }

    public String getShiftState() {
        return this.shiftState;
    }

    public void setShiftState(String shiftState) {
        this.shiftState = shiftState;
    }

    public String getUpdateDt() {
        return this.updateDt;
    }

    public void setUpdateDt(String updateDt) {
        this.updateDt = updateDt;
    }

    public String getShiftInfos() {
        return this.shiftInfos;
    }

    public void setShiftInfos(String shiftInfos) {
        this.shiftInfos = shiftInfos;
    }

    public java.util.ArrayList<DeviceInfo> getDeviceInfos() {
		return deviceInfos;
	}

	public void setDeviceInfos(java.util.ArrayList<DeviceInfo> deviceInfos) {
		this.deviceInfos = deviceInfos;
	}

	public String getDeviceInfosStr() {
		return deviceInfosStr;
	}

	public void setDeviceInfosStr(String deviceInfosStr) {
		this.deviceInfosStr = deviceInfosStr;
	}

	public String getPic() {
        return this.pic;
    }

    public void setPic(String pic) {
        this.pic = pic;
    }
}
