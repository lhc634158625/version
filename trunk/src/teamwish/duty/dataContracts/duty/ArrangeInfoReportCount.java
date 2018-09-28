package teamwish.duty.dataContracts.duty;
import javax.xml.bind.annotation.XmlRootElement;
import java.sql.Date;
import java.sql.Timestamp;

@XmlRootElement
public class  ArrangeInfoReportCount {
	 
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
	 
	 private int count = 0;
	 public int getCount(){
	  return this.count;
	 }
	 
	 public void setCount(int count){
	  this.count = count;
	 }
	 
	 
	 private int orderIndex = 0;
	 public int getOrderIndex(){
	  return this.orderIndex;
	 }
	 
	 public void setOrderIndex(int orderIndex){
	  this.orderIndex = orderIndex;
	 }
} 

