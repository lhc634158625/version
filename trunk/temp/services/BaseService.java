package teamwish.duty.services;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

import teamwish.duty.common.CheckAuth;
import teamwish.duty.dataContracts.base.*;
import teamwish.duty.dataContracts.common.*;
import teamwish.duty.logic.base.Buss;

import java.util.List;

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

    /***********基本字典********************/
    @ApiOperation(value = "通过ID查找字典", response = Result.class)
    @POST
    @Path("/baseDict/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result<BaseDict> getBaseDictById(int id) {
        try {
            Buss baseLogic = new Buss();
            Result<BaseDict> result = baseLogic.GetBaseDictById(id);

            // System.out.println(header.getHeaderString("token"));
            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "搜索字典", response = Result.class)
    @POST
    @Path("/baseDict/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<List<BaseDict>> getBaseDictByFilter(PageFilter pf) {
        try {
            Buss baseLogic = new Buss();
            Result<List<BaseDict>> result = baseLogic.GetBaseDictByFilter(pf);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "保存字典", response = Result.class)
    @POST
    @Path("/baseDict/save")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<BaseDict> saveBaseDict(BaseDict baseDict) {
        try {
            Buss baseLogic = new Buss();
            Result<BaseDict> result;

            result = baseLogic.SaveBaseDict(baseDict);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "删除字典", response = Result.class)
    @POST
    @Path("/baseDict/delete")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<Integer> deleteBaseDict(int id) {
        try {
            Buss baseLogic = new Buss();
            Result<Integer> result = baseLogic.DeleteBaseDict(id);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
    /***********附件信息********************/
    @POST
    @ApiOperation(value = "通过主健查询附件", response = Result.class)
     @Path("/attachment/get")
     @Produces(MediaType.APPLICATION_JSON)
     @Consumes(MediaType.APPLICATION_JSON)
     public Result<Attachment> getAttachmentById(int id) {
      try {
       Buss baseLogic = new Buss();
       Result<Attachment> result = baseLogic.GetAttachmentById(id);
       // System.out.println(header.getHeaderString("token"));
       return result;
      } catch (Exception ex) {
       return new Result(ResponseCode.SystemError, ex.getMessage());
      }
     }

     @POST
    @ApiOperation(value = "通过条件分页查询附件", response = Result.class)
     @Path("/attachment/filter")
     @Produces(MediaType.APPLICATION_JSON)
     public Result<List<Attachment>> getAttachmentByFilter(PageFilter pf) {
      try {
       Buss baseLogic = new Buss();
       Result<List<Attachment>> result = baseLogic.GetAttachmentByFilter(pf);
       return result;
      } catch (Exception ex) {
       return new Result(ResponseCode.SystemError, ex.getMessage());
      }
     }

     @POST
    @ApiOperation(value = "保存附件", response = Result.class)
     @Path("/attachment/save")
     @Produces(MediaType.APPLICATION_JSON)
     public Result<Attachment> saveAttachment(Attachment attachment) {
      try {
       Buss baseLogic = new Buss();
       Result<Attachment> result;

       result = baseLogic.SaveAttachment(attachment);
       return result;

      } catch (Exception ex) {
       return new Result(ResponseCode.SystemError, ex.getMessage());
      }

     }

     @POST
     @Path("/attachment/delete")
    @ApiOperation(value = "删除附件", response = Result.class)
     @Produces(MediaType.APPLICATION_JSON)
     public Result<Integer> deleteAttachment(int id) {
      try {
       Buss baseLogic = new Buss();
       Result<Integer> result = baseLogic.DeleteAttachment(id);
       return result;
      } catch (Exception ex) {
       return new Result(ResponseCode.SystemError, ex.getMessage());
      }
     }
}
