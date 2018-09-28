package teamwish.duty.dataContracts.staff;
import javax.xml.bind.annotation.XmlRootElement;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.sql.Date;
import java.sql.Timestamp;

@XmlRootElement
@ApiModel(description = "警员信息")
public class  Staff {
private int id ;
 public int getId(){
  return this.id;
 }
 
 public void setId(int id){
  this.id = id;
 }
private String name ;
 public String getName(){
  return this.name;
 }
 
 public void setName(String name){
  this.name = name;
 }
private String gender ;
 public String getGender(){
  return this.gender;
 }
 
 public void setGender(String gender){
  this.gender = gender;
 }
private String state;
 public String getState(){
  return this.state;
 }
 
 public void setState(String state){
  this.state = state;
 }
private Double longitude ;
 public Double getLongitude(){
  return this.longitude;
 }
 
 public void setLongitude(Double longitude){
  this.longitude = longitude;
 }
private Double latitude ;
 public Double getLatitude(){
  return this.latitude;
 }
 
 public void setLatitude(Double latitude){
  this.latitude = latitude;
 }
private Integer stationId ;
 public Integer getStationId(){
  return this.stationId;
 }
 
 public void setStationId(Integer stationId){
  this.stationId = stationId;
 }
 
 private String stationName ;
 public String getStationName(){
  return this.stationName;
 }
 
 public void setStationName(String stationName){
  this.stationName = stationName;
 }
 
private String telephone ;
 public String getTelephone(){
  return this.telephone;
 }
 
 public void setTelephone(String telephone){
  this.telephone = telephone;
 }
private Integer position ;
 public Integer getPosition(){
  return this.position;
 }
 
 public void setPosition(Integer position){
  this.position = position;
 }
 
 private String positionName ;
 public String getPositionName(){
  return this.positionName;
 }
 
 public void setPositionName(String positionName){
  this.positionName = positionName;
 }
 
private Integer shiftType ;
 public Integer getShiftType(){
  return this.shiftType;
 }
 
 public void setShiftType(Integer shiftType){
  this.shiftType = shiftType;
 }
private Integer regionId ;
 public Integer getRegionId(){
  return this.regionId;
 }
 
 public void setRegionId(Integer regionId){
  this.regionId = regionId;
 }
private String code ="";
 public String getCode(){
  return this.code;
 }
 
 public void setCode(String code){
  this.code = code;
 }
private String pyCode ="";
 public String getPyCode(){
  return this.pyCode;
 }
 
 public void setPyCode(String pyCode){
  this.pyCode = pyCode;
 }
private String address ="";
 public String getAddress(){
  return this.address;
 }
 
 public void setAddress(String address){
  this.address = address;
 }
private Integer timeType ;
 public Integer getTimeType(){
  return this.timeType;
 }
 
 public void setTimeType(Integer timeType){
  this.timeType = timeType;
 }
private Integer serviceId ;
 public Integer getServiceId(){
  return this.serviceId;
 }
 
 public void setServiceId(Integer serviceId){
  this.serviceId = serviceId;
 }
private Timestamp lastPosTime ;
 public Timestamp getLastPosTime(){
  return this.lastPosTime;
 }
 
 public void setLastPosTime(Timestamp lastPosTime){
  this.lastPosTime = lastPosTime;
 }
private Boolean isDel ;
 public Boolean getIsDel(){
  return this.isDel;
 }
 
 public void setIsDel(Boolean isDel){
  this.isDel = isDel;
 }
private String idCode ;
 public String getIdCode(){
  return this.idCode;
 }
 
 public void setIdCode(String idCode){
  this.idCode = idCode;
 }
private String leaderPost ="";
 public String getLeaderPost(){
  return this.leaderPost;
 }
 
 public void setLeaderPost(String leaderPost){
  this.leaderPost = leaderPost;
 }
private String nonLeaderPost ="";
 public String getNonLeaderPost(){
  return this.nonLeaderPost;
 }
 
 public void setNonLeaderPost(String nonLeaderPost){
  this.nonLeaderPost = nonLeaderPost;
 }
private String posType ;
 public String getPosType(){
  return this.posType;
 }
 
 public void setPosType(String posType){
  this.posType = posType;
 }
private String shiftState ;
 public String getShiftState(){
  return this.shiftState;
 }
 
 public void setShiftState(String shiftState){
  this.shiftState = shiftState;
 }
private Timestamp updateDt ;
 public Timestamp getUpdateDt(){
  return this.updateDt;
 }
 
 public void setUpdateDt(Timestamp updateDt){
  this.updateDt = updateDt;
 }
 
 @ApiModelProperty(value = "当前勤务")
private String shiftInfos = "";
 public String getShiftInfos(){
  return this.shiftInfos;
 }
 
 public void setShiftInfos(String shiftInfos){
  this.shiftInfos = shiftInfos;
 }
 
 @ApiModelProperty(value = "设备")
 private String deviceInfos = "";
 public String getDeviceInfos(){
  return this.deviceInfos;
 }
 
 public void setDeviceInfos(String deviceInfos){
  this.deviceInfos = deviceInfos;
 }
 
 @ApiModelProperty(value = "照片")
 private String pic = "";
 public String getPic(){
  return this.pic;
 }
 
 public void setPic(String pic){
  this.pic = pic;
 }
} 

