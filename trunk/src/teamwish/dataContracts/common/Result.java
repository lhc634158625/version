package teamwish.dataContracts.common;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(description = "统一返回信息")
public class Result<T> {
	public Result() {
		setCode(ResponseCode.Success);
		setMessage("Success");
	
	}
	public Result(T data) {
		setCode(ResponseCode.Success);
		setMessage("Success");
		setData(data);
	}
	public Result(int code,String message) {
	setCode(code);
	setMessage(message);
	}
	
	@ApiModelProperty(value = "编码")
	private int code;
	public int getCode(){
		return this.code;
	}
	
	public void setCode(int code){
		this.code = code;
	}
	
	@ApiModelProperty(value = "消息")
	private String message = "";
	public String getMessage(){
		return this.message;
	}
	
	public void setMessage(String message){
		this.message = message;
	}
	
	@ApiModelProperty(value = "数据")
	private T data ;
	public T getData(){
		return this.data;
	}
	
	public void setData(T data){
		this.data = data;
	}
}
