package teamwish.duty.services;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

import teamwish.duty.dataContracts.common.*;
import teamwish.duty.dataContracts.duty.ArrangeInfo;
import teamwish.duty.dataContracts.point.PointInfo;
import teamwish.duty.dataContracts.point.PointInfoDevice;
import teamwish.duty.dataContracts.point.PointInfoStation;
import teamwish.duty.dataContracts.point.RequestPointDelete;
import teamwish.duty.logic.point.Buss;
import teamwish.duty.common.CheckAuth;

import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;

@CheckAuth
@Path("point")
@Api(value = "巡区服务")
@ApiImplicitParams({@ApiImplicitParam(paramType = "header",dataType = "String",name = "token",value = "token信息")
})
public class PointService {
    @Context
    HttpHeaders header;

    /***********PointInfo接口服务********************/
    @ApiOperation(value = "通过ID查找巡区", response = Result.class)
    @POST
    @Path("/point/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result GetPointInfoById(int id) {
        try {
        	Buss logic = new Buss("PointInfo");
            PointInfo item = (PointInfo)logic.getById(id);
            
            List<PointInfoDevice> devices = getPointInfoDeviceByPointId(id, 1);          
			item.setPointInfoDevices(new ArrayList<PointInfoDevice>(devices));			
			
			return new Result(item);
            
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
        
    @SuppressWarnings("unchecked")
	@ApiOperation(value = "搜索巡区", response = Result.class)
    @POST
    @Path("/point/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result getPointInfoByFilter(PageFilter pf) {
        try {
        	Buss logic = new Buss("PointInfo");
        	
        	List<PointInfo> items = (List<PointInfo>) logic.getByFilter(pf); 
        	for (PointInfo item : items) {  
        		List<PointInfoDevice> devices = getPointInfoDeviceByPointId(item.getId(), 1);            
    			item.setPointInfoDevices(new ArrayList<PointInfoDevice>(devices));
        	}
        	
            return  new Result(items);
            
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
        
    @ApiOperation(value = "保存巡区", response = Result.class)
    @POST
    @Path("/point/save")
    @Produces(MediaType.APPLICATION_JSON)
    public Result SavePointInfo(PointInfo request) {
        try {
        	Buss logic = new Buss("PointInfo");        	
            if (request.getId() > 0) {
                int count = logic.Save(request);

                if (count == 0) {
                    return new Result(0);
                }
                
                ArrayList<PointInfoDevice> pointInfoDevices = request.getPointInfoDevices();            
                if(pointInfoDevices != null) {
                	for (PointInfoDevice item : pointInfoDevices) {
                		item.setPointInfoId(request.getId());
                		item.setIsDefault(1);
                		savePointInfoDevice(item);
                	 }
                }
                

                return GetPointInfoById(request.getId());
            }

            Object _id = logic.Insert(request);
            if (_id == null) {
                return new Result(0);
            }
            int id = Integer.parseInt(_id.toString());
            
            ArrayList<PointInfoDevice> pointInfoDevices = request.getPointInfoDevices();            
            if(pointInfoDevices != null) {
            	for (PointInfoDevice item : pointInfoDevices) {
            		item.setPointInfoId(id);
            		item.setIsDefault(1);
            		savePointInfoDevice(item);
            	 }
            }
            
            return GetPointInfoById(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "删除巡区", response = Result.class)
    @POST
    @Path("/point/delete")
    @Produces(MediaType.APPLICATION_JSON)
    public Result deletePointInfo(int id) {
        try {
        	Buss logic = new Buss("PointInfo");

            return logic.Delete(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
    
    @SuppressWarnings("unused")
	private List<PointInfoDevice> getPointInfoDeviceByPointId(int id){   
    	return getPointInfoDeviceByPointId(id, 0);
    }
    
    @SuppressWarnings("unchecked")
	private List<PointInfoDevice> getPointInfoDeviceByPointId(int id, int isDefault){
    	
    	Buss _logic = new Buss("PointInfoDevice");
        PageFilter _pf = new PageFilter();   
        ArrayList<Condition> conditions = new java.util.ArrayList<>();
        Condition condition = new Condition();
        condition.setFieldName("PointInfoId");
        condition.setOpt("=");
        condition.setFieldType("int");            
        condition.setValue(String.valueOf(id));
        conditions.add(condition);
        
        condition = new Condition();
        condition.setFieldName("IsDefault");
        condition.setOpt("=");
        condition.setFieldType("int");            
        condition.setValue(String.valueOf(isDefault));
        conditions.add(condition);
        
        _pf.setConditions(conditions.toArray(new Condition[conditions.size()]));
        _pf.setPageSize(10000);
		List<PointInfoDevice> devices= (List<PointInfoDevice>)_logic.getByFilter(_pf);
		
		return devices;
    }
    
    
    /***********PointInfoDevice接口服务********************/
    @ApiOperation(value = "通过ID查找巡区设备", response = Result.class)
    @POST
    @Path("/pointDevice/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result getPointInfoDeviceById(int id) {
        try {
        	Buss logic = new Buss("PointInfoDevice");

            return logic.GetById(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "搜索巡区设备", response = Result.class)
    @POST
    @Path("/pointDevice/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result GetPointInfoDeviceByFilter(PageFilter pf) {
        try {
        	Buss logic = new Buss("PointInfoDevice");
        	
            return logic.GetByFilter(pf);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
    
    @ApiOperation(value = "保存巡区设备", response = Result.class)
    @POST
    @Path("/pointDevice/save")
    @Produces(MediaType.APPLICATION_JSON)
    public Result SavePointInfoDevice(PointInfoDevice request) {
        try {
        	int id = savePointInfoDevice(request);
            if (id == 0) {
                return new Result(0);
            }
            
            Buss logic = new Buss("PointInfoDevice");
            return new Result(logic.getById(id));
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
    
    
    @ApiOperation(value = "批量保存巡区设备", response = Result.class)
    @POST
    @Path("/pointDevice/saveList")
    @Produces(MediaType.APPLICATION_JSON)
    public Result SaveListPointInfoDevice(List<PointInfoDevice> requests) {
        try {
        	Buss logic = new Buss("PointInfoDevice");
            List<PointInfoDevice> results = new java.util.ArrayList<>();
        	
        	for(PointInfoDevice request : requests) {
        		int id = savePointInfoDevice(request);
        		if(id >0) {
        			results.add((PointInfoDevice)logic.getById(id));
        		}
        		
        	}
            return new Result(results);            
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
    
    public int savePointInfoDevice(PointInfoDevice request) {
        try {
        	Buss logic = new Buss("PointInfoDevice");

            if (request.getId() > 0) {
                int count = logic.Save(request);

                if (count == 0) {
                    return 0;
                }

                return request.getId();
            }

            Object _id = logic.Insert(request);

            if (_id == null) {
                return 0;
            }

            int id = Integer.parseInt(_id.toString());

            return id;
        } catch (Exception ex) {
        	ex.printStackTrace();
            return 0;
        }
    }

    @ApiOperation(value = "删除巡区设备", response = Result.class)
    @POST
    @Path("/pointDevice/delete")
    @Produces(MediaType.APPLICATION_JSON)
    public Result deletePointDeviceInfo(int id) {
        try {
        	Buss logic = new Buss("PointInfoDevice");

            return logic.Delete(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
    
    @ApiOperation(value = "通过条件删除巡区设备", response = Result.class)
    @POST
    @Path("/pointDevice/deleteFilter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result deletePointDeviceInfoByFilter(RequestPointDelete filter) {
        try {
        	Buss logic = new Buss("PointInfoDevice");
        	
            return new Result(logic.deleteFilter(filter, "DeletePointInfoDeviceByFilter"));
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
    
    @ApiOperation(value = "删除巡区设备", response = Result.class)
    @POST
    @Path("/pointDevice/deleteList")
    @Produces(MediaType.APPLICATION_JSON)
    public Result deleteListPointDeviceInfo(int[] ids) {
        try {
        	Buss logic = new Buss("PointInfoDevice");
        	int count = 0;
        	for(int id : ids) {
        		count += logic.delete(id);
        	}
            return new Result(count);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
    
    /***********巡区相关单位服务********************/
    @POST
    @ApiOperation(value = "通过主健查询PointInfoStation", response = Result.class)
    @Path("/pointInfoStation/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result getPointInfoStationById(int id) {
        try {
            Buss logic = new Buss("PointInfoStation");

            return logic.GetById(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @POST
    @ApiOperation(value = "通过条件分页查询PointInfoStation", response = Result.class)
    @Path("/pointInfoStation/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result getPointInfoStationByFilter(PageFilter pf) {
        try {
            Buss logic = new Buss("PointInfoStation");

            return logic.GetByFilter(pf);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @POST
    @ApiOperation(value = "保存PointInfoStation", response = Result.class)
    @Path("/pointInfoStation/save")
    @Produces(MediaType.APPLICATION_JSON)
    public Result savePointInfoStation(PointInfoStation request) {
        try {
            Buss logic = new Buss("PointInfoStation");

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
    
    @ApiOperation(value = "批量保存巡区单位", response = Result.class)
    @POST
    @Path("/pointInfoStation/saveList")
    @Produces(MediaType.APPLICATION_JSON)
    public Result saveListPointInfoStation(List<PointInfoStation> requests) {
        try {
        	Buss logic = new Buss("PointInfoStation");
        	List<PointInfoStation> results = new java.util.ArrayList<>();
        	
        	for(PointInfoStation request : requests) {
        		if (request.getId() > 0) {
                    int count = logic.Save(request);
                    if(count == 1) {
                    	results.add((PointInfoStation)logic.getById(request.getId()));
                    }
                }
        		else {
        			Object _id = logic.Insert(request);
                    if (_id != null) {
                    	int id = Integer.parseInt(_id.toString());
                    	results.add((PointInfoStation)logic.getById(id));
                    }
        		}
        	}
            return new Result(results);           
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @POST
    @Path("/pointInfoStation/delete")
    @ApiOperation(value = "删除PointInfoStation", response = Result.class)
    @Produces(MediaType.APPLICATION_JSON)
    public Result deletePointInfoStation(int id) {
        try {
            Buss logic = new Buss("PointInfoStation");

            return logic.Delete(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
    
    @POST
    @Path("/pointInfoStation/deleteList")
    @ApiOperation(value = "批量删除巡区单位", response = Result.class)
    @Produces(MediaType.APPLICATION_JSON)
    public Result deletePointInfoStation(int[] ids) {
    	try {
        	Buss logic = new Buss("PointInfoStation");
        	int count =0;
        	for(int id : ids) {
        		count += logic.delete(id);
        	}
            return new Result(count);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
}
