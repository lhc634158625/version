package teamwish.duty.dataContracts.common;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(description = "条件类")
public class Condition {
	@ApiModelProperty(value = "字段名称")
    private String fieldName;
	@ApiModelProperty(value = "字段类型")
    private String fieldType;
	@ApiModelProperty(value = "操作符：=;&gt;=;&lt;=;in;not in;is;is not;包含;前包含;后包含")
    private String opt;
	@ApiModelProperty(value = "内容")
    private String value;

    public String getFieldName() {
        return this.fieldName;
    }

    public void setFieldName(String fieldName) {
        this.fieldName = fieldName;
    }

    public String getFieldType() {
        return this.fieldType;
    }

    public void setFieldType(String fieldType) {
        this.fieldType = fieldType;
    }

    public String getOpt() {
        return this.opt;
    }

    public void setOpt(String opt) {
        this.opt = opt;
    }

    public String getValue() {
        return this.value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
