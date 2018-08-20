package teamwish.dataContracts.duty;
import javax.xml.bind.annotation.XmlRootElement;
import java.sql.Date;
import java.sql.Timestamp;

@XmlRootElement
public class  RegionService {
private int id ;
 public int getId(){
  return this.id;
 }
 
 public void setId(int id){
  this.id = id;
 }
private int regionId ;
 public int getRegionId(){
  return this.regionId;
 }
 
 public void setRegionId(int regionId){
  this.regionId = regionId;
 }
private Timestamp receiveDt ;
 public Timestamp getReceiveDt(){
  return this.receiveDt;
 }
 
 public void setReceiveDt(Timestamp receiveDt){
  this.receiveDt = receiveDt;
 }
private String type ;
 public String getType(){
  return this.type;
 }
 
 public void setType(String type){
  this.type = type;
 }
private String memo ;
 public String getMemo(){
  return this.memo;
 }
 
 public void setMemo(String memo){
  this.memo = memo;
 }
private int stationId ;
 public int getStationId(){
  return this.stationId;
 }
 
 public void setStationId(int stationId){
  this.stationId = stationId;
 }
private Timestamp processDt ;
 public Timestamp getProcessDt(){
  return this.processDt;
 }
 
 public void setProcessDt(Timestamp processDt){
  this.processDt = processDt;
 }
private String reportName ;
 public String getReportName(){
  return this.reportName;
 }
 
 public void setReportName(String reportName){
  this.reportName = reportName;
 }
private String reportTel ;
 public String getReportTel(){
  return this.reportTel;
 }
 
 public void setReportTel(String reportTel){
  this.reportTel = reportTel;
 }
private String reportAddress ;
 public String getReportAddress(){
  return this.reportAddress;
 }
 
 public void setReportAddress(String reportAddress){
  this.reportAddress = reportAddress;
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
private String typeName ;
 public String getTypeName(){
  return this.typeName;
 }
 
 public void setTypeName(String typeName){
  this.typeName = typeName;
 }
private String result ;
 public String getResult(){
  return this.result;
 }
 
 public void setResult(String result){
  this.result = result;
 }
private String caseId ;
 public String getCaseId(){
  return this.caseId;
 }
 
 public void setCaseId(String caseId){
  this.caseId = caseId;
 }
private String mainEventFlag ;
 public String getMainEventFlag(){
  return this.mainEventFlag;
 }
 
 public void setMainEventFlag(String mainEventFlag){
  this.mainEventFlag = mainEventFlag;
 }
private Timestamp modifyTime ;
 public Timestamp getModifyTime(){
  return this.modifyTime;
 }
 
 public void setModifyTime(Timestamp modifyTime){
  this.modifyTime = modifyTime;
 }
private Timestamp startTime ;
 public Timestamp getStartTime(){
  return this.startTime;
 }
 
 public void setStartTime(Timestamp startTime){
  this.startTime = startTime;
 }
private String acceptUnitName ;
 public String getAcceptUnitName(){
  return this.acceptUnitName;
 }
 
 public void setAcceptUnitName(String acceptUnitName){
  this.acceptUnitName = acceptUnitName;
 }
private String acceptUnitSubRegion ;
 public String getAcceptUnitSubRegion(){
  return this.acceptUnitSubRegion;
 }
 
 public void setAcceptUnitSubRegion(String acceptUnitSubRegion){
  this.acceptUnitSubRegion = acceptUnitSubRegion;
 }
private String code ;
 public String getCode(){
  return this.code;
 }
 
 public void setCode(String code){
  this.code = code;
 }
private Timestamp firstTimeUnitName ;
 public Timestamp getFirstTimeUnitName(){
  return this.firstTimeUnitName;
 }
 
 public void setFirstTimeUnitName(Timestamp firstTimeUnitName){
  this.firstTimeUnitName = firstTimeUnitName;
 }
private String videoIds ;
 public String getVideoIds(){
  return this.videoIds;
 }
 
 public void setVideoIds(String videoIds){
  this.videoIds = videoIds;
 }
private String aY ;
 public String getAY(){
  return this.aY;
 }
 
 public void setAY(String aY){
  this.aY = aY;
 }
} 

