package teamwish.duty.common;

import javax.json.stream.JsonParsingException;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

import teamwish.duty.dataContracts.common.ResponseCode;
import teamwish.duty.dataContracts.common.Result;

@Provider
public class MyExceptionMapper implements ExceptionMapper<Exception>{

	@Override
	public Response toResponse(Exception exception) {
		// TODO Auto-generated method stub
		exception.printStackTrace();	
		if(exception instanceof JsonParsingException) {
			Result result = new Result(ResponseCode.ErrorParam, "错误的参数");		
			return Response.ok(result).build();
		}
		else {
			Result result = new Result(ResponseCode.SystemError, exception.getMessage());		
			return Response.ok(result).build();
		}
	}

}
