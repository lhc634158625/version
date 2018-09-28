package teamwish.duty.dataContracts.common;

import io.swagger.annotations.ApiModelProperty;

public class PageFilter {
	@ApiModelProperty(value = "第几页,起始页为:1")
	private int page = 1;
    @ApiModelProperty(value = "每页大小")
    private int pageSize = 10;
    @ApiModelProperty(value = "排序字段")
    private String orderField = "id";
    @ApiModelProperty(value = "搜索条件")
    private Condition[] conditions = null;
    
    @ApiModelProperty(hidden = true)
    private int fromRecord;
    @ApiModelProperty(hidden = true)
    private int toRecord;
    @ApiModelProperty(hidden = true)
    private String filter;  
    @ApiModelProperty(hidden = true)
    private String tableName;
    @ApiModelProperty(hidden = true)
    private int pid; 
    

    public int getPage() {
        return this.page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getPageSize() {
        return this.pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
    
    

    public String getOrderField() {
        return this.orderField;
    }

    public void setOrderField(String orderField) {
        this.orderField = orderField;
    }

    public Condition[] getConditions() {
        return this.conditions;
    }

    public void setConditions(Condition[] conditions) {
        this.conditions = conditions;
    }

    public int getFromRecord() {
        return this.fromRecord;
    }

    public void setFromRecord(int fromRecord) {
        this.fromRecord = fromRecord;
    }

    public int getToRecord() {
        return this.toRecord;
    }

    public void setToRecord(int toRecord) {
        this.toRecord = toRecord;
    }
    
    public String getFilter() {
        return this.filter;
    }

    public void setFilter(String filter) {
        this.filter = filter;
    }
    
    public String getTableName() {
        return this.tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}
    
    public String getFieldValue(String fieldName, String opt) {
    	Condition[] conditions = this.getConditions();
    	if(conditions == null) return "";
    	
    	String value = null;
    	for(Condition condition : conditions) {
    		if(condition.getFieldName().equals(fieldName)  && condition.getOpt().equals(opt)) {
    			value = condition.getValue();
    			break;
    		}
    	}
    	
    	return value;
    }
    
    public void setFieldValue(Condition condition) { 
    	Condition[] conditions = this.getConditions();
    	if(conditions == null) {
    		this.setConditions(new Condition[] {condition });
    		return;
    	}
    	
    	for(Condition item : conditions) {
    		if(item.getFieldName().equals(condition.getFieldName())) {
    			item.setFieldType(condition.getFieldType());
    			item.setOpt(condition.getOpt());
    			item.setValue(condition.getValue());
    			break;
    		}
    	}    	
    }
}
