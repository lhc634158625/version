package teamwish.logic.sys;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;


import teamwish.dataContracts.common.*;
import teamwish.dataContracts.sys.*;
import teamwish.logic.base.DBHelp;
import teamwish.logic.common.Cache;
import teamwish.logic.common.CacheManager;

public class Buss {
	
	long dt = 20 * 60 * 1000;
	
	public Result<UserInfo> GetUserInfoById(int id) {
		DBHelp dbHelp = new DBHelp();
		UserInfo userInfo = (UserInfo) dbHelp.GetById(id, "UserInfo");
		return new Result<UserInfo>(userInfo);
	}

	public Result<List<UserInfo>> GetUserInfoByFilter(PageFilter pf) {
		DBHelp dbHelp = new DBHelp();
		List<UserInfo> userInfos = (List<UserInfo>) dbHelp.GetByFilter(pf, "UserInfo");
		return new Result<List<UserInfo>>(userInfos);
	}

	public Result<UserInfo> SaveUser(UserInfo userInfo) throws NoSuchAlgorithmException, UnsupportedEncodingException {
		DBHelp dbHelp = new DBHelp();
		if (userInfo.getId() == 0) {
			userInfo.setPassword(EncoderByMd5("123456"));
		}
		userInfo = (UserInfo) dbHelp.Save(userInfo, "UserInfo", (userInfo.getId() == 0));
		dbHelp.Commit();
		return new Result<UserInfo>(userInfo);
	}

	public Result DeleteUser(int id) {
		DBHelp dbHelp = new DBHelp();
		dbHelp.Delete(id, "UserInfo");
		dbHelp.Commit();
		return new Result();
	}
	
	public Result<UserInfo> CheckToken(String token){
		Cache cache= CacheManager.getCacheInfo(token);		
	    if(cache == null) {
	    	return new Result(ResponseCode.ErrorToken, "错误的TOKEN");	    
	    }
	    if(cache.isExpired()) {
	    	return new Result(ResponseCode.ExpToken, "过期的TOKEN");
	    }
	    
	    cache.setTimeOut(dt);
		cache.setExpired(false);
		
		UserInfo curUser = (UserInfo)cache.getValue();
		return new Result<UserInfo>(curUser);		
	}
	
	public int GetUserInfoByToken(String token){
		Cache cache= CacheManager.getCacheInfo(token);
		if(cache == null) {
	    	return ResponseCode.ErrorToken;	    
	    }
	    if(cache.isExpired()) {
	    	 return ResponseCode.ExpToken;
	    }	    
	    return 0;
	}
	
	public boolean UpdateUserTokenDt(String token){
		Cache cache= CacheManager.getCacheInfo(token);
		if(cache != null) {
		   CacheManager.putCacheInfo(token, cache, dt);
	    }   
	    return true;
	}

