package teamwish.duty.dataContracts.common;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;


@ApiModel(description = "统一返回信息")
public class Result {
    @ApiModelProperty(value = "编码")
    private int code;
    @ApiModelProperty(value = "消息")
    private String message = "";
    @ApiModelProperty(value = "数据")
    private Object data;

    public Result() {
        setCode(ResponseCode.Success);
        setMessage("Success");
    }

    public Result(Object data) {
        setCode(ResponseCode.Success);
        setMessage("Success");
        setData(data);
    }

    public Result(int code, String message) {
        setCode(code);
        setMessage(message);
    }

    public int getCode() {
        return this.code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return this.message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getData() {
        return this.data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
