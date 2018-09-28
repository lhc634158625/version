package teamwish.duty.logic.staff;

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
	
	public Buss(String tableName) {
		this.tableName = tableName;
	}	
	
    
}