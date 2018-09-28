package teamwish.duty.dataContracts.report;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import teamwish.duty.dataContracts.common.RequestBase;


@ApiModel(description = "勤务态势报表请求参数")
public class RequestReport extends RequestBase{   
    @ApiModelProperty(value = "单位Id")
    private int stationId;
    @ApiModelProperty(value = "类型:1:警情态势;2:警力布防;3:警情;4:警力装备;")
    private String type;
    
	public int getStationId() {
		return stationId;
	}
	public void setStationId(int stationId) {
		this.stationId = stationId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
   
}
