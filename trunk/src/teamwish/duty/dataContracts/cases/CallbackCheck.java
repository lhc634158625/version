package teamwish.duty.dataContracts.cases;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.sql.Date;
import java.sql.Timestamp;

import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement
@ApiModel(description = "案件回访抽查信息")
public class CallbackCheck {
    @ApiModelProperty(value = "id")
    private int id;
    @ApiModelProperty(value = "案件编号")
    private String caseCode;
    @ApiModelProperty(value = "反查结果")
    private String result;
    @ApiModelProperty(value = "备注")
    private String memo;
    @ApiModelProperty(value = "反查日期")
    private String checkDt;
    @ApiModelProperty(value = "单位")
    private Integer stationId;
    @ApiModelProperty(value = "登记时间")
    private String created;
    @ApiModelProperty(value = "更新人")
    private Integer updater;
    @ApiModelProperty(value = "更新时间")
    private String updateTime;
    @ApiModelProperty(value = "警员Id")
    private Integer staffId;
    @ApiModelProperty(value = "警号")
    private String policeCode;
    @ApiModelProperty(value = "警员姓名")
    private String policeName;
    @ApiModelProperty(value = "回访记录Id")
    private Integer callbackId;

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

    public String getResult() {
        return this.result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getMemo() {
        return this.memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public String getCheckDt() {
        return this.checkDt;
    }

    public void setCheckDt(String checkDt) {
        this.checkDt = checkDt;
    }

    public Integer getStationId() {
        return this.stationId;
    }

    public void setStationId(Integer stationId) {
        this.stationId = stationId;
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

    public Integer getStaffId() {
        return this.staffId;
    }

    public void setStaffId(Integer staffId) {
        this.staffId = staffId;
    }

    public String getPoliceCode() {
        return this.policeCode;
    }

    public void setPoliceCode(String policeCode) {
        this.policeCode = policeCode;
    }

    public String getPoliceName() {
        return this.policeName;
    }

    public void setPoliceName(String policeName) {
        this.policeName = policeName;
    }

    public Integer getCallbackId() {
        return this.callbackId;
    }

    public void setCallbackId(Integer callbackId) {
        this.callbackId = callbackId;
    }
}
