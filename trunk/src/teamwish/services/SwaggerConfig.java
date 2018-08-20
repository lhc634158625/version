package teamwish.services;

import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.Contact;
import io.swagger.annotations.Info;
import io.swagger.annotations.SwaggerDefinition;

import javax.ws.rs.ext.Provider;

@Provider
@SwaggerDefinition(
        info = @Info(
                description = "公安可视化系统API",
                version = "V1.0.0",
                title = "公安可视化系统API",
                contact = @Contact(
                   name = "远国"
                )
        ))
@ApiImplicitParams(value = {@ApiImplicitParam(paramType = "header", dataType = "String", name = "token", value = "token信息")} 
		)

public interface SwaggerConfig {
	 
}
