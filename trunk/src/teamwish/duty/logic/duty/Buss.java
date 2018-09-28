package teamwish.duty.logic.duty;

import teamwish.duty.dataContracts.duty.*;
import teamwish.duty.logic.common.CommonBuss;
import teamwish.duty.logic.common.DBHelp;

import java.util.List;


public class Buss extends CommonBuss {

	public Buss(String tableName) {
		this.tableName = tableName;
	}

	public VTStation GetVTStationById(RequestDuty request) {
       
    	DBHelp dbHelp = new DBHelp();
        List<VTStation> stations = (List<VTStation>) dbHelp.GetMultiByRequest(request,
                "GetVTStationById");

        if (stations != null) {
            return stations.get(0);
        } else {
            return null;
        }
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
    
}
