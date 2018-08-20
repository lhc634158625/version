package teamwish.services;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

import teamwish.dataContracts.common.*;

import teamwish.dataContracts.sys.*;

import teamwish.logic.sys.Buss;

import java.io.UnsupportedEncodingException;

import java.security.NoSuchAlgorithmException;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;

@CheckAuth
@Path("sys")
@Api(value = "系统服务")
@ApiImplicitParams({@ApiImplicitParam(paramType = "header",dataType = "String",name = "token",value = "token信息")
})
public class SysService {
    @Context
    HttpHeaders header;

    @ApiOperation(value = "通过ID查找用户", response = Result.class)
    @POST
    @Path("/user/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result<UserInfo> getUserById(int id) {
        try {
            Buss sysLogic = new Buss();
            Result<UserInfo> result = sysLogic.GetUserInfoById(id);
            // System.out.println(header.getHeaderString("token"));
            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "搜索用户", response = Result.class)
    @POST
    @Path("/user/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<List<UserInfo>> getUserByFilter(PageFilter pf) {
        try {
            Buss sysLogic = new Buss();
            Result<List<UserInfo>> result = sysLogic.GetUserInfoByFilter(pf);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "保存用户", response = Result.class)
    @POST
    @Path("/user/save")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<UserInfo> saveUser(UserInfo userInfo) {
        try {
            Buss sysLogic = new Buss();
            Result<UserInfo> result;

            result = sysLogic.SaveUser(userInfo);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "删除用户", response = Result.class)
    @POST
    @Path("/user/delete")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<Integer> deleteUser(int id) {
        try {
            Buss sysLogic = new Buss();
            Result<Integer> result = sysLogic.DeleteUser(id);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    
    @ApiOperation(value = "用户登陆", response = Result.class)
    @POST
    @Path("/user/login")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result<UserInfo> CheckUser(Request request) {
        try {
            Buss sysLogic = new Buss();

            return sysLogic.CheckUser(request);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
    
    @ApiOperation(value = "用户退出", response = Result.class)
    @POST
    @Path("/user/logout")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result UserLogout(Request request) {
        try {
            Buss sysLogic = new Buss();            
            return sysLogic.Logout();
            
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "检验token", response = Result.class)
    @POST
    @Path("/user/checktoken")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result<UserInfo> checkToken(String token) {
        try {
            Buss sysLogic = new Buss();
            Result<UserInfo> result = sysLogic.CheckToken(token);
            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "重置密码", response = Result.class)
    @POST
    @Path("/user/resetPwd")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result ResetPwd(Request request) {
        try {
            Buss sysLogic = new Buss();

            return sysLogic.ResetPwd(request);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    /*********** Staff接口服务 ********************/
    @ApiOperation(value = "通过ID查找警员", response = Result.class)
    @POST
    @Path("/staff/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result<Staff> getStaffById(int id) {
        try {
            Buss sysLogic = new Buss();
            Result<Staff> result = sysLogic.GetStaffById(id);

            // System.out.println(header.getHeaderString("token"));
            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "通过code查找警员", response = Result.class)
    @POST
    @Path("/staff/code")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result<Staff> getStaffByCode(String code) {
        try {
            Buss sysLogic = new Buss();
            Result<Staff> result = sysLogic.GetStaffByCode(code);

            // System.out.println(header.getHeaderString("token"));
            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "搜索警员", response = Result.class)
    @POST
    @Path("/staff/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<List<Staff>> getStaffByFilter(PageFilter pf) {
        try {
            Buss sysLogic = new Buss();
            Result<List<Staff>> result = sysLogic.GetStaffByFilter(pf);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "保存警员", response = Result.class)
    @POST
    @Path("/staff/save")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<Staff> saveStaff(Staff staff) {
        try {
            Buss sysLogic = new Buss();
            Result<Staff> result;

            result = sysLogic.SaveStaff(staff);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "删除警员", response = Result.class)
    @POST
    @Path("/staff/delete")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<Integer> deleteStaff(int id) {
        try {
            Buss sysLogic = new Buss();
            Result<Integer> result = sysLogic.DeleteStaff(id);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    /*********** Station服务 ********************/
    @ApiOperation(value = "通过ID查找单位", response = Result.class)
    @POST
    @Path("/station/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result<Station> getStationById(int id) {
        try {
            Buss sysLogic = new Buss();
            Result<Station> result = sysLogic.GetStationById(id);

            // System.out.println(header.getHeaderString("token"));
            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "搜索单位", response = Result.class)
    @POST
    @Path("/station/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<List<Station>> getStationByFilter(PageFilter pf) {
        try {
            Buss sysLogic = new Buss();
            Result<List<Station>> result = sysLogic.GetStationByFilter(pf);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "保存单位", response = Result.class)
    @POST
    @Path("/station/save")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<Station> saveStation(Station station) {
        try {
            Buss sysLogic = new Buss();
            Result<Station> result;

            result = sysLogic.SaveStation(station);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "删除单位", response = Result.class)
    @POST
    @Path("/station/delete")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<Integer> deleteStation(int id) {
        try {
            Buss sysLogic = new Buss();
            Result<Integer> result = sysLogic.DeleteStation(id);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    /*********** Role服务 ********************/
    @ApiOperation(value = "通过ID查找角色", response = Result.class)
    @POST
    @Path("/role/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result<Role> getRoleById(int id) {
        try {
            Buss sysLogic = new Buss();
            Result<Role> result = sysLogic.GetRoleById(id);

            // System.out.println(header.getHeaderString("token"));
            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "搜索角色", response = Result.class)
    @POST
    @Path("/role/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<List<Role>> getRoleByFilter(PageFilter pf) {
        try {
            Buss sysLogic = new Buss();
            Result<List<Role>> result = sysLogic.GetRoleByFilter(pf);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "保存角色", response = Result.class)
    @POST
    @Path("/role/save")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<Role> saveRole(Role role) {
        try {
            Buss sysLogic = new Buss();
            Result<Role> result;

            result = sysLogic.SaveRole(role);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "删除角色", response = Result.class)
    @POST
    @Path("/role/delete")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<Integer> deleteRole(int id) {
        try {
            Buss sysLogic = new Buss();
            Result<Integer> result = sysLogic.DeleteRole(id);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "角色模块", response = Result.class)
    @POST
    @Path("/role/module")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result GetRoleModule(int roleId) {
        try {
            Buss sysLogic = new Buss();

            return sysLogic.GetRoleModule(roleId);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "树形角色模块", response = Result.class)
    @POST
    @Path("/role/moduleTree")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result GetRoleModuleTree(int roleId) {
        try {
            Buss sysLogic = new Buss();

            return sysLogic.GetRoleModuleTree(roleId);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
}
