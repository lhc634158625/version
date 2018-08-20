package teamwish.dataContracts.common;

public class PageFilter<T> {


	 private int fromRecord;
	 public int getFromRecord(){
	  return this.fromRecord;
	 }
	 
	 public void setFromRecord( int fromRecord){
	  this.fromRecord = fromRecord;
	 }
	 private int toRecord;
	 public int getToRecord(){
	  return this.toRecord;
	 }
	 
	 public void setToRecord( int toRecord){
	  this.toRecord = toRecord;
	 }

	 private int pageSize;
	 public int getPageSize(){
	  return this.pageSize;
	 }
	 
	 public void setPageSize( int pageSize){
	  this.pageSize = pageSize;
	 }
	 private String filter;
	 public String getFilter(){
	  return this.filter;
	 }
	 
	 public void setFilter( String filter){
	  this.filter = filter;
	 }
	 private String orderField;
	 public String getOrderField(){
	  return this.orderField;
	 }
	 
	 public void setOrderField( String orderField){
	  this.orderField = orderField;
	 }
	 private Condition[] conditions;
	 public Condition[] getConditions(){
	  return this.conditions;
	 }
	 
	 public void setConditions( Condition[] conditions){
	  this.conditions = conditions;
	 }
	 private String tableName;
	 public String getTableName(){
	  return this.tableName;
	 }
	 
	 public void setTableName( String tableName){
	  this.tableName = tableName;
	 }


}
