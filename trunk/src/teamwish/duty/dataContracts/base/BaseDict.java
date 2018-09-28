package teamwish.duty.dataContracts.base;

import java.sql.Date;
import java.sql.Timestamp;

import javax.xml.bind.annotation.XmlRootElement;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(description = "字典表")
@XmlRootElement
public class BaseDict {
	@ApiModelProperty(value = "ID")
    private int id;
	@ApiModelProperty(value = "上级ID")
	private int pid;
	@ApiModelProperty(value = "字典名")
    private String dictName;
	@ApiModelProperty(value = "编号")
    private String code;
	@ApiModelProperty(value = "名称")
    private String name;
	@ApiModelProperty(value = "参数")
	private String parameter;	
	@ApiModelProperty(value = "排序")
	private int orderIndex;
	@ApiModelProperty(value = "备注")
	private String remark;
	@ApiModelProperty(value = "ID路径")
    private String idPath;

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDictName() {
        return this.dictName;
    }

    public void setDictName(String dictName) {
        this.dictName = dictName;
    }

    public String getCode() {
        return this.code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getParameter() {
        return this.parameter;
    }

    public void setParameter(String parameter) {
        this.parameter = parameter;
    }

	

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public int getOrderIndex() {
		return orderIndex;
	}

	public void setOrderIndex(int orderIndex) {
		this.orderIndex = orderIndex;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getIdPath() {
		return idPath;
	}

	public void setIdPath(String idPath) {
		this.idPath = idPath;
	}
	
	
}
