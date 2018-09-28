package teamwish.duty.logic.device;
import teamwish.duty.dataContracts.common.*;
import teamwish.duty.dataContracts.device.*;
import teamwish.duty.logic.common.DBHelp;

import java.util.List;

public class Buss {
	public Result<DeviceInfo> GetDeviceInfoById(int id) {
		  DBHelp dbHelp=new DBHelp();
		  DeviceInfo DeviceInfo= (DeviceInfo)dbHelp.GetById(id,"DeviceInfo");
		  return new Result<DeviceInfo>(DeviceInfo);  
		 }
		 public Result<List<DeviceInfo>> GetDeviceInfoByFilter(PageFilter pf) {
		  DBHelp dbHelp=new DBHelp();
		  List<DeviceInfo> DeviceInfos= (List<DeviceInfo>)dbHelp.GetByFilter(pf,"DeviceInfo");
		  return new Result<List<DeviceInfo>>(DeviceInfos);
		  
		 }
		 public Result<DeviceInfo> SaveDeviceInfo(DeviceInfo deviceInfo)  {
		  DBHelp dbHelp=new DBHelp();  
		  if(deviceInfo.getId()==0) {
		   //initial something
		  }
		  deviceInfo=(DeviceInfo)dbHelp.Save(deviceInfo,"DeviceInfo",(deviceInfo.getId()==0));
		 
		  return new Result<DeviceInfo>(deviceInfo);  
		 }
		 public Result DeleteDeviceInfo(int id) {
		  DBHelp dbHelp=new DBHelp();  
		  dbHelp.Delete(id, "DeviceInfo");
		  
		  return new Result();  
		 }

}
