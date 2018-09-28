package teamwish.duty.dataContracts.device;
import javax.xml.bind.annotation.XmlRootElement;

import io.swagger.annotations.*;


import java.sql.Date;
import java.sql.Timestamp;

@XmlRootElement
@ApiModel(description = "CameraInfo信息")
public class  CameraInfo {
@ApiModelProperty(value = "id")
private int id ;
 public int getId(){
  return this.id;
 }
 
 public void setId(int id){
  this.id = id;
 }
@ApiModelProperty(value = "社区名称")
private String communityName ;
 public String getCommunityName(){
  return this.communityName;
 }
 
 public void setCommunityName(String communityName){
  this.communityName = communityName;
 }
@ApiModelProperty(value = "通道名称")
private String channelName ;
 public String getChannelName(){
  return this.channelName;
 }
 
 public void setChannelName(String channelName){
  this.channelName = channelName;
 }
@ApiModelProperty(value = "pCode")
private String pCode ;
 public String getPCode(){
  return this.pCode;
 }
 
 public void setPCode(String pCode){
  this.pCode = pCode;
 }
@ApiModelProperty(value = "单位编码")
private String stationCode ;
 public String getStationCode(){
  return this.stationCode;
 }
 
 public void setStationCode(String stationCode){
  this.stationCode = stationCode;
 }
@ApiModelProperty(value = "警务区编码")
private String regionName ;
 public String getRegionName(){
  return this.regionName;
 }
 
 public void setRegionName(String regionName){
  this.regionName = regionName;
 }
@ApiModelProperty(value = "视频类型")
private String deviceType ;
 public String getDeviceType(){
  return this.deviceType;
 }
 
 public void setDeviceType(String deviceType){
  this.deviceType = deviceType;
 }
@ApiModelProperty(value = "统一Id")
private String gisId ;
 public String getGisId(){
  return this.gisId;
 }
 
 public void setGisId(String gisId){
  this.gisId = gisId;
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
@ApiModelProperty(value = "高峰站点")
private String peakSite ;
 public String getPeakSite(){
  return this.peakSite;
 }
 
 public void setPeakSite(String peakSite){
  this.peakSite = peakSite;
 }
@ApiModelProperty(value = "stationId")
private int stationId ;
 public int getStationId(){
  return this.stationId;
 }
 
 public void setStationId(int stationId){
  this.stationId = stationId;
 }
@ApiModelProperty(value = "regionId")
private int regionId ;
 public int getRegionId(){
  return this.regionId;
 }
 
 public void setRegionId(int regionId){
  this.regionId = regionId;
 }
@ApiModelProperty(value = "updateTime")
private Timestamp updateTime ;
 public Timestamp getUpdateTime(){
  return this.updateTime;
 }
 
 public void setUpdateTime(Timestamp updateTime){
  this.updateTime = updateTime;
 }
@ApiModelProperty(value = "矩阵码")
private int matrixPort ;
 public int getMatrixPort(){
  return this.matrixPort;
 }
 
 public void setMatrixPort(int matrixPort){
  this.matrixPort = matrixPort;
 }
@ApiModelProperty(value = "state")
private String state ;
 public String getState(){
  return this.state;
 }
 
 public void setState(String state){
  this.state = state;
 }
} 

