package teamwish.duty.dataContracts.duty;
import javax.xml.bind.annotation.XmlRootElement;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.sql.Date;
import java.sql.Timestamp;


@ApiModel(description = "巡逻区类")
@XmlRootElement
public class  PointInfo {
	 @ApiModelProperty(value = "类别")
	 private String type;
	 public String getType(){
	  return this.type;
	 }
	 
	 public void setType( String type){
	  this.type = type;
	 }
	 @ApiModelProperty(value = "名称")
private String name ;
 public String getName(){
  return this.name;
 }
 
 public void setName(String name){
  this.name = name;
 }
 @ApiModelProperty(value = "归属Id")
private int ownerId ;
 public int getOwnerId(){
  return this.ownerId;
 }
 
 public void setOwnerId(int ownerId){
  this.ownerId = ownerId;
 }
 @ApiModelProperty(value = "归属类型")
private String ownerType ;
 public String getOwnerType(){
  return this.ownerType;
 }
 
 public void setOwnerType(String ownerType){
  this.ownerType = ownerType;
 }
 @ApiModelProperty(value = "经度")
private double longitude ;
 public double getLongitude(){
  return this.longitude;
 }

 public void setLongitude(double longitude){
  this.longitude = longitude;
 }
 @ApiModelProperty(value = "纬度")
private double latitude ;
 public double getLatitude(){
  return this.latitude;
 }
 
 public void setLatitude(double latitude){
  this.latitude = latitude;
 }
 @ApiModelProperty(value = "单位ID")
 private Integer stationId;
 public Integer getStationId() {
     return this.stationId;
 }

 public void setStationId(Integer stationId) {
     this.stationId = stationId;
 }
} 

