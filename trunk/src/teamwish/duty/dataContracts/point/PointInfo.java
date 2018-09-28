package teamwish.duty.dataContracts.point;

import java.sql.Timestamp;

import javax.xml.bind.annotation.XmlRootElement;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(description = "巡逻区类")
@XmlRootElement
public class PointInfo {
    private int id;
    @ApiModelProperty(value = "上级ID")
    private Integer pid;
    @ApiModelProperty(value = "编号")
    private String code;
    @ApiModelProperty(value = "名称")
    private String name;
    @ApiModelProperty(value = "状态")
    private String state;
    @ApiModelProperty(value = "类型ID")
    private Integer type;
    @ApiModelProperty(value = "类型ID路径")
    private String typePath;
    @ApiModelProperty(value = "范围")
    private String description;
    @ApiModelProperty(value = "备注")
    private String memo;
    @ApiModelProperty(value = "单位ID")
    private Integer stationId;
    @ApiModelProperty(value = "排别ID")
    private Integer shiftTypeId;
    @ApiModelProperty(value = "单位名称")
    private String stationName;
    @ApiModelProperty(value = "经度")
	private Double longitude;
    @ApiModelProperty(value = "纬度")
    private Double latitude;
    @ApiModelProperty(value = "更新者ID")
    private Integer updater;
    @ApiModelProperty(value = "更新时间")
    private Timestamp updateDt;
    @ApiModelProperty(value = "创建者ID")
    private Integer creater;
    @ApiModelProperty(value = "创建时间")
    private Timestamp created;
        
    @ApiModelProperty(value = "扩展信息,如通信等")
    private java.util.ArrayList<PointInfoDevice> pointInfoDevices;
        
    public String getStationName() {
		return stationName;
	}

	public void setStationName(String stationName) {
		this.stationName = stationName;
	}

	

	public java.util.ArrayList<PointInfoDevice> getPointInfoDevices() {
		return pointInfoDevices;
	}

	public void setPointInfoDevices(java.util.ArrayList<PointInfoDevice> pointInfoDevices) {
		this.pointInfoDevices = pointInfoDevices;
	}

	public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return this.code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getState() {
        return this.state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getTypePath() {
		return typePath;
	}

	public void setTypePath(String typePath) {
		this.typePath = typePath;
	}

	public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getMemo() {
        return this.memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public Integer getStationId() {
        return this.stationId;
    }

    public void setStationId(Integer stationId) {
        this.stationId = stationId;
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

    public Timestamp getUpdateDt() {
        return this.updateDt;
    }

    public void setUpdateDt(Timestamp updateDt) {
        this.updateDt = updateDt;
    }

    public Timestamp getCreated() {
        return this.created;
    }

    public void setCreated(Timestamp created) {
        this.created = created;
    }

	public Integer getShiftTypeId() {
		return shiftTypeId;
	}

	public void setShiftTypeId(Integer shiftTypeId) {
		this.shiftTypeId = shiftTypeId;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public Integer getUpdater() {
		return updater;
	}

	public void setUpdater(Integer updater) {
		this.updater = updater;
	}

	public Integer getCreater() {
		return creater;
	}

	public void setCreater(Integer creater) {
		this.creater = creater;
	}

}
