package teamwish.dataContracts.sys;
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
private String state ;
 public String getState(){
  return this.state;
 }
 
 public void setState(String state){
  this.state = state;
 }
private double longitude ;
 public double getLongitude(){
  return this.longitude;
 }
 
 public void setLongitude(double longitude){
  this.longitude = longitude;
 }
private double latitude ;
 public double getLatitude(){
  return this.latitude;
 }
 
 public void setLatitude(double latitude){
  this.latitude = latitude;
 }
private int stationId ;
 public int getStationId(){
  return this.stationId;
 }
 
 public void setStationId(int stationId){
  this.stationId = stationId;
 }
private String telephone ;
 public String getTelephone(){
  return this.telephone;
 }
 
 public void setTelephone(String telephone){
  this.telephone = telephone;
 }
private int position ;
 public int getPosition(){
  return this.position;
 }
 
 public void setPosition(int position){
  this.position = position;
 }
private int shiftType ;
 public int getShiftType(){
  return this.shiftType;
 }
 
 public void setShiftType(int shiftType){
  this.shiftType = shiftType;
 }
private int regionId ;
 public int getRegionId(){
  return this.regionId;
 }
 
 public void setRegionId(int regionId){
  this.regionId = regionId;
 }
private String code ;
 public String getCode(){
  return this.code;
 }
 
 public void setCode(String code){
  this.code = code;
 }
private String pyCode ;
 public String getPyCode(){
  return this.pyCode;
 }
 
 public void setPyCode(String pyCode){
  this.pyCode = pyCode;
 }
private String address ;
 public String getAddress(){
  return this.address;
 }
 
 public void setAddress(String address){
  this.address = address;
 }
private int timeType ;
 public int getTimeType(){
  return this.timeType;
 }
 
 public void setTimeType(int timeType){
  this.timeType = timeType;
 }
private int serviceId ;
 public int getServiceId(){
  return this.serviceId;
 }
 
 public void setServiceId(int serviceId){
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
private String leaderPost ;
 public String getLeaderPost(){
  return this.leaderPost;
 }
 
 public void setLeaderPost(String leaderPost){
  this.leaderPost = leaderPost;
 }
private String nonLeaderPost ;
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
 private String devType = "";
 public String getDevType(){
  return this.devType;
 }
 
 public void setDevType(String devType){
  this.devType = devType;
 }
 
 @ApiModelProperty(value = "照片")
 private String pic = "";
 public String getPic(){
  return this.pic;
 }
 
 public void setPic(String pic){
  this.devType = pic;
 }
} 

