package teamwish.duty.dataContracts.point;

import javax.xml.bind.annotation.XmlRootElement;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(description = "巡逻区设备")
@XmlRootElement
public class PointInfoDevice {
	@ApiModelProperty(value = "ID")
	private int id;
    @ApiModelProperty(value = "巡逻区ID")
    private Integer pointInfoId;
    @ApiModelProperty(value = "设备名称")
    private String deviceTypeName;
    @ApiModelProperty(value = "设备代码")
    private String deviceTypeCode;
    @ApiModelProperty(value = "设备内容")
    private String value;
    @ApiModelProperty(value = "警员ID")
    private String staffId;
    @ApiModelProperty(value = "警号")
    private String staffCode;
    @ApiModelProperty(value = "姓名")
    private String staffName;
    @ApiModelProperty(value = "排班日期")
    private String workDt;
    @ApiModelProperty(value = "开始时间")
    private String fromTime;
    @ApiModelProperty(value = "结束时间")
    private String toTime;
    @ApiModelProperty(value = "巡区ID路径")
    private String pointInfoIdPath;
    
    @ApiModelProperty(hidden = true)
    private Integer isDefault;

    public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
    public Integer getPointInfoId() {
		return pointInfoId;
	}

	public void setPointInfoId(Integer pointInfoId) {
		this.pointInfoId = pointInfoId;
	}

	public String getDeviceTypeName() {
        return deviceTypeName;
    }

    public void setDeviceTypeName(String deviceTypeName) {
        this.deviceTypeName = deviceTypeName;
    }

    public String getDeviceTypeCode() {
        return deviceTypeCode;
    }

    public void setDeviceTypeCode(String deviceTypeCode) {
        this.deviceTypeCode = deviceTypeCode;
    }

    public String getValue() {
        return this.value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getStaffId() {
        return this.staffId;
    }

    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }

    public String getStaffCode() {
        return this.staffCode;
    }

    public void setStaffCode(String staffCode) {
        this.staffCode = staffCode;
    }

    public String getStaffName() {
        return this.staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

	public String getWorkDt() {
		return workDt;
	}

	public void setWorkDt(String workDt) {
		this.workDt = workDt;
	}

	public String getFromTime() {
		return fromTime;
	}

	public void setFromTime(String fromTime) {
		this.fromTime = fromTime;
	}

	public String getToTime() {
		return toTime;
	}

	public void setToTime(String toTime) {
		this.toTime = toTime;
	}

	public Integer getIsDefault() {
		return isDefault;
	}

	public void setIsDefault(Integer isDefault) {
		this.isDefault = isDefault;
	}

	public String getPointInfoIdPath() {
		return pointInfoIdPath;
	}

	public void setPointInfoIdPath(String pointInfoIdPath) {
		this.pointInfoIdPath = pointInfoIdPath;
	}
    
	
}
