package teamwish.duty.services;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

import teamwish.duty.common.CheckAuth;
import teamwish.duty.dataContracts.common.PageFilter;
import teamwish.duty.dataContracts.common.ResponseCode;
import teamwish.duty.dataContracts.common.Result;
import teamwish.duty.logic.base.Buss;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@CheckAuth
@Path("case")
@Api(value = "警情服务")
@ApiImplicitParams({@ApiImplicitParam(paramType = "header",dataType = "String",name = "token",value = "token信息",required = true)
})
public class CaseService {
	
	/***********警情接口服务********************/
    @ApiOperation(value = "通过ID查找警情", response = Result.class)
    @POST
    @Path("/regionService/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result getRegionServiceById(int id) {
        try {
        	Buss logic = new Buss("RegionService");

            return logic.GetById(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "搜索警情", response = Result.class)
    @POST
    @Path("/regionService/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result getRegionServiceByFilter(PageFilter pf) {
        try {
        	Buss logic = new Buss("RegionService");

            return logic.GetByFilter(pf);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
    
    
    /***********案件回访接口服务********************/
   
}
