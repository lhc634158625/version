package teamwish.dataContracts.duty;
import javax.xml.bind.annotation.XmlRootElement;
import java.sql.Date;
import java.sql.Timestamp;

@XmlRootElement
public class  ArrangeInfoReport {
	 private int stationId = 0;
	 public int getStationId(){
	  return this.stationId;
	 }
	 
	 public void setStationId( int stationId){
	  this.stationId = stationId;
	 }
	 private String stationName;
	 public String getStationName(){
	  return this.stationName;
	 }
	 
	 public void setStationName( String stationName){
	  this.stationName = stationName;
	 }
	 
	 
	 private int staffId = 0;
	 public int getStaffId(){
	  return this.staffId;
	 }
	 
	 public void setStaffId( int staffId){
	  this.staffId = staffId;
	 }
	 
	 
	 private String staffName = "";
	 public String getStaffName(){
	  return this.staffName;
	 }
	 
	 public void setStaffName( String staffName){
	  this.staffName = staffName;
	 }
	 
	 
	 private String staffPic = "";
	 public String getStaffPic(){
	  return this.staffPic;
	 }
	 
	 public void setStaffPic( String staffPic){
	  this.staffPic = staffPic;
	 }
	 
	 private String staffCode = "";
	 public String getStaffCode(){
	  return this.staffCode;
	 }
	 
	 public void setStaffCode( String staffCode){
	  this.staffCode = staffCode;
	 }
	 
	 private String staffPhone = "";
	 public String getStaffPhone(){
	  return this.staffPhone;
	 }
	 
	 public void setStaffPhone( String staffPhone){
	  this.staffPhone = staffPhone;
	 }
	 
	 private String post = "";
	 public String getPost(){
	  return this.post;
	 }
	 
	 public void setPost( String post){
	  this.post = post;
	 }
	 
	 private String shiftInfos = "";
	 public String getShiftInfos(){
	  return this.shiftInfos;
	 }
	 
	 public void setShiftInfos( String shiftInfos){
	  this.shiftInfos = shiftInfos;
	 }
	 
	 private String shiftState = "";
	 public String getShiftState(){
	  return this.shiftState;
	 }
	 
	 public void setShiftState( String shiftState){
	  this.shiftState = shiftState;
	 }
	 
	 private String lastPosTime = "";
	 public String getLastPosTime(){
	  return this.lastPosTime;
	 }
		 
	 public void setLastPosTime( String lastPosTime){
	  this.lastPosTime = lastPosTime;
	 }
	 
	 private String deviceInfos = "";
	 public String getDeviceInfos(){
	  return this.deviceInfos;
	 }
	 
	 public void setDeviceInfos( String deviceInfos){
		  this.deviceInfos = deviceInfos;
		 }
	 
	 private String workDt = "";
	 public String getWorkDt(){
	  return this.workDt;
	 }
	 
	 public void setWorkDt( String workDt){
	  this.workDt = workDt;
	 }
	 
	 private String fromTime;
	 public String getFromTime(){
	  return this.fromTime;
	 }
	 
	 public void setFromTime( String fromTime){
	  this.fromTime = fromTime;
	 }
	 
	 private String toTime = "";
	 public String getToTime(){
	  return this.toTime;
	 }
	 
	 public void setToTime( String toTime){
	  this.toTime = toTime;
	 }
	 
	 private String state = "";
	 public String getState(){
	  return this.state;
	 }
	 
	 public void setState( String state){
	  this.state = state;
	 }
	 
	 private String shiftType = "";
	 public String getShiftType(){
	  return this.shiftType;
	 }
	 
	 public void setShiftType( String shiftType){
	  this.shiftType = shiftType;
	 }
	 
	 private String shiftName = "";
	 public String getShiftName(){
	  return this.shiftName;
	 }
	 
	 public void setShiftName( String shiftName){
	  this.shiftName = shiftName;
	 }
	 
	 private String idPath;
	 public String getIdPath(){
	  return this.idPath;
	 }
	 
	 public void setIdPath( String idPath){
	  this.idPath = idPath;
	 }
	 
	 private String namePath = "";
	 public String getNamePath(){
	  return this.namePath;
	 }
	 
	 public void setNamePath( String namePath){
	  this.namePath = namePath;
	 }
} 

