package teamwish.duty.dataContracts.base;
import javax.xml.bind.annotation.XmlRootElement;
import java.sql.Date;
import java.sql.Timestamp;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
@XmlRootElement
@ApiModel(description = "Attachment信息")
public class  Attachment {
@ApiModelProperty(value = "id")
private int id ;
 public int getId(){
  return this.id;
 }
 
 public void setId(int id){
  this.id = id;
 }
@ApiModelProperty(value = "attachURL")
private String attachURL ;
 public String getAttachURL(){
  return this.attachURL;
 }
 
 public void setAttachURL(String attachURL){
  this.attachURL = attachURL;
 }
@ApiModelProperty(value = "文件名")
private String fileName ;
 public String getFileName(){
  return this.fileName;
 }
 
 public void setFileName(String fileName){
  this.fileName = fileName;
 }
@ApiModelProperty(value = "长度")
private String length ;
 public String getLength(){
  return this.length;
 }
 
 public void setLength(String length){
  this.length = length;
 }
@ApiModelProperty(value = "类型")
private String conentType ;
 public String getConentType(){
  return this.conentType;
 }
 
 public void setConentType(String conentType){
  this.conentType = conentType;
 }
@ApiModelProperty(value = "归属Id")
private int ownerId ;
 public int getOwnerId(){
  return this.ownerId;
 }
 
 public void setOwnerId(int ownerId){
  this.ownerId = ownerId;
 }
@ApiModelProperty(value = "归属类型")
private String ownerType ;
 public String getOwnerType(){
  return this.ownerType;
 }
 
 public void setOwnerType(String ownerType){
  this.ownerType = ownerType;
 }
@ApiModelProperty(value = "创建人")
private int creater ;
 public int getCreater(){
  return this.creater;
 }
 
 public void setCreater(int creater){
  this.creater = creater;
 }
@ApiModelProperty(value = "创建时间")
private Timestamp created ;
 public Timestamp getCreated(){
  return this.created;
 }
 
 public void setCreated(Timestamp created){
  this.created = created;
 }
} 

