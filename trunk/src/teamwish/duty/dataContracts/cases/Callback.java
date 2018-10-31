package teamwish.duty.dataContracts.cases;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.sql.Date;
import java.sql.Timestamp;

import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement
@ApiModel(description = "案件回访信息")
public class Callback {
    @ApiModelProperty(value = "id")
    private int id;
    @ApiModelProperty(value = "案件编号")
    private String caseCode;
    @ApiModelProperty(value = "案件类型")
    private String caseType;
    @ApiModelProperty(value = "案发事件")
    private String occurTime;
    @ApiModelProperty(value = "案发地址")
    private String occurAddress;
    @ApiModelProperty(value = "报案人")
    private String reporter;
    @ApiModelProperty(value = "报警电话")
    private String reportTel;
    @ApiModelProperty(value = "联系电话")
    private String contactTel;
    @ApiModelProperty(value = "案件描述")
    private String description;
    @ApiModelProperty(value = "备注")
    private String memo;
    @ApiModelProperty(value = "回访人")
    private Integer staffId;
    @ApiModelProperty(value = "回访时间")
    private String callbackDt;
    @ApiModelProperty(value = "回访方式")
    private String callbackType;
    @ApiModelProperty(value = "回访情况")
    private String callBackInfo;
    @ApiModelProperty(value = "建议意见")
    private String advice;
    @ApiModelProperty(value = "被放人建议")
    private String visiteeAdvice;
    @ApiModelProperty(value = "被放人")
    private String visitee;
    @ApiModelProperty(value = "处理结果")
    private String result;
    @ApiModelProperty(value = "主管单位建议")
    private String stationAdvice;
    @ApiModelProperty(value = "其他意见")
    private String otherAdvice;
    @ApiModelProperty(value = "单位Id")
    private Integer stationId;
    @ApiModelProperty(value = "警务区Id")
    private Integer regionId;
    @ApiModelProperty(value = "受访人身份证")
    private String visiteeID;
    @ApiModelProperty(value = "受访人电话")
    private String visiteeTel;
    @ApiModelProperty(value = "与报案人关系")
    private String relative;
    @ApiModelProperty(value = "创建时间")
    private String created;
    @ApiModelProperty(value = "更新人")
    private Integer updater;
    @ApiModelProperty(value = "更新时间")
    private String updateTime;
    @ApiModelProperty(value = "数据来源")
    private String reportType;
    @ApiModelProperty(value = "code")
    private String code;
    @ApiModelProperty(value = "案发部位")
    private String casePart;
    @ApiModelProperty(value = "案发单位")
    private String caseStation;
    @ApiModelProperty(value = "处警人姓名")
    private String policeName;
    @ApiModelProperty(value = "处警人警号")
    private String policeCode;
    @ApiModelProperty(value = "提供材料")
    private String provideMaterial;
    @ApiModelProperty(value = "犯罪手法")
    private String crimeMeans;
    @ApiModelProperty(value = "案发时间")
    private String caseCreated;
    @ApiModelProperty(value = "经度")
    private Double centerX;
    @ApiModelProperty(value = "纬度")
    private Double centerY;
    @ApiModelProperty(value = "位置来源")
    private String positionSource;
    @ApiModelProperty(value = "单位编号")
    private String stationCode;

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

    public String getCaseType() {
        return this.caseType;
    }

    public void setCaseType(String caseType) {
        this.caseType = caseType;
    }

    public String getOccurTime() {
        return this.occurTime;
    }

    public void setOccurTime(String occurTime) {
        this.occurTime = occurTime;
    }

    public String getOccurAddress() {
        return this.occurAddress;
    }

