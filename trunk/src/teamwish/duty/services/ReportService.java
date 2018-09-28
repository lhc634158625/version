package teamwish.duty.services;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

import teamwish.duty.common.CheckAuth;
import teamwish.duty.dataContracts.common.ResponseCode;
import teamwish.duty.dataContracts.common.Result;
import teamwish.duty.dataContracts.report.RequestReport;
import teamwish.duty.logic.report.Buss;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@CheckAuth
@Path("report")
@Api(value = "报表服务")
@ApiImplicitParams({@ApiImplicitParam(paramType = "header",dataType = "String",name = "token",value = "token信息",required = true)
})
public class ReportService {
	
	/***********PointInfoDevice接口服务********************/
    @ApiOperation(value = "勤务态势报表", response = Result.class)
    @POST
    @Path("/stationReport/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result GetStationReport(RequestReport request) {
        try {
        	Buss logic = new Buss("");
        	return new Result(logic.GetStationReport(request));
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

   
}
