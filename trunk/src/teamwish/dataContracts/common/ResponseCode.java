package teamwish.dataContracts.common;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(description = "返回代码")
public class ResponseCode {
	public static final int None = 1;
	
	public static final int Success = 0; 
	@ApiModelProperty(value = "其它系统错误")
	public static final int Other = 99999;
	@ApiModelProperty(value = "错误TOKEN")
	public static final int ErrorToken = 50001;// 
	@ApiModelProperty(value = "TOKEN过期")
	public static final int ExpToken = 50002;// 
	@ApiModelProperty(value = "找不到这个方法")
	public static final int NotMethod = 50003; // 
	@ApiModelProperty(value = "没有权限")
	public static final int NoAuthorize = 50004;// 
	@ApiModelProperty(value = "用户不存在")
	public static final int UserNoExit = 10010;
	public static final int PasswordError = 10020;
	public static final int UserExit = 10030;
	public static final int ErrorParam = 30000;
	public static final int SystemError = 50009; // 
	public static final int NoData = 50010; // 
	public static final int StateError = 50011; // 
}
