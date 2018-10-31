package teamwish.duty.dataContracts.cases;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.sql.Date;
import java.sql.Timestamp;

import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement
@ApiModel(description = "案件信息")
public class CaseInfo {
    @ApiModelProperty(value = "id")
    private int id;
    @ApiModelProperty(value = "案件编号")
    private String caseCode;
    @ApiModelProperty(value = "报警人")
    private String reporter;
    @ApiModelProperty(value = "报警电话")
    private String reportTel;
    @ApiModelProperty(value = "联系电话")
    private String contactTel;
    @ApiModelProperty(value = "警情号")
    private String code;
    @ApiModelProperty(value = "案发地址")
    private String occurAddress;
    @ApiModelProperty(value = "案发时间")
    private String occurTime;
    @ApiModelProperty(value = "案件类型")
    private String caseType;
    @ApiModelProperty(value = "警情描述")
    private String description;
    @ApiModelProperty(value = "管辖单位")
    private String station;
    @ApiModelProperty(value = "发案部位")
    private String fabw;
    @ApiModelProperty(value = "单位编号")
    private String stationCode;
    @ApiModelProperty(value = "更新时间")
    private String updateTime;
    @ApiModelProperty(value = "登记时间")
    private String created;
    @ApiModelProperty(value = "作案手段")
    private String crimeMeans;
    @ApiModelProperty(value = "类型")
    private String type;
    @ApiModelProperty(value = "经度")
    private Double longitude;
    @ApiModelProperty(value = "纬度")
    private Double latitude;
    @ApiModelProperty(value = "警务区名称")
    private String regionName;
    @ApiModelProperty(value = "是否需要回访")
    private Boolean needCallBack;
    @ApiModelProperty(value = "单位Id")
    private Integer stationId;

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCaseCode() {
        return this.caseCode;
    }

    public void setCaseCode(String caseCode) {
        this.caseCode = caseCode;
    }

    public String getReporter() {
        return this.reporter;
    }

    public void setReporter(String reporter) {
        this.reporter = reporter;
    }

    public String getReportTel() {
        return this.reportTel;
    }

    public void setReportTel(String reportTel) {
        this.reportTel = reportTel;
    }

    public String getContactTel() {
        return this.contactTel;
    }

    public void setContactTel(String contactTel) {
        this.contactTel = contactTel;
    }

    public String getCode() {
        return this.code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getOccurAddress() {
        return this.occurAddress;
    }

    public void setOccurAddress(String occurAddress) {
        this.occurAddress = occurAddress;
    }

    public String getOccurTime() {
        return this.occurTime;
    }

    public void setOccurTime(String occurTime) {
        this.occurTime = occurTime;
    }

    public String getCaseType() {
        return this.caseType;
    }

    public void setCaseType(String caseType) {
        this.caseType = caseType;
    }

    public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStation() {
        return this.station;
    }

    public void setStation(String station) {
        this.station = station;
    }

    public String getFabw() {
        return this.fabw;
    }

    public void setFabw(String fabw) {
        this.fabw = fabw;
    }

    public String getStationCode() {
        return this.stationCode;
    }

    public void setStationCode(String stationCode) {
        this.stationCode = stationCode;
    }

    public String getUpdateTime() {
        return this.updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime;
    }

    public String getCreated() {
        return this.created;
    }

    public void setCreated(String created) {
        this.created = created;
    }

    public String getCrimeMeans() {
        return this.crimeMeans;
    }

    public void setCrimeMeans(String crimeMeans) {
        this.crimeMeans = crimeMeans;
    }

    public String getType() {
        return this.type;
    }

    public void setType(String type) {
        this.type = type;
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

    public String getRegionName() {
        return this.regionName;
    }

    public void setRegionName(String regionName) {
        this.regionName = regionName;
    }

    public Boolean getNeedCallBack() {
        return this.needCallBack;
    }

    public void setNeedCallBack(Boolean needCallBack) {
        this.needCallBack = needCallBack;
    }

    public Integer getStationId() {
        return this.stationId;
    }

    public void setStationId(Integer stationId) {
        this.stationId = stationId;
    }
}
