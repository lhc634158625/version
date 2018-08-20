package teamwish.dataContracts.duty;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.Date;
import java.sql.Timestamp;

//import io.swagger.annotations.ApiModel;
//import io.swagger.annotations.ApiModelProperty;

@XmlRootElement
public class  ArrangeInfo {
private int id ;
 public int getId(){
  return this.id;
 }
 
 public void setId(int id){
  this.id = id;
 }
private int staffId ;
 public int getStaffId(){
  return this.staffId;
 }
 
 public void setStaffId(int staffId){
  this.staffId = staffId;
 }
private Date workDt ;
 public Date getWorkDt(){
  return this.workDt;
 }
 
 public void setWorkDt(Date workDt){
  this.workDt = workDt;
 }
private int shiftType ;
 public int getShiftType(){
  return this.shiftType;
 }
 
 public void setShiftType(int shiftType){
  this.shiftType = shiftType;
 }
private String staffName ;
 public String getStaffName(){
  return this.staffName;
 }
 
 public void setStaffName(String staffName){
  this.staffName = staffName;
 }
private int regionId ;
 public int getRegionId(){
  return this.regionId;
 }
 
 public void setRegionId(int regionId){
  this.regionId = regionId;
 }
private int stationId ;
 public int getStationId(){
  return this.stationId;
 }
 
 public void setStationId(int stationId){
  this.stationId = stationId;
 }
private int timeType ;
 public int getTimeType(){
  return this.timeType;
 }
 
 public void setTimeType(int timeType){
  this.timeType = timeType;
 }
private String timeName ;
 public String getTimeName(){
  return this.timeName;
 }
 
 public void setTimeName(String timeName){
  this.timeName = timeName;
 }
private Timestamp fromTime ;
 public Timestamp getFromTime(){
  return this.fromTime;
 }
 
 public void setFromTime(Timestamp fromTime){
  this.fromTime = fromTime;
 }
private Timestamp toTime ;
 public Timestamp getToTime(){
  return this.toTime;
 }
 
 public void setToTime(Timestamp toTime){
  this.toTime = toTime;
 }


} 

