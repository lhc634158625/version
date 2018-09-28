package teamwish.duty.logic.duty;

import teamwish.duty.dataContracts.common.*;

import teamwish.duty.dataContracts.duty.*;
import teamwish.duty.logic.common.DBHelp;

import java.util.List;


public class Buss {
    public Result<ArrangeInfo> GetArrangeInfoById(int id) {
        DBHelp dbHelp = new DBHelp();
        ArrangeInfo arrangeInfo = (ArrangeInfo) dbHelp.GetById(id, "ArrangeInfo");

        return new Result<ArrangeInfo>(arrangeInfo);
    }

    public Result<List<ArrangeInfo>> GetArrangeInfoByFilter(PageFilter pf) {
        DBHelp dbHelp = new DBHelp();
        List<ArrangeInfo> arrangeInfos = (List<ArrangeInfo>) dbHelp.GetByFilter(pf,
                "ArrangeInfo");

        return new Result<List<ArrangeInfo>>(arrangeInfos);
    }

    public Result<ArrangeInfo> SaveArrangeInfo(ArrangeInfo arrangeInfo) {
        DBHelp dbHelp = new DBHelp();

        if (arrangeInfo.getId() == 0) {
            // initial something
        }

        arrangeInfo = (ArrangeInfo) dbHelp.Save(arrangeInfo, "ArrangeInfo",
                (arrangeInfo.getId() == 0));
        

        return new Result<ArrangeInfo>(arrangeInfo);
    }

    public Result DeleteArrangeInfo(int id) {
        DBHelp dbHelp = new DBHelp();
        dbHelp.Delete(id, "ArrangeInfo");
        

        return new Result();
    }
    
    public VTStation GetVTStationById(
            RequestDuty request) {
            DBHelp dbHelp = new DBHelp();
            List<VTStation> stations = (List<VTStation>) dbHelp.GetMultiByRequest(request,
                    "GetVTStationById");
            if(stations != null)
            return stations.get(0);
            else return null;
    }

    public List<ArrangeInfoReportCount> GetStationStaffCount(
        RequestDuty request) {
        DBHelp dbHelp = new DBHelp();
        List<ArrangeInfoReportCount> arrangeReports = (List<ArrangeInfoReportCount>) dbHelp.GetMultiByRequest(request,
                "GetStationStaffCount");

        return arrangeReports;
    }
    
    public List<ArrangeInfoReportCount> GetStationStaffCountReport(
            RequestDuty request) {
            DBHelp dbHelp = new DBHelp();
            List<ArrangeInfoReportCount> arrangeReports = (List<ArrangeInfoReportCount>) dbHelp.GetMultiByRequest(request,
                    "GetStationStaffCountReport");

            return arrangeReports;
    }

    public List<ArrangeInfoReport> GetStationStaff(RequestDuty request) {
        DBHelp dbHelp = new DBHelp();
        List<ArrangeInfoReport> arrangeReports = (List<ArrangeInfoReport>) dbHelp.GetMultiByRequest(request,
                "GetStationStaff");

        return arrangeReports;
    }
    
    public List<StaffPositionShiftReport> GetStationShiftTypeCount(
        RequestDuty request) {
        DBHelp dbHelp = new DBHelp();
        List<StaffPositionShiftReport> arrangeInfos = (List<StaffPositionShiftReport>) dbHelp.GetMultiByRequest(request,
                "GetStationShiftTypeCount");

        return arrangeInfos;
    }
    
    

    public List<StaffPositionShiftReport> GetStationStaffPositionCount(
        RequestDuty request) {
        DBHelp dbHelp = new DBHelp();
        List<StaffPositionShiftReport> arrangeInfos = (List<StaffPositionShiftReport>) dbHelp.GetMultiByRequest(request,
                "GetStationStaffPositionCount");

        return arrangeInfos;
    }

    public List<StaffPositionShiftReport> GetStationStaffShiftTypeCount(
        RequestDuty request) {
        DBHelp dbHelp = new DBHelp();
        List<StaffPositionShiftReport> arrangeInfos = (List<StaffPositionShiftReport>) dbHelp.GetMultiByRequest(request,
                "GetStationStaffShiftTypeCount");

        return arrangeInfos;
    }

    /***********警情业务实现********************/
    public Result<RegionService> GetRegionServiceById(int id) {
        DBHelp dbHelp = new DBHelp();
        RegionService RegionService = (RegionService) dbHelp.GetById(id,
                "RegionService");

        return new Result<RegionService>(RegionService);
    }

    public Result<List<RegionService>> GetRegionServiceByFilter(PageFilter pf) {
        DBHelp dbHelp = new DBHelp();
        List<RegionService> RegionServices = (List<RegionService>) dbHelp.GetByFilter(pf,
                "RegionService");

        return new Result<List<RegionService>>(RegionServices);
    }
}
