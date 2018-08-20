package teamwish.services;

import java.io.IOException;
import javax.annotation.Priority;
import javax.ws.rs.Priorities;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.Provider;

import teamwish.dataContracts.common.ResponseCode;
import teamwish.dataContracts.common.Result;
import teamwish.logic.sys.Buss;

 

@Priority(Priorities.AUTHENTICATION)
@Provider
@CheckAuth
public class AuthFilter implements ContainerRequestFilter {
 
    @Override
    public void filter(ContainerRequestContext requestContext)
            throws IOException {    
    	
    	String url = requestContext.getUriInfo().getRequestUri().toURL().toString();
    	if(url.endsWith("sys/user/login")) {
    		return;
    	}
    	
    	String token = requestContext.getHeaderString("token");
    	 if(token == null || token.length() == 0) {
         	Response response = Response.ok(new Result(ResponseCode.ErrorToken, "错误的Token")).status(401).type(MediaType.APPLICATION_JSON).build();
 			throw new WebApplicationException(response);
        }
        
    	 Buss sysLogic = new Buss();
    	 int code = sysLogic.GetUserInfoByToken(token);
    	
    	 if(code == ResponseCode.Success){
    		 sysLogic.UpdateUserTokenDt(token);
    	 }
    	 else if(code == ResponseCode.ExpToken){
    		 Response response = Response.ok(new Result(ResponseCode.ExpToken, "过期的Token")).status(401).type(MediaType.APPLICATION_JSON).build();
  			throw new WebApplicationException(response);
    	 }
    	 else if(code == ResponseCode.ErrorToken){
    		Response response = Response.ok(new Result(ResponseCode.ErrorToken, "错误的Token")).status(401).type(MediaType.APPLICATION_JSON).build();
  			throw new WebApplicationException(response);
    	 }
    	 else {
    		 Response response = Response.ok(new Result(ResponseCode.Other, "系统错误")).status(401).type(MediaType.APPLICATION_JSON).build();
   			throw new WebApplicationException(response);
    	 }
    }
}