    public void setOccurAddress(String occurAddress) {
        this.occurAddress = occurAddress;
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

    public Integer getStaffId() {
        return this.staffId;
    }

    public void setStaffId(Integer staffId) {
        this.staffId = staffId;
    }

    public String getCallbackDt() {
        return this.callbackDt;
    }

    public void setCallbackDt(String callbackDt) {
        this.callbackDt = callbackDt;
    }

    public String getCallbackType() {
        return this.callbackType;
    }

    public void setCallbackType(String callbackType) {
        this.callbackType = callbackType;
    }

    public String getCallBackInfo() {
        return this.callBackInfo;
    }

    public void setCallBackInfo(String callBackInfo) {
        this.callBackInfo = callBackInfo;
    }

    public String getAdvice() {
        return this.advice;
    }

    public void setAdvice(String advice) {
        this.advice = advice;
    }

    public String getVisiteeAdvice() {
        return this.visiteeAdvice;
    }

    public void setVisiteeAdvice(String visiteeAdvice) {
        this.visiteeAdvice = visiteeAdvice;
    }

    public String getVisitee() {
        return this.visitee;
    }

    public void setVisitee(String visitee) {
        this.visitee = visitee;
    }

    public String getResult() {
        return this.result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getStationAdvice() {
        return this.stationAdvice;
    }

    public void setStationAdvice(String stationAdvice) {
        this.stationAdvice = stationAdvice;
    }

    public String getOtherAdvice() {
        return this.otherAdvice;
    }

    public void setOtherAdvice(String otherAdvice) {
        this.otherAdvice = otherAdvice;
    }

    public Integer getStationId() {
        return this.stationId;
    }

    public void setStationId(Integer stationId) {
        this.stationId = stationId;
    }

    public Integer getRegionId() {
        return this.regionId;
    }

    public void setRegionId(Integer regionId) {
        this.regionId = regionId;
    }

    public String getVisiteeID() {
        return this.visiteeID;
    }

    public void setVisiteeID(String visiteeID) {
        this.visiteeID = visiteeID;
    }

    public String getVisiteeTel() {
        return this.visiteeTel;
    }

    public void setVisiteeTel(String visiteeTel) {
        this.visiteeTel = visiteeTel;
    }

    public String getRelative() {
        return this.relative;
    }

    public void setRelative(String relative) {
        this.relative = relative;
    }

    public String getCreated() {
        return this.created;
    }

    public void setCreated(String created) {
        this.created = created;
    }

    public Integer getUpdater() {
        return this.updater;
    }

    public void setUpdater(Integer updater) {
        this.updater = updater;
    }

    public String getUpdateTime() {
        return this.updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime;
    }

    public String getReportType() {
        return this.reportType;
    }

    public void setReportType(String reportType) {
        this.reportType = reportType;
    }

    public String getCode() {
        return this.code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getCasePart() {
        return this.casePart;
    }

    public void setCasePart(String casePart) {
        this.casePart = casePart;
    }

    public String getCaseStation() {
        return this.caseStation;
    }

    public void setCaseStation(String caseStation) {
        this.caseStation = caseStation;
    }

    public String getPoliceName() {
        return this.policeName;
    }

    public void setPoliceName(String policeName) {
        this.policeName = policeName;
    }

    public String getPoliceCode() {
        return this.policeCode;
    }

    public void setPoliceCode(String policeCode) {
        this.policeCode = policeCode;
    }

    public String getProvideMaterial() {
        return this.provideMaterial;
    }

    public void setProvideMaterial(String provideMaterial) {
        this.provideMaterial = provideMaterial;
    }

    public String getCrimeMeans() {
        return this.crimeMeans;
    }

    public void setCrimeMeans(String crimeMeans) {
        this.crimeMeans = crimeMeans;
    }

    public String getCaseCreated() {
        return this.caseCreated;
    }

    public void setCaseCreated(String caseCreated) {
        this.caseCreated = caseCreated;
    }

    public Double getCenterX() {
        return this.centerX;
    }

    public void setCenterX(Double centerX) {
        this.centerX = centerX;
    }

    public Double getCenterY() {
        return this.centerY;
    }

    public void setCenterY(Double centerY) {
        this.centerY = centerY;
    }

    public String getPositionSource() {
        return this.positionSource;
    }

    public void setPositionSource(String positionSource) {
        this.positionSource = positionSource;
    }

    public String getStationCode() {
        return this.stationCode;
    }

    public void setStationCode(String stationCode) {
        this.stationCode = stationCode;
    }
}
