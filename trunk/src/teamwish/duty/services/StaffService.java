package teamwish.duty.services;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

import teamwish.duty.common.CheckAuth;

import teamwish.duty.dataContracts.common.*;
import teamwish.duty.dataContracts.duty.ArrangeInfoReport;
import teamwish.duty.dataContracts.staff.RequestStaff;
import teamwish.duty.dataContracts.staff.Staff;
import teamwish.duty.logic.staff.Buss;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;


@CheckAuth
@Path("staff")
@Api(value = "警员服务")
@ApiImplicitParams({@ApiImplicitParam(paramType = "header",dataType = "String",name = "token",value = "token信息")
})
public class StaffService {
    @Context
    HttpHeaders header;
    
    @SuppressWarnings("unchecked")
	@ApiOperation(value = "警员状态信息", response = Result.class)
    @POST
    @Path("/staff/shiftState")
    @Produces(MediaType.APPLICATION_JSON)
    public Result getStaffState(RequestStaff request) {
        try {
        	 Buss logic = new Buss("");
             List<ArrangeInfoReport> staffs = (List<ArrangeInfoReport>) logic.GetMultiByRequest(request,
                     "GetStaffState");

             return new Result(staffs);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
    
    @ApiOperation(value = "通过ID查找警员", response = Result.class)
    @POST
    @Path("/staff/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result getStaffById(int id) {
        try {
            Buss logic = new Buss("Staff");

            return logic.GetById(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "通过code查找警员", response = Result.class)
    @POST
    @Path("/staff/code")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result getStaffByCode(String code) {
        try {
            Buss logic = new Buss("Staff");

            return logic.GetByCode(code);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "搜索警员", response = Result.class)
    @POST
    @Path("/staff/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result getStaffByFilter(PageFilter pf) {
        try {
            if (pf.getOrderField() == null) {
                pf.setOrderField("Id");
            }

            Buss logic = new Buss("Staff");

            return logic.GetByFilter(pf);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "搜索警员数量", response = Result.class)
    @POST
    @Path("/staff/filterCount")
    @Produces(MediaType.APPLICATION_JSON)
    public Result getStaffCountByFilter(PageFilter pf) {
        try {
            if (pf.getOrderField() == null) {
                pf.setOrderField("Id");
            }

            Buss logic = new Buss("Staff");

            return logic.GetCountByFilter(pf);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "保存警员", response = Result.class)
    @POST
    @Path("/staff/save")
    @Produces(MediaType.APPLICATION_JSON)
    public Result saveStaff(Staff request) {
        try {
            Buss logic = new Buss("Staff");

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

    @ApiOperation(value = "删除警员", response = Result.class)
    @POST
    @Path("/staff/delete")
    @Produces(MediaType.APPLICATION_JSON)
    public Result deleteStaff(int id) {
        try {
            Buss logic = new Buss("Staff");

            return logic.Delete(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
        
    
    
    
}
