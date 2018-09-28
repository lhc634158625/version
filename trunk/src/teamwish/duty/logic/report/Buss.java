package teamwish.duty.logic.report;

import teamwish.duty.dataContracts.common.*;
import teamwish.duty.dataContracts.duty.*;
import teamwish.duty.dataContracts.report.ReportInfo;
import teamwish.duty.dataContracts.report.ReportItem;
import teamwish.duty.dataContracts.report.RequestReport;
import teamwish.duty.logic.common.CommonBuss;
import teamwish.duty.logic.common.DBHelp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javassist.bytecode.Descriptor.Iterator;

public class Buss extends CommonBuss {

	public Buss(String tableName) {
		this.tableName = tableName;
	}
	public List<ReportItem> GetStationReport(RequestReport request) {		
		String methodName="GetStationDutyStateReport";
		String[] columns = new String[] { "派出所", "警务区", "在岗", "备勤", "巡逻车", "单兵设备", "ll0", "24小时接处警", "自接" };
		switch(request.getType()) {
		case "1":
			break;
		case "2":
			methodName="GetStationShiftReport";
			columns = new String[] { "执勤", "ll0", "待警", "其他勤务", "备勤" };
			break;
		case "3":
			methodName="GetStationCaseReport";
			columns = new String[] { "派出所", "警务区", "刑事", "治安", "民事", "交通", "ll0", "24小时接处警", "自接" };
			break;
		case "4":
			methodName="GetStationCaseReport";
			columns = new String[] { "派出所", "警务区", "巡逻车", "巡逻车在线", "单兵设备", "单兵设备在线"};
			break;
		}
		return GetReport(request, methodName, columns);
	}

	private List<ReportItem> GetReport(RequestReport request, String methodName, String[] columns) {
		DBHelp dbHelp = new DBHelp();
		List<ReportItem> reportItems= (List<ReportItem>) dbHelp.GetMultiByRequest(request,methodName);
		/*List<ReportInfo> reportInfos = new ArrayList();
		ReportInfo reportInfo = null;
		ReportItem reportItem;
		String preName="";
		Map<String, String> groupNames = new HashMap<String, String>();
		for (int i = 0; i < reportItems.size(); i++) {
			reportItem = reportItems.get(i);
			String groupName = reportItem.getGroupName();
			if(!preName.equals(groupName)&&preName.length()>0) {
				reportInfos.add(reportInfo);
			}
			if (!groupNames.containsKey(groupName)) {
				reportInfo = new ReportInfo();
				reportInfo.setName(groupName);
				groupNames.put(groupName, groupName);
			}
			SetReportInfo(columns, reportInfo, reportItem);
			
			
			preName=groupName;
		}
		if(reportInfo!=null)
		reportInfos.add(reportInfo);*/
		return reportItems;
	}
	
	
	private void SetReportInfo(String[] columns, ReportInfo reportInfo, ReportItem reportItem) {
		for (int j = 0; j < columns.length; j++) {
			if (reportItem.getName().equals(columns[j])) {
				if (j == 0)
					reportInfo.setAmount1(reportItem.getValue());
				if (j == 1)
					reportInfo.setAmount2(reportItem.getValue());
				if (j == 2)
					reportInfo.setAmount3(reportItem.getValue());
				if (j == 3)
					reportInfo.setAmount4(reportItem.getValue());
				if (j == 4)
					reportInfo.setAmount5(reportItem.getValue());
				if (j == 5)
					reportInfo.setAmount6(reportItem.getValue());
				if (j == 6)
					reportInfo.setAmount7(reportItem.getValue());
				if (j == 7)
					reportInfo.setAmount8(reportItem.getValue());
				if (j == 8)
					reportInfo.setAmount9(reportItem.getValue());
				if (j == 9)
					reportInfo.setAmount10(reportItem.getValue());
				if (j == 10)
					reportInfo.setAmount11(reportItem.getValue());
				if (j == 11)
					reportInfo.setAmount12(reportItem.getValue());
				if (j == 12)
					reportInfo.setAmount13(reportItem.getValue());
				if (j == 13)
					reportInfo.setAmount14(reportItem.getValue());
				if (j == 14)
					reportInfo.setAmount15(reportItem.getValue());
				if (j == 15)
					reportInfo.setAmount16(reportItem.getValue());
				if (j == 16)
					reportInfo.setAmount17(reportItem.getValue());
				if (j == 17)
					reportInfo.setAmount18(reportItem.getValue());
				if (j == 18)
					reportInfo.setAmount19(reportItem.getValue());
				if (j == 19)
					reportInfo.setAmount20(reportItem.getValue());

				break;
			}
		}
	}
}
