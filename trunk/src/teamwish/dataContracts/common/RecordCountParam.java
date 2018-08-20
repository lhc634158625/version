package teamwish.dataContracts.common;

public class RecordCountParam {
	 private String filter;
	 public String getFilter(){
	  return this.filter;
	 }
	 
	 public void setFilter( String filter){
	  this.filter = filter;
	 }
	 private String tableName;
	 public String getTableName(){
	  return this.tableName;
	 }
	 
	 public void setTableName( String tableName){
	  this.tableName = tableName;
	 }

}
