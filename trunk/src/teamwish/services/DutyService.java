package teamwish.services;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

import teamwish.dataContracts.common.*;

import teamwish.dataContracts.duty.*;
import teamwish.logic.duty.Buss;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;

@CheckAuth
@Path("duty")
@Api(value = "排班服务")
@ApiImplicitParams({@ApiImplicitParam(paramType = "header",dataType = "String",name = "token",value = "token信息")
})
public class DutyService {
    @Context
    HttpHeaders header;

    /***********Arrange接口服务********************/
    @ApiOperation(value = "通过ID查找排班", response = Result.class)
    @POST
    @Path("/arrange/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result<ArrangeInfo> getArrangeInfoById(int id) {
        try {
            Buss dutyLogic = new Buss();
            Result<ArrangeInfo> result = dutyLogic.GetArrangeInfoById(id);

            // System.out.println(header.getHeaderString("token"));
            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "搜索排班", response = Result.class)
    @POST
    @Path("/arrange/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<List<ArrangeInfo>> getArrangeInfoByFilter(PageFilter pf) {
        try {
            Buss dutyLogic = new Buss();
            Result<List<ArrangeInfo>> result = dutyLogic.GetArrangeInfoByFilter(pf);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "保存排班", response = Result.class)
    @POST
    @Path("/arrange/save")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<ArrangeInfo> saveArrangeInfo(ArrangeInfo arrangeInfo) {
        try {
            Buss dutyLogic = new Buss();
            Result<ArrangeInfo> result;

            result = dutyLogic.SaveArrangeInfo(arrangeInfo);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "删除排班", response = Result.class)
    @POST
    @Path("/arrange/delete")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<Integer> deleteArrangeInfo(int id) {
        try {
            Buss dutyLogic = new Buss();
            Result<Integer> result = dutyLogic.DeleteArrangeInfo(id);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    
    @ApiOperation(value = "搜索单位排班人员", response = Result.class)
    @POST
    @Path("/arrange/stationStaff")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result GetArrangeReport(Request request) {
        try {
            Buss dutyLogic = new Buss();

            return dutyLogic.GetArrangeReport(request);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "搜索单位排班人员警务类型数目", response = Result.class)
    @POST
    @Path("/arrange/stationShiftTypeCount")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result GetSubArrange(int stationId) {
        try {
            Buss dutyLogic = new Buss();

            Request request = new Request();
            request.setStationId(stationId);

            return dutyLogic.GetSubArrange(request);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    /***********警情接口服务********************/
    @ApiOperation(value = "通过ID查找警情", response = Result.class)
    @POST
    @Path("/regionService/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result<RegionService> getRegionServiceById(int id) {
        try {
            Buss dutyLogic = new Buss();
            Result<RegionService> result = dutyLogic.GetRegionServiceById(id);

            // System.out.println(header.getHeaderString("token"));
            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "搜索警情", response = Result.class)
    @POST
    @Path("/regionService/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<List<RegionService>> getRegionServiceByFilter(PageFilter pf) {
        try {
            Buss dutyLogic = new Buss();
            Result<List<RegionService>> result = dutyLogic.GetRegionServiceByFilter(pf);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
}
