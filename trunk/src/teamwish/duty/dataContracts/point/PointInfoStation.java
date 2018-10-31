package teamwish.duty.dataContracts.point;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.sql.Date;
import java.sql.Timestamp;

import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement
@ApiModel(description = "PointInfoStation信息")
public class PointInfoStation {
    @ApiModelProperty(value = "id")
    private int id;
    @ApiModelProperty(value = "pointInfoId")
    private Integer pointInfoId;
    @ApiModelProperty(value = "stationId")
    private Integer stationId;    
    @ApiModelProperty(value = "stationName")
    private String stationName;
    @ApiModelProperty(value = "日期")
    private String workDt;
    @ApiModelProperty(value = "开始时间")
    private String fromTime;
    @ApiModelProperty(value = "结束时间")
    private String toTime;

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Integer getPointInfoId() {
        return this.pointInfoId;
    }

    public void setPointInfoId(Integer pointInfoId) {
        this.pointInfoId = pointInfoId;
    }

    public Integer getStationId() {
        return this.stationId;
    }

    public void setStationId(Integer stationId) {
        this.stationId = stationId;
    }

	public String getStationName() {
		return stationName;
	}

	public void setStationName(String stationName) {
		this.stationName = stationName;
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
    
}
