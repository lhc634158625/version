package teamwish.duty.services;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

import teamwish.duty.common.CheckAuth;
import teamwish.duty.dataContracts.common.PageFilter;
import teamwish.duty.dataContracts.common.ResponseCode;
import teamwish.duty.dataContracts.common.Result;
import teamwish.duty.dataContracts.base.BaseDict;
import teamwish.duty.logic.base.Buss;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@CheckAuth
@Path("base")
@Api(value = "基础服务")
@ApiImplicitParams({@ApiImplicitParam(paramType = "header",dataType = "String",name = "token",value = "token信息",required = true)
})
public class BaseService {
	
	/***********PointInfoDevice接口服务********************/
    @ApiOperation(value = "通过ID查找字典", response = Result.class)
    @POST
    @Path("/baseDict/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result getBaseDictDeviceById(int id) {
        try {
        	Buss logic = new Buss("BaseDict");

            return logic.GetById(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "搜索字典", response = Result.class)
    @POST
    @Path("/baseDict/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result getBaseDictByFilter(PageFilter pf) {
        try {
        	Buss logic = new Buss("BaseDict");

            return logic.GetByFilter(pf);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "保存字典", response = Result.class)
    @POST
    @Path("/baseDict/save")
    @Produces(MediaType.APPLICATION_JSON)
    public Result saveBaseDict(BaseDict request) {
        try {
        	Buss logic = new Buss("BaseDict");

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

    @ApiOperation(value = "删除字典", response = Result.class)
    @POST
    @Path("/baseDict/delete")
    @Produces(MediaType.APPLICATION_JSON)
    public Result deleteBaseDict(int id) {
        try {
        	Buss logic = new Buss("BaseDict");

            return logic.Delete(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }    
}
