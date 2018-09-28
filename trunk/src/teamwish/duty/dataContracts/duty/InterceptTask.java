package teamwish.duty.dataContracts.duty;
import javax.xml.bind.annotation.XmlRootElement;
import java.sql.Date;
import java.sql.Timestamp;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@XmlRootElement
@ApiModel(description = "InterceptTask信息")
public class  InterceptTask {
@ApiModelProperty(value = "id")
private Integer id ;
 public Integer getId(){
  return this.id;
 }
 
 public void setId(Integer id){
  this.id = id;
 }
@ApiModelProperty(value = "任务名称")
private String name ;
 public String getName(){
  return this.name;
 }
 
 public void setName(String name){
  this.name = name;
 }
@ApiModelProperty(value = "编码")
private String code ;
 public String getCode(){
  return this.code;
 }
 
 public void setCode(String code){
  this.code = code;
 }
@ApiModelProperty(value = "类型")
private Integer type ;
 public Integer getType(){
  return this.type;
 }
 
 public void setType(Integer type){
  this.type = type;
 }
@ApiModelProperty(value = "状态：启用；停用")
private String state ;
 public String getState(){
  return this.state;
 }
 
 public void setState(String state){
  this.state = state;
 }
@ApiModelProperty(value = "起始时间")
private Timestamp fromTime ;
 public Timestamp getFromTime(){
  return this.fromTime;
 }
 
 public void setFromTime(Timestamp fromTime){
  this.fromTime = fromTime;
 }
@ApiModelProperty(value = "截止时间")
private Timestamp toTime ;
 public Timestamp getToTime(){
  return this.toTime;
 }
 
 public void setToTime(Timestamp toTime){
  this.toTime = toTime;
 }
@ApiModelProperty(value = "负责单位ID")
private Integer stationId ;
 public Integer getStationId(){
  return this.stationId;
 }
 
 public void setStationId(Integer stationId){
  this.stationId = stationId;
 }
@ApiModelProperty(value = "负责单位名称")
private String stationName ;
 public String getStationName(){
  return this.stationName;
 }
 
 public void setStationName(String stationName){
  this.stationName = stationName;
 }
@ApiModelProperty(value = "负责人ID")
private Integer leaderId ;
 public Integer getLeaderId(){
  return this.leaderId;
 }
 
 public void setLeaderId(Integer leaderId){
  this.leaderId = leaderId;
 }
@ApiModelProperty(value = "负责人")
private String leader ;
 public String getLeader(){
  return this.leader;
 }
 
 public void setLeader(String leader){
  this.leader = leader;
 }
@ApiModelProperty(value = "负表人警号")
private String leaderCode ;
 public String getLeaderCode(){
  return this.leaderCode;
 }
 
 public void setLeaderCode(String leaderCode){
  this.leaderCode = leaderCode;
 }
@ApiModelProperty(value = "电话")
private String phone ;
 public String getPhone(){
  return this.phone;
 }
 
 public void setPhone(String phone){
  this.phone = phone;
 }
@ApiModelProperty(value = "负责人ID")
private Integer contactPersonId ;
 public Integer getContactPersonId(){
  return this.contactPersonId;
 }
 
 public void setContactPersonId(Integer contactPersonId){
  this.contactPersonId = contactPersonId;
 }
@ApiModelProperty(value = "联系人")
private String contactPerson ;
 public String getContactPerson(){
  return this.contactPerson;
 }
 
 public void setContactPerson(String contactPerson){
  this.contactPerson = contactPerson;
 }
@ApiModelProperty(value = "联系人警号")
private String contactPersonCode ;
 public String getContactPersonCode(){
  return this.contactPersonCode;
 }
 
 public void setContactPersonCode(String contactPersonCode){
  this.contactPersonCode = contactPersonCode;
 }
@ApiModelProperty(value = "联系人电话")
private String contactPhone ;
 public String getContactPhone(){
  return this.contactPhone;
 }
 
 public void setContactPhone(String contactPhone){
  this.contactPhone = contactPhone;
 }
@ApiModelProperty(value = "要求人数")
private Integer count ;
 public Integer getCount(){
  return this.count;
 }
 
 public void setCount(Integer count){
  this.count = count;
 }
@ApiModelProperty(value = "备注")
private String memo ;
 public String getMemo(){
  return this.memo;
 }
 
 public void setMemo(String memo){
  this.memo = memo;
 }
@ApiModelProperty(value = "创建人")
private Integer creater ;
 public Integer getCreater(){
  return this.creater;
 }
 
 public void setCreater(Integer creater){
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
@ApiModelProperty(value = "更新人")
private Integer updater ;
 public Integer getUpdater(){
  return this.updater;
 }
 
 public void setUpdater(Integer updater){
  this.updater = updater;
 }
@ApiModelProperty(value = "更新时间")
private Timestamp updateDt ;
 public Timestamp getUpdateDt(){
  return this.updateDt;
 }
 
 public void setUpdateDt(Timestamp updateDt){
  this.updateDt = updateDt;
 }
} 