	public Result<UserInfo> CheckUser(Request request) {
		DBHelp dbHelp = new DBHelp();
		String filter = "nickName='" + request.getNickName() + "'";
		PageFilter pf = new PageFilter();
		pf.setFilter(filter);
		pf.setFromRecord(0);
		pf.setPageSize(1);
		pf.setOrderField("Id");

		List<UserInfo> userInfos = (List<UserInfo>) dbHelp.GetByFilter(pf, "UserInfo");
		if (userInfos.size() == 0) {
			return new Result(ResponseCode.UserNoExit, "用户不存在");
		}		
		UserInfo curUser = (UserInfo)(userInfos.get(0));
		
		String pwd = "";
		try {
			pwd = EncoderByMd5(request.getPassword());
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (!curUser.getPassword().equals(pwd)) {
			return new Result(ResponseCode.PasswordError, "密码错误");
		}
		
		String oldToken = curUser.getToken();
		String token = java.util.UUID.randomUUID().toString();
		
		curUser.setToken(token);
		dbHelp.Save(curUser, "UserInfo", false);
		dbHelp.Commit();
		
		curUser.setPassword("");
	    Cache cache= CacheManager.getCacheInfo(oldToken);
	    if(cache != null) CacheManager.clearOnly(cache);
	    cache = new Cache();
		cache.setKey(token);
		cache.setValue(curUser);
		cache.setTimeOut(dt + System.currentTimeMillis());
		cache.setExpired(false);		
		CacheManager.putCache(token, cache);
		
		return new Result<UserInfo>(curUser);
	}

	public Result Logout() {		
		UserInfo curUser = new UserInfo();		
		
		
		String oldToken = curUser.getToken();
	    Cache cache= CacheManager.getCacheInfo(oldToken);
	    if(cache != null) CacheManager.clearOnly(cache);
	    
		return new Result();
	}
	
	public Result ResetPwd(Request request) {
		DBHelp dbHelp = new DBHelp();
		UserInfo userInfo = (UserInfo) dbHelp.GetById(request.getId(), "UserInfo");

		String pwd = "";
		try {
			pwd = EncoderByMd5(request.getOldPwd());
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (!userInfo.getPassword().equals(pwd)) {
			return new Result(ResponseCode.PasswordError, "密码错误");
		}
		try {
			pwd = EncoderByMd5(request.getNewPwd());
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		userInfo.setPassword(pwd);
		dbHelp.Save(userInfo, "UserInfo", false);
		dbHelp.Commit();
		return new Result();
	}
	public Result<List<Module>> GetUserModule(UserInfo userInfo) {
		DBHelp dbHelp = new DBHelp();
		PageFilter pf=new PageFilter();
		pf.setFilter("exists (select id from RoleModule where roleId="+userInfo.getRoleId()+" and roleModule.moduleId=module.id)");
		List<Module> modules= (List<Module>)dbHelp.GetByFilter(pf,"Module");
		return new Result<List<Module>>(modules);
	}
	
	
	
	// 生成MD5
	public String EncoderByMd5(String str) throws NoSuchAlgorithmException, UnsupportedEncodingException {

		MessageDigest md5 = MessageDigest.getInstance("MD5");
		BASE64Encoder base64en = new BASE64Encoder();

		String newstr = base64en.encode(md5.digest(str.getBytes("utf-8")));
		return newstr;
	}

	/************************** Staff 警员表维护 *************************/
	public Result<Staff> GetStaffById(int id) {
		DBHelp dbHelp = new DBHelp();
		Staff Staff = (Staff) dbHelp.GetById(id, "Staff");
		return new Result<Staff>(Staff);
	}
	
	public Result<Staff> GetStaffByCode(String code) {
		DBHelp dbHelp = new DBHelp();
		Staff Staff = (Staff) dbHelp.GetByCode(code, "Staff");
		return new Result<Staff>(Staff);
	}

	public Result<List<Staff>> GetStaffByFilter(PageFilter pf) {
		DBHelp dbHelp = new DBHelp();
		List<Staff> Staffs = (List<Staff>) dbHelp.GetByFilter(pf, "Staff");
		return new Result<List<Staff>>(Staffs);

	}

	public Result<Staff> SaveStaff(Staff staff) {
		DBHelp dbHelp = new DBHelp();
		if (staff.getId() == 0) {
			// initial something
		}
		staff = (Staff) dbHelp.Save(staff, "Staff", (staff.getId() == 0));
		dbHelp.Commit();
		return new Result<Staff>(staff);
	}

	public Result DeleteStaff(int id) {
		DBHelp dbHelp = new DBHelp();
		dbHelp.Delete(id, "Staff");
		dbHelp.Commit();
		return new Result();
	}
    /***********单位信息业务实现********************/
   public Result<Station> GetStationById(int id) {
      DBHelp dbHelp=new DBHelp();
      Station Station= (Station)dbHelp.GetById(id,"Station");
      return new Result<Station>(Station);  
     }
     public Result<List<Station>> GetStationByFilter(PageFilter pf) {
      DBHelp dbHelp=new DBHelp();
      List<Station> Stations= (List<Station>)dbHelp.GetByFilter(pf,"Station");
      return new Result<List<Station>>(Stations);
      
     }
     public Result<Station> SaveStation(Station station)  {
      DBHelp dbHelp=new DBHelp();  
      if(station.getId()==0) {
       //initial something
      }
      station=(Station)dbHelp.Save(station,"Station",(station.getId()==0));
      dbHelp.Commit();
      return new Result<Station>(station);  
     }
     public Result DeleteStation(int id) {
      DBHelp dbHelp=new DBHelp();  
      dbHelp.Delete(id, "Station");
      dbHelp.Commit();
      return new Result();  
     }
     
     
     
     /***********业务实现********************/
     public Result<Role> GetRoleById(int id) {
       DBHelp dbHelp=new DBHelp();
       Role Role= (Role)dbHelp.GetById(id,"Role");
       return new Result<Role>(Role);  
      }
      public Result<List<Role>> GetRoleByFilter(PageFilter pf) {
       DBHelp dbHelp=new DBHelp();
       List<Role> roles= (List<Role>)dbHelp.GetByFilter(pf,"Role");
       return new Result<List<Role>>(roles);
       
      }
      public Result<Role> SaveRole(Role role)  {
       DBHelp dbHelp=new DBHelp();  
       if(role.getId()==0) {
        //initial something
       }
       role=(Role)dbHelp.Save(role,"Role",(role.getId()==0));
       dbHelp.Commit();
       return new Result<Role>(role);  
      }
      public Result DeleteRole(int id) {
       DBHelp dbHelp=new DBHelp();  
       dbHelp.Delete(id, "Role");
       dbHelp.Commit();
       return new Result();  
      }

      public Result<List<Module>> GetRoleModule(int roleId) {
  		DBHelp dbHelp = new DBHelp();
  		PageFilter pf=new PageFilter();
  		pf.setFilter("exists (select id from RoleModule where roleId="+roleId+" and roleModule.moduleId=module.id)");
  		List<Module> modules= (List<Module>)dbHelp.GetByFilter(pf,"Module");
  		return new Result<List<Module>>(modules);
  	}
      public Result<List<Module>> GetRoleModuleTree(int roleId) {
    		DBHelp dbHelp = new DBHelp();
    		PageFilter pf=new PageFilter();
    		pf.setFilter("exists (select id from RoleModule where roleId="+roleId+" and roleModule.moduleId=module.id)");
    		List<Module> modules= (List<Module>)dbHelp.GetByFilter(pf,"Module");
    		pf.setFilter("1=1");
    		List<Module> allModules= (List<Module>)dbHelp.GetByFilter(pf,"Module");
    		for(int i=0;i<allModules.size();i++) {
    			int id=allModules.get(i).getId();
    			if(modules.stream().filter((p)->p.getId()==id).count()>0) {
    				allModules.get(i).setSelected(true);
    			}else
    				allModules.get(i).setSelected(false);    				
    		}
    		
    		return new Result<List<Module>>(allModules);
    	}
      public Result SaveRoleModule(Request request) {
  		DBHelp dbHelp = new DBHelp();
  		PageFilter pf=new PageFilter();
  		pf.setFilter("Delete from roleModule where roleId='"+String.valueOf(request.getRoleId())+"' and ModuleId not in ("+request.getModuleIds()+")");
  		dbHelp.DeleteByFilter(pf, "DeleteModuleByFilter");
  		
  		String[] moduleIds=request.getModuleIds().split(",");
  	
  		for(int i=0;i<moduleIds.length;i++) {
  					
  		}
  		
  		return new Result();
  	}
     
}