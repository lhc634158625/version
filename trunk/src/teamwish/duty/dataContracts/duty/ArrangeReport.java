package teamwish.duty.dataContracts.duty;
import javax.xml.bind.annotation.XmlRootElement;
import java.sql.Date;
import java.sql.Timestamp;

@XmlRootElement
public class  ArrangeReport {
	 private int stationId;
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
	 
	 private String shiftName;
	 public String getShiftName(){
	  return this.shiftName;
	 }
	 
	 public void setShiftName( String shiftName){
	  this.shiftName = shiftName;
	 }
	 private int shiftId;
	 public int getShiftId(){
	  return this.shiftId;
	 }
	 
	 public void setShiftId( int shiftId){
	  this.shiftId = shiftId;
	 }
	 private int rc;
	 public int getRc(){
	  return this.rc;
	 }
	 
	 public void setRc( int rc){
	  this.rc = rc;
	 }


} 

