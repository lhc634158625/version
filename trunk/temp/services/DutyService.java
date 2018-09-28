package teamwish.duty.services;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

import teamwish.duty.common.CheckAuth;
import teamwish.duty.dataContracts.duty.*;
import teamwish.duty.dataContracts.common.*;
import teamwish.duty.logic.duty.Buss;

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
    public Result<ArrangeInfo> getArrangeInfoById(int id) {
        try {
            Buss dutyLogic = new Buss();
            Result<ArrangeInfo> result = dutyLogic.GetArrangeInfoById(id);

            // System.out.println(header.getHeaderString("token"));
            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "搜索排班", response = Result.class)
    @POST
    @Path("/arrange/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<List<ArrangeInfo>> getArrangeInfoByFilter(PageFilter pf) {
        try {
            Buss dutyLogic = new Buss();
            Result<List<ArrangeInfo>> result = dutyLogic.GetArrangeInfoByFilter(pf);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "保存排班", response = Result.class)
    @POST
    @Path("/arrange/save")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<ArrangeInfo> saveArrangeInfo(ArrangeInfo arrangeInfo) {
        try {
            Buss dutyLogic = new Buss();
            Result<ArrangeInfo> result;

            result = dutyLogic.SaveArrangeInfo(arrangeInfo);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "删除排班", response = Result.class)
    @POST
    @Path("/arrange/delete")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<Integer> deleteArrangeInfo(int id) {
        try {
            Buss dutyLogic = new Buss();
            Result<Integer> result = dutyLogic.DeleteArrangeInfo(id);

            return result;
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
            Buss dutyLogic = new Buss();
            
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
            Buss dutyLogic = new Buss();
            
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
            Buss dutyLogic = new Buss();
            List<StaffPositionShiftReport> report = dutyLogic.GetStationShiftTypeCount(request);
            return new Result(report);
            
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    /***********警情接口服务********************/
    @ApiOperation(value = "通过ID查找警情", response = Result.class)
    @POST
    @Path("/regionService/get")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Result<RegionService> getRegionServiceById(int id) {
        try {
            Buss dutyLogic = new Buss();
            Result<RegionService> result = dutyLogic.GetRegionServiceById(id);

            // System.out.println(header.getHeaderString("token"));
            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }

    @ApiOperation(value = "搜索警情", response = Result.class)
    @POST
    @Path("/regionService/filter")
    @Produces(MediaType.APPLICATION_JSON)
    public Result<List<RegionService>> getRegionServiceByFilter(PageFilter pf) {
        try {
            Buss dutyLogic = new Buss();
            Result<List<RegionService>> result = dutyLogic.GetRegionServiceByFilter(pf);

            return result;
        } catch (Exception ex) {
            return new Result(ResponseCode.SystemError, ex.getMessage());
        }
    }
}
