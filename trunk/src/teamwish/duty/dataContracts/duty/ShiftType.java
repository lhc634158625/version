package teamwish.duty.dataContracts.duty;
import javax.xml.bind.annotation.XmlRootElement;
import java.sql.Date;
import java.sql.Timestamp;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@XmlRootElement
@ApiModel(description = "ShiftType信息")
public class  ShiftType {
@ApiModelProperty(value = "id")
private Integer id ;
 public Integer getId(){
  return this.id;
 }
 
 public void setId(Integer id){
  this.id = id;
 }
@ApiModelProperty(value = "上级Id")
private Integer pId ;
 public Integer getPId(){
  return this.pId;
 }
 
 public void setPId(Integer pId){
  this.pId = pId;
 }
@ApiModelProperty(value = "code")
private String code ;
 public String getCode(){
  return this.code;
 }
 
 public void setCode(String code){
  this.code = code;
 }
@ApiModelProperty(value = "名称")
private String name ;
 public String getName(){
  return this.name;
 }
 
 public void setName(String name){
  this.name = name;
 }
@ApiModelProperty(value = "备注")
private String memo ;
 public String getMemo(){
  return this.memo;
 }
 
 public void setMemo(String memo){
  this.memo = memo;
 }
@ApiModelProperty(value = "orderIndex")
private Integer orderIndex ;
 public Integer getOrderIndex(){
  return this.orderIndex;
 }
 
 public void setOrderIndex(Integer orderIndex){
  this.orderIndex = orderIndex;
 }
@ApiModelProperty(value = "isDefaultShow")
private Integer isDefaultShow ;
 public Integer getIsDefaultShow(){
  return this.isDefaultShow;
 }
 
 public void setIsDefaultShow(Integer isDefaultShow){
  this.isDefaultShow = isDefaultShow;
 }
@ApiModelProperty(value = "isShow")
private Integer isShow ;
 public Integer getIsShow(){
  return this.isShow;
 }
 
 public void setIsShow(Integer isShow){
  this.isShow = isShow;
 }
@ApiModelProperty(value = "stationId")
private String stationId ;
 public String getStationId(){
  return this.stationId;
 }
 
 public void setStationId(String stationId){
  this.stationId = stationId;
 }
@ApiModelProperty(value = "creater")
private Integer creater ;
 public Integer getCreater(){
  return this.creater;
 }
 
 public void setCreater(Integer creater){
  this.creater = creater;
 }
@ApiModelProperty(value = "created")
private Timestamp created ;
 public Timestamp getCreated(){
  return this.created;
 }
 
 public void setCreated(Timestamp created){
  this.created = created;
 }
@ApiModelProperty(value = "updater")
private Integer updater ;
 public Integer getUpdater(){
  return this.updater;
 }
 
 public void setUpdater(Integer updater){
  this.updater = updater;
 }
@ApiModelProperty(value = "updateDt")
private Timestamp updateDt ;
 public Timestamp getUpdateDt(){
  return this.updateDt;
 }
 
 public void setUpdateDt(Timestamp updateDt){
  this.updateDt = updateDt;
 }
} 

