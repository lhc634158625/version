package teamwish.dataContracts.map;
import javax.xml.bind.annotation.XmlRootElement;
import java.sql.Date;
import java.sql.Timestamp;

@XmlRootElement
public class  PointInfo {
private int id ;
 public int getId(){
  return this.id;
 }
 
 public void setId(int id){
  this.id = id;
 }
private String code ;
 public String getCode(){
  return this.code;
 }
 
 public void setCode(String code){
  this.code = code;
 }
private String name ;
 public String getName(){
  return this.name;
 }
 
 public void setName(String name){
  this.name = name;
 }
private String nickName ;
 public String getNickName(){
  return this.nickName;
 }
 
 public void setNickName(String nickName){
  this.nickName = nickName;
 }
private int stationId ;
 public int getStationId(){
  return this.stationId;
 }
 
 public void setStationId(int stationId){
  this.stationId = stationId;
 }
private int ownerId ;
 public int getOwnerId(){
  return this.ownerId;
 }
 
 public void setOwnerId(int ownerId){
  this.ownerId = ownerId;
 }
private String ownerType ;
 public String getOwnerType(){
  return this.ownerType;
 }
 
 public void setOwnerType(String ownerType){
  this.ownerType = ownerType;
 }
private Timestamp created ;
 public Timestamp getCreated(){
  return this.created;
 }
 
 public void setCreated(Timestamp created){
  this.created = created;
 }
private Timestamp updateDt ;
 public Timestamp getUpdateDt(){
  return this.updateDt;
 }
 
 public void setUpdateDt(Timestamp updateDt){
  this.updateDt = updateDt;
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
private String state ;
 public String getState(){
  return this.state;
 }
 
 public void setState(String state){
  this.state = state;
 }
private String memo ;
 public String getMemo(){
  return this.memo;
 }
 
 public void setMemo(String memo){
  this.memo = memo;
 }
private String contents ;
 public String getContents(){
  return this.contents;
 }
 
 public void setContents(String contents){
  this.contents = contents;
 }
private String creater ;
 public String getCreater(){
  return this.creater;
 }
 
 public void setCreater(String creater){
  this.creater = creater;
 }
private String createrStation ;
 public String getCreaterStation(){
  return this.createrStation;
 }
 
 public void setCreaterStation(String createrStation){
  this.createrStation = createrStation;
 }
private String param ;
 public String getParam(){
  return this.param;
 }
 
 public void setParam(String param){
  this.param = param;
 }
} 

