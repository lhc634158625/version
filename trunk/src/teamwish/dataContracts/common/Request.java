package teamwish.dataContracts.common;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(description = "统一请求参数")
public class Request {
	 private int id;
	 public int getId(){
	  return this.id;
	 }
	 
	 public void setId( int id){
	  this.id = id;
	 }
	 private String newPwd;
	 public String getNewPwd(){
	  return this.newPwd;
	 }
	 
	 public void setNewPwd( String newPwd){
	  this.newPwd = newPwd;
	 }
	 private String oldPwd;
	 public String getOldPwd(){
	  return this.oldPwd;
	 }
	 
	 public void setOldPwd( String oldPwd){
	  this.oldPwd = oldPwd;
	 }
	 private String nickName;
	 public String getNickName(){
	  return this.nickName;
	 }
	 
	 public void setNickName( String nickName){
	  this.nickName = nickName;
	 }
	 private String password;
	 public String getPassword(){
	  return this.password;
	 }
	 
	 public void setPassword( String password){
	  this.password = password;
	 }
	 
	 @ApiModelProperty(value = "开始时间")
	 private String fromDt;
	 public String getFromDt(){
	  return this.fromDt;
	 }
	 
	 public void setFromDt( String fromDt){
	  this.fromDt = fromDt;
	 }
	 private String toDt;
	 public String getToDt(){
	  return this.toDt;
	 }
	 
	 public void setToDt( String toDt){
	  this.toDt = toDt;
	 }
	 
	 private int stationId;
	 public int getStationId(){
	  return this.stationId;
	 }
	 
	 public void setStationId( int stationId){
	  this.stationId = stationId;
	 }

	 private int roleId;
	 public int getRoleId(){
	  return this.roleId;
	 }
	 
	 public void setRoleId( int roleId){
	  this.roleId = roleId;
	 }
	 private String moduleIds;
	 public String getModuleIds(){
	  return this.moduleIds;
	 }
	 
	 public void setModuleIds( String moduleIds){
	  this.moduleIds = moduleIds;
	 }


}
