package teamwish.duty.services;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

import teamwish.duty.common.CheckAuth;

import teamwish.duty.dataContracts.cases.Callback;
import teamwish.duty.dataContracts.cases.CallbackCheck;
import teamwish.duty.dataContracts.cases.CaseInfo;
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
    @POST
    @ApiOperation(value = "通过主健查询案件回访", response = Result.class)
    @Path("/callback/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result getCallbackById(int id) {
        try {
            Buss logic = new Buss("Callback");

            return logic.GetById(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @POST
    @ApiOperation(value = "通过条件分页查询案件回访", response = Result.class)
    @Path("/callback/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result getCallbackByFilter(PageFilter pf) {
        try {
            Buss logic = new Buss("Callback");

            return logic.GetByFilter(pf);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @POST
    @ApiOperation(value = "保存案件回访", response = Result.class)
    @Path("/callback/save")
    @Produces(MediaType.APPLICATION_JSON)
    public Result saveCallback(Callback request) {
        try {
            Buss logic = new Buss("Callback");

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

    @POST
    @Path("/callback/delete")
    @ApiOperation(value = "删除案件回访", response = Result.class)
    @Produces(MediaType.APPLICATION_JSON)
    public Result deleteCallback(int id) {
        try {
            Buss logic = new Buss("Callback");

            return logic.Delete(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @POST
    @ApiOperation(value = "通过主健查询案件信息", response = Result.class)
    @Path("/caseInfo/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result getCaseInfoById(int id) {
        try {
            Buss logic = new Buss("CaseInfo");

            return logic.GetById(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @POST
    @ApiOperation(value = "通过条件分页查询案件信息", response = Result.class)
    @Path("/caseInfo/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result getCaseInfoByFilter(PageFilter pf) {
        try {
            Buss logic = new Buss("CaseInfo");

            return logic.GetByFilter(pf);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    /***********案件回访抽查服务********************/
    @POST
    @ApiOperation(value = "通过主健查询案件回访抽查", response = Result.class)
    @Path("/callbackCheck/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result getCallbackCheckById(int id) {
        try {
            Buss logic = new Buss("CallbackCheck");

            return logic.GetById(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @POST
    @ApiOperation(value = "通过条件分页查询案件回访抽查", response = Result.class)
    @Path("/callbackCheck/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result getCallbackCheckByFilter(PageFilter pf) {
        try {
            Buss logic = new Buss("CallbackCheck");

            return logic.GetByFilter(pf);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @POST
    @ApiOperation(value = "保存案件回访抽查", response = Result.class)
    @Path("/callbackCheck/save")
    @Produces(MediaType.APPLICATION_JSON)
    public Result saveCallbackCheck(CallbackCheck request) {
        try {
            Buss logic = new Buss("CallbackCheck");

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

    @POST
    @Path("/callbackCheck/delete")
    @ApiOperation(value = "删除案件回访抽查", response = Result.class)
    @Produces(MediaType.APPLICATION_JSON)
    public Result deleteCallbackCheck(int id) {
        try {
            Buss logic = new Buss("CallbackCheck");

            return logic.Delete(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    /***********案件类型服务********************/
    @POST
    @ApiOperation(value = "通过主健查询案件类型", response = Result.class)
    @Path("/caseType/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result getCaseTypeById(int id) {
        try {
            Buss logic = new Buss("CaseType");

            return logic.GetById(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @POST
    @ApiOperation(value = "通过条件分页查询案件类型", response = Result.class)
    @Path("/caseType/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result getCaseTypeByFilter(PageFilter pf) {
        try {
            Buss logic = new Buss("CaseType");

            return logic.GetByFilter(pf);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
}
