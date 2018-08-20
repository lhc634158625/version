package teamwish.logic.duty;

import java.util.List;

import teamwish.dataContracts.common.*;
import teamwish.dataContracts.duty.*;
import teamwish.logic.base.DBHelp;

public class Buss {
	public Result<ArrangeInfo> GetArrangeInfoById(int id) {
		DBHelp dbHelp = new DBHelp();
		ArrangeInfo arrangeInfo = (ArrangeInfo) dbHelp.GetById(id, "ArrangeInfo");
		return new Result<ArrangeInfo>(arrangeInfo);
	}

	public Result<List<ArrangeInfo>> GetArrangeInfoByFilter(PageFilter pf) {
		DBHelp dbHelp = new DBHelp();
		List<ArrangeInfo> arrangeInfos = (List<ArrangeInfo>) dbHelp.GetByFilter(pf, "ArrangeInfo");
		return new Result<List<ArrangeInfo>>(arrangeInfos);
	}

	public Result<ArrangeInfo> SaveArrangeInfo(ArrangeInfo arrangeInfo) {
		DBHelp dbHelp = new DBHelp();
		if (arrangeInfo.getId() == 0) {
			// initial something
		}
		arrangeInfo = (ArrangeInfo) dbHelp.Save(arrangeInfo, "ArrangeInfo", (arrangeInfo.getId() == 0));
		dbHelp.Commit();
		return new Result<ArrangeInfo>(arrangeInfo);
	}

	public Result DeleteArrangeInfo(int id) {
		DBHelp dbHelp = new DBHelp();
		dbHelp.Delete(id, "ArrangeInfo");
		dbHelp.Commit();
		return new Result();
	}
	public Result<List<ArrangeInfoReport>> GetArrangeReport(Request request) {
		DBHelp dbHelp = new DBHelp();
		List<ArrangeInfoReport> arrangeReports = (List<ArrangeInfoReport>)dbHelp.GetMultiByRequest(request, "GetArrangeReport");	
		return new Result<List<ArrangeInfoReport>>(arrangeReports);
	}
	public Result<List<ArrangeInfo>>  GetSubArrange(Request request) {
		DBHelp dbHelp = new DBHelp();
		List<ArrangeInfo> arrangeInfos = (List<ArrangeInfo>) dbHelp.GetMultiByRequest(request, "GetSubArrange");	
		return new Result<List<ArrangeInfo>>(arrangeInfos);
	}
	
	
	/***********警情业务实现********************/
	public Result<RegionService> GetRegionServiceById(int id) {
	  DBHelp dbHelp=new DBHelp();
	  RegionService RegionService= (RegionService)dbHelp.GetById(id,"RegionService");
	  return new Result<RegionService>(RegionService);  
	 }
	 public Result<List<RegionService>> GetRegionServiceByFilter(PageFilter pf) {
	  DBHelp dbHelp=new DBHelp();
	  List<RegionService> RegionServices= (List<RegionService>)dbHelp.GetByFilter(pf,"RegionService");
	  return new Result<List<RegionService>>(RegionServices);
	  
	 }
	
	
}