package teamwish.dataContracts.common;

public class Condition {
	 private String fieldName;
	 public String getFieldName(){
	  return this.fieldName;
	 }
	 
	 public void setFieldName( String fieldName){
	  this.fieldName = fieldName;
	 }
	 private String fieldType;
	 public String getFieldType(){
	  return this.fieldType;
	 }
	 
	 public void setFieldType( String fieldType){
	  this.fieldType = fieldType;
	 }
	 private String opt;
	 public String getOpt(){
	  return this.opt;
	 }
	 
	 public void setOpt( String opt){
	  this.opt = opt;
	 }
	 private String value;
	 public String getValue(){
	  return this.value;
	 }
	 
	 public void setValue( String value){
	  this.value = value;
	 }

}
