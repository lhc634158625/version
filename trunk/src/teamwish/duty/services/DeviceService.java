package teamwish.duty.services;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import teamwish.duty.common.CheckAuth;
import teamwish.duty.dataContracts.common.PageFilter;
import teamwish.duty.dataContracts.common.ResponseCode;
import teamwish.duty.dataContracts.common.Result;
import teamwish.duty.dataContracts.device.DeviceInfo;
import teamwish.duty.logic.device.Buss;

import javax.ws.rs.Consumes;
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
	
	/***********DeviceService接口服务********************/
    @ApiOperation(value = "通过ID查找设备", response = Result.class)
    @POST
    @Path("/deviceInfo/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result getdeviceInfoDeviceById(int id) {
        try {
        	Buss logic = new Buss("DeviceInfo");

            return logic.GetById(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "搜索设备", response = Result.class)
    @POST
    @Path("/deviceInfo/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result getdeviceInfoByFilter(PageFilter pf) {
        try {
        	Buss logic = new Buss("DeviceInfo");

            return logic.GetByFilter(pf);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "保存设备", response = Result.class)
    @POST
    @Path("/deviceInfo/save")
    @Produces(MediaType.APPLICATION_JSON)
    public Result savedeviceInfo(DeviceInfo request) {
        try {
        	Buss logic = new Buss("DeviceInfo");

            if (request.getId() > 0) {
                int count = logic.Save(request);

                if (count == 0) {
                    return new Result(0);
                }

                return logic.GetById(request.getId());
            }

            Object _id = logic.Insert(request);

            if (_id == null) {
                return new Result(0);
            }

            int id = Integer.parseInt(_id.toString());

            return logic.GetById(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "删除设备", response = Result.class)
    @POST
    @Path("/deviceInfo/delete")
    @Produces(MediaType.APPLICATION_JSON)
    public Result deletedeviceInfo(int id) {
        try {
        	Buss logic = new Buss("DeviceInfo");

            return logic.Delete(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }   
    
    /***********摄像头接口服务********************/
    @POST
    @ApiOperation(value = "通过条件分页查询摄像头", response = Result.class)
     @Path("/cameraInfo/filter")
     @Produces(MediaType.APPLICATION_JSON)
     public Result getCameraInfoByFilter(PageFilter pf) {
      try {
       Buss logic= new Buss("CameraInfo");
       return logic.GetByFilter(pf);
      } catch (Exception ex) {
       return new Result(ResponseCode.SystemError, ex.getMessage());
      }
     }
}
