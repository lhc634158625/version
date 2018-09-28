package teamwish.duty.logic.sys;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import teamwish.duty.dataContracts.common.*;
import teamwish.duty.dataContracts.sys.*;
import teamwish.duty.logic.common.CommonBuss;
import teamwish.duty.logic.common.DBHelp;
import teamwish.common.Cache;
import teamwish.common.CacheManager;

public class Buss extends CommonBuss{
	
	long dt = 20 * 60 * 1000;
	
	public Buss(String tableName) {
		this.tableName = tableName;
	}	
	
	public Result CheckToken(String token){
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
		return new Result(curUser);		
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
		
	/**
	 * @param request
	 * @return
	 */
	public Result CheckUser(Request request) {
		DBHelp dbHelp = new DBHelp(tableName);
		
		PageFilter pf = new PageFilter();		
		List<Condition> conditions = new java.util.ArrayList<Condition>();		
		Condition condition = new Condition();
		condition.setFieldName("nickName");
		condition.setFieldType("String");
		condition.setOpt("=");		
		condition.setValue(request.getNickName());
		conditions.add(condition);
		
		pf.setConditions(conditions.toArray(new Condition[0]));
		
		pf.setFromRecord(0);
		pf.setPageSize(1);
		pf.setOrderField("Id");

		List<UserInfo> userInfos = (List<UserInfo>) dbHelp.GetByFilter(pf);
		if (userInfos.size() == 0) {
			return new Result(ResponseCode.UserNoExit, "用户不存在");
		}		
		UserInfo curUser = (UserInfo)(userInfos.get(0));
		
		String pwd = "";
		try {
			teamwish.common.Utils utils = new teamwish.common.Utils();
			pwd = utils.EncoderByMd5(request.getPassword());
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
		dbHelp.Save(curUser, false);
		
		
		curUser.setPassword("");
	    Cache cache= CacheManager.getCacheInfo(oldToken);
	    //if(cache != null) CacheManager.clearOnly(cache);
	    cache = new Cache();
		cache.setKey(token);
		cache.setValue(curUser);		
		cache.setTimeOut(dt + System.currentTimeMillis());
		cache.setExpired(false);		
		CacheManager.putCache(token, cache);
		
		return new Result(curUser);
	}

	public Result Logout(String token) {		
		Cache cache= CacheManager.getCacheInfo(token);
	    if(cache != null) CacheManager.clearOnly(cache);	    
		return new Result();
	}
	
	public Result ResetPwd(Request request) {
		DBHelp dbHelp = new DBHelp(tableName);
		UserInfo userInfo = (UserInfo) dbHelp.GetById(request.getId());

		String pwd = "";
		teamwish.common.Utils utils = new teamwish.common.Utils();
		try {
			
			pwd = utils.EncoderByMd5(request.getOldPwd());
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
			pwd = utils.EncoderByMd5(request.getNewPwd());
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		userInfo.setPassword(pwd);
		int count = (int)dbHelp.Save(userInfo, false);
		return new Result(count > 1);
	}
	
	public Result GetUserModule(UserInfo userInfo) {
		DBHelp dbHelp = new DBHelp("Module");
		PageFilter pf=new PageFilter();
		pf.setFilter("exists (select id from RoleModule where roleId="+userInfo.getRoleId()+" and roleModule.moduleId=module.id)");
		List<Module> modules= (List<Module>)dbHelp.GetByFilter(pf);
		return new Result(modules);
	}
	
	public Result GetStationTree(Request request) {
		DBHelp dbHelp=new DBHelp();
		List<Station> Station= (List<Station>)dbHelp.GetMultiByRequest(request,"GetStationTree");
		return new Result(Station);  
	}
	
	public Result GetSuperiorsById(Request request) {
		DBHelp dbHelp=new DBHelp();
		List<Station> Station= (List<Station>)dbHelp.GetMultiByRequest(request,"GetSuperiorsById");
		return new Result(Station);  
	}
	 
	public Result GetRoleModule(int roleId) {
		DBHelp dbHelp = new DBHelp("Module");
		PageFilter pf=new PageFilter();
	  	pf.setFilter("exists (select id from RoleModule where roleId="+roleId+" and roleModule.moduleId=module.id)");
	  	List<Module> modules= (List<Module>)dbHelp.GetByFilter(pf);
	  	return new Result(modules);
	}
	
	public Result GetRoleModuleTree(int roleId) {
		DBHelp dbHelp = new DBHelp("Module");
		PageFilter pf=new PageFilter();
		pf.setFilter("exists (select id from RoleModule where roleId="+roleId+" and roleModule.moduleId=module.id)");
		List<Module> modules= (List<Module>)dbHelp.GetByFilter(pf);
		pf.setFilter("1=1");
		List<Module> allModules= (List<Module>)dbHelp.GetByFilter(pf);
		for(int i=0;i<allModules.size();i++) {
			int id=allModules.get(i).getId();
			if(modules.stream().filter((p)->p.getId()==id).count()>0) {
				allModules.get(i).setSelected(true);
			}else
				allModules.get(i).setSelected(false);    				
		}
		
		return new Result(allModules);
	}
     
}