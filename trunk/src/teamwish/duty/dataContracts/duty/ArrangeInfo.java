package teamwish.duty.dataContracts.duty;

import java.sql.Timestamp;

import java.util.Date;

import javax.xml.bind.annotation.XmlRootElement;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(description = "排班信息")
@XmlRootElement
public class ArrangeInfo {
	@ApiModelProperty(value = "排班ID")
    private int id;
	@ApiModelProperty(value = "单位ID")
    private int stationId;
	@ApiModelProperty(value = "警员ID")
    private int staffId;
	@ApiModelProperty(value = "警员姓名")
    private String staffName;
	@ApiModelProperty(value = "警号")
    private String staffCode;
	@ApiModelProperty(value = "警员身份证")
    private String staffIDCard;
	@ApiModelProperty(value = "警员电话")
	private String staffPhone;
	@ApiModelProperty(value = "警员职务")	
    private String staffPost;
    @ApiModelProperty(value = "警员岗位")
    private String staffPositionName;
	@ApiModelProperty(value = "排班日期")
    private String workDt;
	@ApiModelProperty(value = "开始时间")
    private String fromTime;
	@ApiModelProperty(value = "结束时间")
    private String toTime;
	@ApiModelProperty(value = "勤务实施状况(01：正常使用；02：修改记录；03：注销记录)")
    private int state;	
	@ApiModelProperty(value = "勤务编号")
	private String code;
	@ApiModelProperty(value = "警务区ID")
    private int regionId;  
    @ApiModelProperty(value = "警务区编号")
    private String regionCode;
    @ApiModelProperty(value = "警务区名称")
    private String regionName;
    @ApiModelProperty(value = "排班ID")
    private int shiftType;
    @ApiModelProperty(value = "勤务内容名称")
    private String serviceName;
    @ApiModelProperty(value = "组名称")
    private String groupName;
    @ApiModelProperty(value = "队名称")
    private String teamName;
    @ApiModelProperty(value = "勤务大项名称")
    private String shiftName;
    @ApiModelProperty(value = "车牌号")
    private String carNo;
    @ApiModelProperty(value = "呼号")
    private String callNo;
    @ApiModelProperty(value = "巡逻区ID")
    private int pointInfoId;
    @ApiModelProperty(value = "任务巡区ID")
    private Integer interceptPointId;    
    
    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getStationId() {
        return this.stationId;
    }

    public void setStationId(int stationId) {
        this.stationId = stationId;
    }

    public int getStaffId() {
        return this.staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public String getStaffName() {
        return this.staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public String getStaffCode() {
        return this.staffCode;
    }

    public void setStaffCode(String staffCode) {
        this.staffCode = staffCode;
    }

    public String getStaffIDCard() {
        return this.staffIDCard;
    }

    public void setStaffIDCard(String staffIDCard) {
        this.staffIDCard = staffIDCard;
    }

    public String getStaffPhone() {
        return this.staffPhone;
    }

    public void setStaffPhone(String staffPhone) {
        this.staffPhone = staffPhone;
    }

    public String getStaffPost() {
		return staffPost;
	}

	public void setStaffPost(String staffPost) {
		this.staffPost = staffPost;
	}

	public String getStaffPositionName() {
		return staffPositionName;
	}

	public void setStaffPositionName(String staffPositionName) {
		this.staffPositionName = staffPositionName;
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

    public int getState() {
        return this.state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getCode() {
        return this.code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getRegionId() {
        return this.regionId;
    }

    public void setRegionId(int regionId) {
        this.regionId = regionId;
    }

    public String getRegionCode() {
        return this.regionCode;
    }

    public void setRegionCode(String regionCode) {
        this.regionCode = regionCode;
    }

    public String getRegionName() {
        return this.regionName;
    }

    public void setRegionName(String regionName) {
        this.regionName = regionName;
    }

    public int getShiftType() {
        return this.shiftType;
    }

    public void setShiftType(int shiftType) {
        this.shiftType = shiftType;
    }

    public String getServiceName() {
        return this.serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getGroupName() {
        return this.groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getTeamName() {
        return this.teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    public String getShiftName() {
        return this.shiftName;
    }

    public void setShiftName(String shiftName) {
        this.shiftName = shiftName;
    }

    public String getCarNo() {
        return this.carNo;
    }

    public void setCarNo(String carNo) {
        this.carNo = carNo;
    }

    public String getCallNo() {
        return this.callNo;
    }

    public void setCallNo(String callNo) {
        this.callNo = callNo;
    }

    public int getPointInfoId() {
        return this.pointInfoId;
    }

    public void setPointInfoId(int pointInfoId) {
        this.pointInfoId = pointInfoId;
    }

	public Integer getInterceptPointId() {
		return interceptPointId;
	}

	public void setInterceptPointId(Integer interceptPointId) {
		this.interceptPointId = interceptPointId;
	}
    
    
}