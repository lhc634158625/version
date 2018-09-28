package teamwish.duty.dataContracts.staff;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import teamwish.duty.dataContracts.common.RequestBase;


@ApiModel(description = "警员请求参数")
public class RequestStaff extends RequestBase{
    
    @ApiModelProperty(value = "单位Id")
    private int stationId;
    @ApiModelProperty(value = "包含下级单位，0：不包含，1：包含; 默认:1; ")
    private int isChild = 1;
    @ApiModelProperty(value = "警员Id")
    private int id;
    @ApiModelProperty(value = "警员姓名")
    private String name;
    @ApiModelProperty(value = "警员员状态")
    private String state;
    @ApiModelProperty(value = "排班状态")
    private String shiftState;
    @ApiModelProperty(value = "排班信息")
    private String shiftInfo;
    @ApiModelProperty(value = "设备")
    private String deviceName;
    
    
	public int getStationId() {
		return stationId;
	}	
	public void setStationId(int stationId) {
		this.stationId = stationId;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getShiftState() {
		return shiftState;
	}
	public void setShiftState(String shiftState) {
		this.shiftState = shiftState;
	}
	public String getShiftInfo() {
		return shiftInfo;
	}
	public void setShiftInfo(String shiftInfo) {
		this.shiftInfo = shiftInfo;
	}
	public String getDeviceName() {
		return deviceName;
	}
	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
	}
    
}
