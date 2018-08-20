package teamwish.dataContracts.base;
import javax.xml.bind.annotation.XmlRootElement;
import java.sql.Date;
import java.sql.Timestamp;

@XmlRootElement
public class  BaseDict {
private int id ;
 public int getId(){
  return this.id;
 }
 
 public void setId(int id){
  this.id = id;
 }
private String dictName ;
 public String getDictName(){
  return this.dictName;
 }
 
 public void setDictName(String dictName){
  this.dictName = dictName;
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
private String parameter ;
 public String getParameter(){
  return this.parameter;
 }
 
 public void setParameter(String parameter){
  this.parameter = parameter;
 }

} 

