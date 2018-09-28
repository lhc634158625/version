package teamwish.duty.dataContracts.point;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import teamwish.duty.dataContracts.common.RequestBase;


@ApiModel(description = "巡区服务删除请求参数")
public class RequestPointDelete extends RequestBase{
    @ApiModelProperty(value = "巡区ID")
    private Integer pointInfoId;  
    
    @ApiModelProperty(value = "开始时间")
    private String fromTime; 
    
    @ApiModelProperty(value = "结束时间")
    private String toTime;

	public Integer getPointInfoId() {
		return pointInfoId;
	}

	public void setPointInfoId(Integer pointInfoId) {
		this.pointInfoId = pointInfoId;
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
    
}
