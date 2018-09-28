package teamwish.duty.dataContracts.duty;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import teamwish.duty.dataContracts.common.RequestBase;


@ApiModel(description = "排班服务请求参数")
public class RequestDuty extends RequestBase{
    @ApiModelProperty(value = "排班id")
    private int id;    
    @ApiModelProperty(value = "开始时间")
    private String fromDt;
    @ApiModelProperty(value = "结束时间")
    private String toDt;
    @ApiModelProperty(value = "开始时间段")
    private String fromTime;
    @ApiModelProperty(value = "结束时间段")
    private String toTime;
    @ApiModelProperty(value = "单位Id")
    private int stationId;
    @ApiModelProperty(value = "班别id")
    private String shiftType;
    @ApiModelProperty(value = "班别IdPath")
    private String shiftTypeIdPath;
    @ApiModelProperty(value = "班别类型组Id")
    private int shiftTypeGroupId;
    @ApiModelProperty(value = "是否显示")
    private int isShow = 0;
    @ApiModelProperty(value = "包含下级单位，0：不包含，1：包含; 默认:1; ")
    private int isChild = 1;
    @ApiModelProperty(value = "警员类型")
    private int postion = -1;
    @ApiModelProperty(value = "生成没排班单位")
    private int isNullStaff = 1;
    @ApiModelProperty(value = "包含下级排班")
    private int isChildShiftType = 1;
    	

	@ApiModelProperty(hidden = true)
    private int stationGroupId;
    @ApiModelProperty(hidden = true)
    private String path;
    @ApiModelProperty(hidden = true)
    private int tLevel;

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFromDt() {
        return this.fromDt;
    }

    public void setFromDt(String fromDt) {
        this.fromDt = fromDt;
    }

    public String getToDt() {
        return this.toDt;
    }

    public void setToDt(String toDt) {
        this.toDt = toDt;
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

    public int getStationId() {
        return this.stationId;
    }

    public void setStationId(int stationId) {
        this.stationId = stationId;
    }
    
    public String getShiftType() {
        return this.shiftType;
    }

    public void setShiftType(String shiftType) {
        this.shiftType = shiftType;
    }
    
    public String getShiftTypeIdPath() {
        return (this.shiftTypeIdPath);
    }

    public void setShiftTypeIdPath(String shiftTypeIdPath) {
        this.shiftTypeIdPath = shiftTypeIdPath;
    }
    
    
    public String getPath() {
        return (this.path);
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
    
    public int getIsShow() {
        return this.isShow;
    }

    public void setIsShow(int isShow) {
        this.isShow = isShow;
    }
    
    
    public int getStationGroupId() {
        return this.stationGroupId;
    }

    public void setStationGroupId(int stationGroupId) {
        this.stationGroupId = stationGroupId;
    }
    
    public int getIsChild() {
        return this.isChild;
    }

    public void setIsChild(int isChild) {
        this.isChild = isChild;
    }
    
    public int getPostion() {
		return postion;
	}

	public void setPostion(int postion) {
		this.postion = postion;
	}
	
	
	public int getIsNullStaff() {
		return isNullStaff;
	}

	public void setIsNullStaff(int isNullStaff) {
		this.isNullStaff = isNullStaff;
	}

	public int getIsChildShiftType() {
		return isChildShiftType;
	}
	
	public void setIsChildShiftType(int isChildShiftType) {
		this.isChildShiftType = isChildShiftType;
	}
}
