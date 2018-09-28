package teamwish.duty.dataContracts.duty;
import javax.xml.bind.annotation.XmlRootElement;
import java.sql.Date;
import java.sql.Timestamp;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@XmlRootElement
@ApiModel(description = "InterceptPoint信息")
public class  InterceptPoint {
@ApiModelProperty(value = "id")
private Integer id ;
 public Integer getId(){
  return this.id;
 }
 
 public void setId(Integer id){
  this.id = id;
 }
@ApiModelProperty(value = "类型")
private Integer type ;
 public Integer getType(){
  return this.type;
 }
 
 public void setType(Integer type){
  this.type = type;
 }
@ApiModelProperty(value = "点位ID")
private Integer pointInfoId ;
 public Integer getPointInfoId(){
  return this.pointInfoId;
 }
 
 public void setPointInfoId(Integer pointInfoId){
  this.pointInfoId = pointInfoId;
 }
@ApiModelProperty(value = "任务ID")
private Integer interceptTaskId ;
 public Integer getInterceptTaskId(){
  return this.interceptTaskId;
 }
 
 public void setInterceptTaskId(Integer interceptTaskId){
  this.interceptTaskId = interceptTaskId;
 }
@ApiModelProperty(value = " 备注")
private String memo ;
 public String getMemo(){
  return this.memo;
 }
 
 public void setMemo(String memo){
  this.memo = memo;
 }
} 

