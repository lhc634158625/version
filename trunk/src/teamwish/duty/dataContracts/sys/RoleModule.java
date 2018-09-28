package teamwish.duty.dataContracts.sys;
import javax.xml.bind.annotation.XmlRootElement;
import java.sql.Date;
import java.sql.Timestamp;

@XmlRootElement
public class  RoleModule {
private int id ;
 public int getId(){
  return this.id;
 }
 
 public void setId(int id){
  this.id = id;
 }
private int roleId ;
 public int getRoleId(){
  return this.roleId;
 }
 
 public void setRoleId(int roleId){
  this.roleId = roleId;
 }
private int moduleId ;
 public int getModuleId(){
  return this.moduleId;
 }
 
 public void setModuleId(int moduleId){
  this.moduleId = moduleId;
 }
} 

