package teamwish.duty.dataContracts.sys;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import teamwish.duty.dataContracts.common.RequestBase;


@ApiModel(description = "统一请求参数")
public class Request extends RequestBase{
    @ApiModelProperty(value = "ID")
    private int id;
    @ApiModelProperty(value = "新密码")
    private String newPwd;
    @ApiModelProperty(value = "旧密码")
    private String oldPwd;
    @ApiModelProperty(value = "用户名")
    private String nickName;
    @ApiModelProperty(value = "用户密码")
    private String password;
    @ApiModelProperty(value = "开始日期")
    private String fromDt;
    @ApiModelProperty(value = "结束日期")
    private String toDt;
    @ApiModelProperty(value = "单位Id")
    private int stationId;
    @ApiModelProperty(value = "多个单位Id")
    private String stationIds;
    @ApiModelProperty(value = "角色Id")
    private int roleId;
    @ApiModelProperty(value = "模块Ids")
    private String moduleIds;
    @ApiModelProperty(value = "单位组Id")
    private int stationGroupId = 0;    

    public int getId() {
        return (this.id);
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNewPwd() {
        return (this.newPwd);
    }

    public void setNewPwd(String newPwd) {
        this.newPwd = newPwd;
    }

    public String getOldPwd() {
        return (this.oldPwd);
    }

    public void setOldPwd(String oldPwd) {
        this.oldPwd = oldPwd;
    }

    public String getNickName() {
        return (this.nickName);
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getPassword() {
        return (this.password);
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFromDt() {
        return (this.fromDt);
    }

    public void setFromDt(String fromDt) {
        this.fromDt = fromDt;
    }

    public String getToDt() {
        return (this.toDt);
    }

    public void setToDt(String toDt) {
        this.toDt = toDt;
    }

    public int getStationId() {
        return (this.stationId);
    }

    public void setStationId(int stationId) {
        this.stationId = stationId;
    }
    
    public String getStationIds() {
        return (this.stationIds);
    }

    public void setStationIds(String stationIds) {
        this.stationIds = stationIds;
    }

    public int getRoleId() {
        return (this.roleId);
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getModuleIds() {
        return (this.moduleIds);
    }

    public void setModuleIds(String moduleIds) {
        this.moduleIds = moduleIds;
    }   
    
    public int getStationGroupId() {
        return (this.stationGroupId);
    }

    public void setStationGroupId(int stationGroupId) {
        this.stationGroupId = stationGroupId;
    } 
}
