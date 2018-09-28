package teamwish.duty.services;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

import teamwish.duty.common.CheckAuth;
import teamwish.duty.dataContracts.map.*;
import teamwish.duty.dataContracts.common.*;
import teamwish.duty.logic.map.Buss;

import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@CheckAuth
@Path("map")
@Api(value = "地图服务")
@ApiImplicitParams({@ApiImplicitParam(paramType = "header",dataType = "String",name = "token",value = "token信息",required = true)
})
public class MapService {
    /***********PointInfo服务********************/
	@ApiOperation(value = "通过ID查找点位", response = Result.class)
    @POST
    @Path("/pointInfo/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result<PointInfo> getPointInfoById(int id) {
        try {
            Buss mapLogic = new Buss();
            Result<PointInfo> result = mapLogic.GetPointInfoById(id);

            // System.out.println(header.getHeaderString("token"));
            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

	@ApiOperation(value = "搜索点位", response = Result.class)
    @POST
    @Path("/pointInfo/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<List<PointInfo>> getPointInfoByFilter(PageFilter pf) {
        try {
            Buss mapLogic = new Buss();
            Result<List<PointInfo>> result = mapLogic.GetPointInfoByFilter(pf);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

	@ApiOperation(value = "保存点位", response = Result.class)
    @POST
    @Path("/pointInfo/save")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<PointInfo> savePointInfo(PointInfo pointInfo) {
        try {
            Buss mapLogic = new Buss();
            Result<PointInfo> result;

            result = mapLogic.SavePointInfo(pointInfo);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

	@ApiOperation(value = "删除点位", response = Result.class)
    @POST
    @Path("/pointInfo/delete")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<Integer> deletePointInfo(int id) {
        try {
            Buss mapLogic = new Buss();
            Result<Integer> result = mapLogic.DeletePointInfo(id);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
}
