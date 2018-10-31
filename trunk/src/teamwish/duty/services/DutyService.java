package teamwish.duty.services;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;


import teamwish.duty.logic.duty.Buss;
import teamwish.duty.common.CheckAuth;
import teamwish.duty.dataContracts.common.PageFilter;
import teamwish.duty.dataContracts.common.ResponseCode;
import teamwish.duty.dataContracts.common.Result;
import teamwish.duty.dataContracts.duty.ArrangeInfo;
import teamwish.duty.dataContracts.duty.ArrangeInfoReport;
import teamwish.duty.dataContracts.duty.ArrangeInfoReportCount;
import teamwish.duty.dataContracts.duty.InterceptPoint;
import teamwish.duty.dataContracts.duty.InterceptTask;
import teamwish.duty.dataContracts.duty.RequestArrangeDelete;
import teamwish.duty.dataContracts.duty.RequestDuty;
import teamwish.duty.dataContracts.duty.ShiftType;
import teamwish.duty.dataContracts.duty.StaffPositionShiftReport;
import teamwish.duty.dataContracts.duty.VTStation;
import teamwish.duty.dataContracts.point.RequestPointDelete;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;

@CheckAuth
@Path("duty")
@Api(value = "排班服务")
@ApiImplicitParams({@ApiImplicitParam(paramType = "header",dataType = "String",name = "token",value = "token信息")
})
public class DutyService {
    @Context
    HttpHeaders header;

