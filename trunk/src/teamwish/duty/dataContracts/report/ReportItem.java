package teamwish.duty.dataContracts.report;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(description = "报表项目")
public class ReportItem {
	@ApiModelProperty(value = "名称")
	private String name;
	@ApiModelProperty(value = "值类型,string/number")
	private String type;
	@ApiModelProperty(value = "内容")
	private Double value;

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Double getValue() {
		return this.value;
	}

	public void setValue(Double value) {
		this.value = value;
	}
	@ApiModelProperty(value = "分组名称")
	 private String groupName;
	 public String getGroupName(){
	  return this.groupName;
	 }
	 
	 public void setGroupName( String groupName){
	  this.groupName = groupName;
	 }

	 
}
