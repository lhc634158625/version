package teamwish.duty.services;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

import teamwish.duty.common.CheckAuth;

import teamwish.duty.dataContracts.common.*;
import teamwish.duty.dataContracts.sys.Request;
import teamwish.duty.dataContracts.sys.Role;
import teamwish.duty.dataContracts.sys.Station;
import teamwish.duty.dataContracts.sys.UserInfo;
import teamwish.duty.logic.sys.Buss;

import javax.ws.rs.Consumes;
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
    public Result getUserById(int id) {
        try {
            Buss logic = new Buss("UserInfo");

            return logic.GetById(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "搜索用户", response = Result.class)
    @POST
    @Path("/user/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result getUserByFilter(PageFilter pf) {
        try {
            Buss logic = new Buss("UserInfo");

            return logic.GetByFilter(pf);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "搜索用户数量", response = Result.class)
    @POST
    @Path("/user/filterCount")
    @Produces(MediaType.APPLICATION_JSON)
    public Result getUserCountByFilter(PageFilter pf) {
        try {
            if (pf.getOrderField() == null) {
                pf.setOrderField("Id");
            }

            Buss logic = new Buss("UserInfo");

            return logic.GetCountByFilter(pf);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "保存用户", response = Result.class)
    @POST
    @Path("/user/save")
    @Produces(MediaType.APPLICATION_JSON)
    public Result saveUser(UserInfo request) {
        try {
            Buss logic = new Buss("UserInfo");

            if (request.getId() > 0) {
                int count = logic.Save(request);

                if (count == 0) {
                    return new Result(0);
                }

                return logic.GetById(request.getId());
            }

            teamwish.common.Utils utils = new teamwish.common.Utils();
            request.setPassword(utils.EncoderByMd5("123456"));

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

    @ApiOperation(value = "删除用户", response = Result.class)
    @POST
    @Path("/user/delete")
    @Produces(MediaType.APPLICATION_JSON)
    public Result deleteUser(int id) {
        try {
            Buss logic = new Buss("UserInfo");

            return logic.Delete(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "用户登陆", response = Result.class)
    @POST
    @Path("/user/login")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result CheckUser(Request request) {
        try {
            Buss logic = new Buss("UserInfo");

            return logic.CheckUser(request);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "用户退出", response = Result.class)
    @POST
    @Path("/user/logout")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result UserLogout() {
        try {
            Buss logic = new Buss("UserInfo");

            String token = header.getHeaderString("token");

            return logic.Logout(token);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "检验token", response = Result.class)
    @POST
    @Path("/user/checktoken")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result checkToken(String token) {
        try {
            Buss logic = new Buss("UserInfo");

            return logic.CheckToken(token);
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
            Buss sysLogic = new Buss("UserInfo");

            return sysLogic.ResetPwd(request);
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
    public Result getStationById(int id) {
        try {
            Buss logic = new Buss("Station");

            return logic.GetById(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "通过ID查找单位树", response = Result.class)
    @POST
    @Path("/station/tree")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result getStationTreeByFilter(Request request) {
        try {
            if (request.getStationGroupId() == 0) {
                request.setStationGroupId(7);
            }

            Buss logic = new Buss("Station");

            return logic.GetStationTree(request);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "搜索单位", response = Result.class)
    @POST
    @Path("/station/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result getStationByFilter(PageFilter pf) {
        try {
            if (pf.getOrderField() == null) {
                pf.setOrderField("Id");
            }

            Buss logic = new Buss("Station");

            return logic.GetByFilter(pf);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "搜索单位数量", response = Result.class)
    @POST
    @Path("/station/filterCount")
    @Produces(MediaType.APPLICATION_JSON)
    public Result getStationCountByFilter(PageFilter pf) {
        try {
            if (pf.getOrderField() == null) {
                pf.setOrderField("Id");
            }

            Buss logic = new Buss("Station");

            return logic.GetCountByFilter(pf);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "保存单位", response = Result.class)
    @POST
    @Path("/station/save")
    @Produces(MediaType.APPLICATION_JSON)
    public Result saveStation(Station request) {
        try {
            Buss logic = new Buss("Station");

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

    @ApiOperation(value = "删除单位", response = Result.class)
    @POST
    @Path("/station/delete")
    @Produces(MediaType.APPLICATION_JSON)
    public Result deleteStation(int id) {
        try {
            Buss logic = new Buss("Station");

            return logic.Delete(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "通过ID查找上级单位", response = Result.class)
    @POST
    @Path("/station/superiors")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result getSuperiorsById(Request request) {
        try {
            Buss logic = new Buss("Station");

            return logic.GetSuperiorsById(request);
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
    public Result getRoleById(int id) {
        try {
            Buss logic = new Buss("Role");

            return logic.GetById(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "搜索角色", response = Result.class)
    @POST
    @Path("/role/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result getRoleByFilter(PageFilter pf) {
        try {
            if (pf.getOrderField() == null) {
                pf.setOrderField("Id");
            }

            Buss logic = new Buss("Role");

            return logic.GetByFilter(pf);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "保存角色", response = Result.class)
    @POST
    @Path("/role/save")
    @Produces(MediaType.APPLICATION_JSON)
    public Result saveRole(Role request) {
        try {
            Buss logic = new Buss("Role");

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

    @ApiOperation(value = "删除角色", response = Result.class)
    @POST
    @Path("/role/delete")
    @Produces(MediaType.APPLICATION_JSON)
    public Result deleteRole(int id) {
        try {
            Buss logic = new Buss("Role");

            return logic.Delete(id);
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
            Buss logic = new Buss("Role");

            return logic.GetRoleModule(roleId);
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
            Buss logic = new Buss("Role");

            return logic.GetRoleModuleTree(roleId);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
}