    /***********Arrange接口服务********************/
    @ApiOperation(value = "通过ID查找排班", response = Result.class)
    @POST
    @Path("/arrange/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result getArrangeInfoById(int id) {
        try {
        	Buss logic = new Buss("ArrangeInfo");

            return logic.GetById(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "搜索排班", response = Result.class)
    @POST
    @Path("/arrange/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result getArrangeInfoByFilter(PageFilter pf) {
        try {
        	Buss logic = new Buss("ArrangeInfo");

            return logic.GetByFilter(pf);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "保存排班", response = Result.class)
    @POST
    @Path("/arrange/save")
    @Produces(MediaType.APPLICATION_JSON)
    public Result saveArrangeInfo(ArrangeInfo request) {
        try {
        	Buss logic = new Buss("ArrangeInfo");

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
    
    @ApiOperation(value = "批量保存排班", response = Result.class)
    @POST
    @Path("/arrange/saveList")
    @Produces(MediaType.APPLICATION_JSON)
    public Result saveListArrangeInfo(List<ArrangeInfo> requests) {
        try {
        	Buss logic = new Buss("ArrangeInfo");
        	List<ArrangeInfo> results = new java.util.ArrayList<>();
        	
        	for(ArrangeInfo request : requests) {
        		if (request.getId() > 0) {
                    int count = logic.Save(request);
                    if(count == 1) {
                    	results.add((ArrangeInfo)logic.getById(request.getId()));
                    }
                }
        		else {
        			Object _id = logic.Insert(request);
                    if (_id != null) {
                    	int id = Integer.parseInt(_id.toString());
                    	results.add((ArrangeInfo)logic.getById(id));
                    }
        		}
        	}
            return new Result(results);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "删除排班", response = Result.class)
    @POST
    @Path("/arrange/delete")
    @Produces(MediaType.APPLICATION_JSON)
    public Result deleteArrangeInfo(int id) {
        try {
        	Buss logic = new Buss("ArrangeInfo");

            return logic.Delete(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
    
    @ApiOperation(value = "通过条件排班", response = Result.class)
    @POST
    @Path("/arrange/deleteFilter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result deleteArrangeByFilter(RequestArrangeDelete filter) {
        try {
        	Buss logic = new Buss("ArrangeInfo");

            return new Result(logic.deleteFilter(filter, "DeleteArrangeInfoByFilter"));
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
    
    @ApiOperation(value = "批量删除排班", response = Result.class)
    @POST
    @Path("/arrange/deleteList")
    @Produces(MediaType.APPLICATION_JSON)
    public Result deleteListArrangeInfo(int[] ids) {
        try {
        	Buss logic = new Buss("ArrangeInfo");
        	int count =0;
        	for(int id : ids) {
        		count += logic.delete(id);
        	}
            return new Result(count);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "搜索单位排班人员数量", response = Result.class)
    @POST
    @Path("/arrange/stationStaffCount")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result GetStationStaffCount(RequestDuty request) {
        try {
            Buss dutyLogic = new Buss("");
            
            VTStation station = (VTStation)dutyLogic.GetVTStationById(request);
            if(station == null) return new Result();
            
            request.setStationGroupId(6);
            
            request.setPath(station.getPath());
            request.setTLevel(station.getTLevel() + 2);
            
            List<ArrangeInfoReportCount> result = (List<ArrangeInfoReportCount>)dutyLogic.GetStationStaffCount(request);
            
            List<ArrangeInfoReportCount> result2 = (List<ArrangeInfoReportCount>)dutyLogic.GetStationStaffCountReport(request);
            
            if(result != null && result2 !=null) {
            	for (ArrangeInfoReportCount _result : result) {            		
            		for (ArrangeInfoReportCount _result2 : result2) {
                        if(_result2.getStationId() == _result.getStationId()
                           && _result2.getIdPath().equals(_result.getIdPath())) {
                        	_result2.setCount(_result2.getCount() + _result.getCount());
                        }
                    }
                }
            }
            
            
            return new Result(result2);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
    
    @ApiOperation(value = "搜索单位排班人员", response = Result.class)
    @POST
    @Path("/arrange/stationStaff")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result GetStationStaff(RequestDuty request) {
        try {
            Buss dutyLogic = new Buss("");
            
            VTStation station = (VTStation)dutyLogic.GetVTStationById(request);
            if(station == null) return new Result();
            
            SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat sDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");            
            Date fromTime = sDateFormat.parse(request.getFromDt());
            
            request.setStationGroupId(6);            
            request.setPath(station.getPath());
            request.setTLevel(station.getTLevel() + 2);
            
            List<ArrangeInfoReport> result = (List<ArrangeInfoReport>)dutyLogic.GetStationStaff(request);
            List<ArrangeInfoReportCount> result2 = (List<ArrangeInfoReportCount>)dutyLogic.GetStationStaffCountReport(request);
            
            List<ArrangeInfoReport> list = new ArrayList<ArrangeInfoReport>();
            if(result == null || result.size() == 0) {
            	
            	for (ArrangeInfoReportCount _result2 : result2) {
            		ArrangeInfoReport arrangeInfo = new ArrangeInfoReport();
            		            		
            		arrangeInfo.setIdPath(_result2.getIdPath());
            		arrangeInfo.setNamePath(_result2.getNamePath());
            		arrangeInfo.setOrderIndex(_result2.getOrderIndex());
            		arrangeInfo.setStationId(_result2.getStationId());
            		arrangeInfo.setStationName(_result2.getStationName());
            		arrangeInfo.setWorkDt(simpleDateFormat.format(fromTime));
            		list.add(arrangeInfo);
            		
                }           	
            	return new Result(list);
            }
            	            
            
            
            return new Result(result);
            
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "搜索单位排班人员勤务类型数量", response = Result.class)
    @POST
    @Path("/arrange/stationShiftTypeCount")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result GetStationShiftTypeCount(RequestDuty request) {
        try {
            Buss dutyLogic = new Buss("");
            List<StaffPositionShiftReport> report = dutyLogic.GetStationShiftTypeCount(request);
            return new Result(report);
            
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
    
    
    /***********shiftType接口服务********************/
    @POST
    @ApiOperation(value = "通过主健查询ShiftType", response = Result.class)
    @Path("/shiftType/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result getShiftTypeById(int id) {
        try {
            Buss logic = new Buss("ShiftType");

            return logic.GetById(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @POST
    @ApiOperation(value = "通过条件分页查询ShiftType", response = Result.class)
    @Path("/shiftType/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result getShiftTypeByFilter(PageFilter pf) {
        try {
            Buss logic = new Buss("ShiftType");

            return logic.GetByFilter(pf);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @POST
    @ApiOperation(value = "保存ShiftType", response = Result.class)
    @Path("/shiftType/save")
    @Produces(MediaType.APPLICATION_JSON)
    public Result saveShiftType(ShiftType request) {
        try {
            Buss logic = new Buss("ShiftType");

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
    @Path("/shiftType/delete")
    @ApiOperation(value = "删除ShiftType", response = Result.class)
    @Produces(MediaType.APPLICATION_JSON)
    public Result deleteShiftType(int id) {
        try {
            Buss logic = new Buss("ShiftType");

            return logic.Delete(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
    
    /***********InterceptTask服务********************/
    @POST
    @ApiOperation(value = "通过主健查询InterceptTask", response = Result.class)
    @Path("/interceptTask/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result getInterceptTaskById(int id) {
        try {
            Buss logic = new Buss("InterceptTask");

            return logic.GetById(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @POST
    @ApiOperation(value = "通过条件分页查询InterceptTask", response = Result.class)
    @Path("/interceptTask/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result getInterceptTaskByFilter(PageFilter pf) {
        try {
            Buss logic = new Buss("InterceptTask");

            return logic.GetByFilter(pf);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @POST
    @ApiOperation(value = "保存InterceptTask", response = Result.class)
    @Path("/interceptTask/save")
    @Produces(MediaType.APPLICATION_JSON)
    public Result saveInterceptTask(InterceptTask request) {
        try {
            Buss logic = new Buss("InterceptTask");

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
    @Path("/interceptTask/delete")
    @ApiOperation(value = "删除InterceptTask", response = Result.class)
    @Produces(MediaType.APPLICATION_JSON)
    public Result deleteInterceptTask(int id) {
        try {
            Buss logic = new Buss("InterceptTask");

            return logic.Delete(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
    
    /***********interceptPoint服务********************/
    @POST
    @ApiOperation(value = "通过主健查询InterceptPoint", response = Result.class)
    @Path("/interceptPoint/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result getInterceptPointById(int id) {
        try {
            Buss logic = new Buss("InterceptPoint");

            return logic.GetById(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @POST
    @ApiOperation(value = "通过条件分页查询InterceptPoint", response = Result.class)
    @Path("/interceptPoint/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result getInterceptPointByFilter(PageFilter pf) {
        try {
            Buss logic = new Buss("InterceptPoint");

            return logic.GetByFilter(pf);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @POST
    @ApiOperation(value = "保存InterceptPoint", response = Result.class)
    @Path("/interceptPoint/save")
    @Produces(MediaType.APPLICATION_JSON)
    public Result saveInterceptPoint(InterceptPoint request) {
        try {
            Buss logic = new Buss("InterceptPoint");

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
    @ApiOperation(value = "批量保存InterceptPoint", response = Result.class)
    @Path("/interceptPoint/saveList")
    @Produces(MediaType.APPLICATION_JSON)
    public Result saveInterceptPointList(List<InterceptPoint> requests) {
        try {
        	Buss logic = new Buss("InterceptPoint");
        	List<InterceptPoint> results = new java.util.ArrayList<>();
        	
        	for(InterceptPoint request : requests) {
        		if (request.getId() > 0) {
                    int count = logic.Save(request);
                    if(count == 1) {
                    	results.add((InterceptPoint)logic.getById(request.getId()));
                    }
                }
        		else {
        			Object _id = logic.Insert(request);
                    if (_id != null) {
                    	int id = Integer.parseInt(_id.toString());
                    	results.add((InterceptPoint)logic.getById(id));
                    }
        		}
        	}
            return new Result(results);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @POST
    @Path("/interceptPoint/delete")
    @ApiOperation(value = "删除InterceptPoint", response = Result.class)
    @Produces(MediaType.APPLICATION_JSON)
    public Result deleteInterceptPoint(int id) {
        try {
            Buss logic = new Buss("InterceptPoint");

            return logic.Delete(id);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
    
    @POST
    @Path("/interceptPoint/deleteList")
    @ApiOperation(value = "批量删除InterceptPoint", response = Result.class)
    @Produces(MediaType.APPLICATION_JSON)
    public Result deleteInterceptPoint(int[] ids) {
    	try {
        	Buss logic = new Buss("InterceptPoint");
        	int count =0;
        	for(int id : ids) {
        		count += logic.delete(id);
        	}
            return new Result(count);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
    
    
    @ApiOperation(value = "地图综合搜寻", response = Result.class)
    @POST
    @Path("/mapPoint/get")
    @Produces(MediaType.APPLICATION_JSON)
    public Result getMapPoint(String name) {
        try {
        	PageFilter pf=new PageFilter();
        	
        	Buss logic = new Buss("vw_allPoint");
        	
        	pf.setFilter("name like '%"+name+"%' ");
        	pf.setPageSize(10);
        	pf.setFromRecord(0);
        	pf.setOrderField("name");
            return logic.GetByFilter(pf);
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
   
}
