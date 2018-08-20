package teamwish.services;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import teamwish.dataContracts.common.*;

import teamwish.dataContracts.device.*;

import teamwish.dataContracts.sys.UserInfo;

import teamwish.logic.device.*;

import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@CheckAuth
@Path("device")
@Api(value = "设备服务")
@ApiImplicitParams({@ApiImplicitParam(paramType = "header",dataType = "String",name = "token",value = "token信息",required = true)
})
public class DeviceService {
	
	@ApiOperation(value = "通过ID查找设备", response = Result.class)
    @POST
    @Path("/deviceInfo/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result<DeviceInfo> getDeviceInfoById(int id) {
        try {
            Buss deviceLogic = new Buss();
            Result<DeviceInfo> result = deviceLogic.GetDeviceInfoById(id);

            // System.out.println(header.getHeaderString("token"));
            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

	@ApiOperation(value = "搜索设备", response = Result.class)
    @POST
    @Path("/deviceInfo/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<List<DeviceInfo>> getDeviceInfoByFilter(PageFilter pf) {
        try {
            Buss deviceLogic = new Buss();
            Result<List<DeviceInfo>> result = deviceLogic.GetDeviceInfoByFilter(pf);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

	@ApiOperation(value = "保存设备", response = Result.class)
    @POST
    @Path("/deviceInfo/save")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<DeviceInfo> saveDeviceInfo(DeviceInfo deviceInfo) {
        try {
            Buss deviceLogic = new Buss();
            Result<DeviceInfo> result;

            result = deviceLogic.SaveDeviceInfo(deviceInfo);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

	@ApiOperation(value = "删除设备", response = Result.class)
    @POST
    @Path("/deviceInfo/delete")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<Integer> deleteDeviceInfo(int id) {
        try {
            Buss deviceLogic = new Buss();
            Result<Integer> result = deviceLogic.DeleteDeviceInfo(id);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
}
