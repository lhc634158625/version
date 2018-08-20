package teamwish.dataContracts.base;
import javax.xml.bind.annotation.XmlRootElement;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

@XmlRootElement
public class  ShiftType {
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
private Time fromTime ;
 public Time getFromTime(){
  return this.fromTime;
 }
 
 public void setFromTime(Time fromTime){
  this.fromTime = fromTime;
 }
private Time toTime ;
 public Time getToTime(){
  return this.toTime;
 }
 
 public void setToTime(Time toTime){
  this.toTime = toTime;
 }
private String memo ;
 public String getMemo(){
  return this.memo;
 }
 
 public void setMemo(String memo){
  this.memo = memo;
 }
private String type ;
 public String getType(){
  return this.type;
 }
 
 public void setType(String type){
  this.type = type;
 }
private String position ;
 public String getPosition(){
  return this.position;
 }
 
 public void setPosition(String position){
  this.position = position;
 }
private String pName ;
 public String getPName(){
  return this.pName;
 }
 
 public void setPName(String pName){
  this.pName = pName;
 }
} 

