package teamwish.duty.dataContracts.point;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import teamwish.duty.dataContracts.common.RequestBase;


@ApiModel(description = "巡区服务请求参数")
public class RequestPoint extends RequestBase{
    @ApiModelProperty(value = "字典表：PointType中parameter")
    private String pointType;  
    @ApiModelProperty(value = "字典表：PointInfoType中parameter")
    private String pointInfoType; 
    
    @ApiModelProperty(value = "字典表：PointInfoType中parameter")
    private String patrolType;

	public String getPointType() {
		return pointType;
	}

	public void setPointType(String pointType) {
		this.pointType = pointType;
	}

	public String getPointInfoType() {
		return pointInfoType;
	}

	public void setPointInfoType(String pointInfoType) {
		this.pointInfoType = pointInfoType;
	}

	public String getPatrolType() {
		return patrolType;
	}

	public void setPatrolType(String patrolType) {
		this.patrolType = patrolType;
	} 
    
    
}
