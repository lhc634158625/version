package teamwish.duty.dataContracts.duty;
import javax.xml.bind.annotation.XmlRootElement;
import java.sql.Date;
import java.sql.Timestamp;

@XmlRootElement
public class  StaffPositionShiftReport {
	 
	 private String code;
	 public String getCode(){
	  return this.code;
	 }
	 
	 public void setCode( String code){
	  this.code = code;
	 }
	 
	 
	 private String name;
	 public String getStationName(){
	  return this.name;
	 }
	 
	 public void setStationName( String name){
	  this.name = name;
	 }
	 
	 private String type;
	 public String getType(){
	  return this.type;
	 }
	 
	 public void setType( String type){
	  this.type = type;
	 }	 
	 
	 private int count;
	 public int getCount(){
	  return this.count;
	 }
	 
	 public void setCount( int count){
	  this.count = count;
	 }	 

} 

