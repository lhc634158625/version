package teamwish.dataContracts.common;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(description = "排班服务请求参数")
public class RequestDuty {
	
	@ApiModelProperty(value = "排班id")
	 private int id;
	 public int getId(){
	  return this.id;
	 }
	 
	 public void setId( int id){
	  this.id = id;
	 }
	
	 @ApiModelProperty(value = "班别id")
	 private String shiftType;
	 public String getShiftType(){
	  return this.shiftType;
	 }
	 
	 public void setShiftType( String shiftType){
	  this.shiftType = shiftType;
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
	 
	 @ApiModelProperty(value = "结束时间")
	 private String toDt;
	 public String getToDt(){
	  return this.toDt;
	 }
	 
	 public void setToDt( String toDt){
	  this.toDt = toDt;
	 }
	 
	 @ApiModelProperty(value = "单位Id")
	 private int stationId;
	 public int getStationId(){
	  return this.stationId;
	 }
	 
	 public void setStationId( int stationId){
	  this.stationId = stationId;
	 }
}
