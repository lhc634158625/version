package teamwish.logic.device;
import teamwish.dataContracts.common.*;
import teamwish.dataContracts.device.*;
import teamwish.logic.base.DBHelp;

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
		  dbHelp.Commit();
		  return new Result<DeviceInfo>(deviceInfo);  
		 }
		 public Result DeleteDeviceInfo(int id) {
		  DBHelp dbHelp=new DBHelp();  
		  dbHelp.Delete(id, "DeviceInfo");
		  dbHelp.Commit();
		  return new Result();  
		 }

}
