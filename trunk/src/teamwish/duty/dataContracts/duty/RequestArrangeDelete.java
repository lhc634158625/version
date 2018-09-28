package teamwish.duty.dataContracts.duty;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import teamwish.duty.dataContracts.common.RequestBase;


@ApiModel(description = "排班服务删除请求参数")
public class RequestArrangeDelete extends RequestBase{

    @ApiModelProperty(value = "开始时间")
    private String fromTime;
    @ApiModelProperty(value = "结束时间")
    private String toTime;    
    @ApiModelProperty(value = "巡区ID")
    private Integer pointInfoId;
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
	public Integer getPointInfoId() {
		return pointInfoId;
	}
	public void setPointInfoId(Integer pointInfoId) {
		this.pointInfoId = pointInfoId;
	}
	
    
}
