package teamwish.duty.logic.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javassist.bytecode.Descriptor.Iterator;
import teamwish.duty.dataContracts.common.*;

import teamwish.duty.logic.common.DBHelp;


public class CommonBuss {
    public String tableName = "";

    public Result GetRecordCount(String tableName, Condition[] conditions) {
        Integer count = getRecordCount(tableName, conditions);
        return new Result(count);
    }
    
    public Integer getRecordCount(String tableName, Condition[] conditions) {
        DBHelp dbHelp = new DBHelp(tableName);
        Integer count = dbHelp.GetRecordCount(tableName, conditions);
        return count;
    }

    public Result GetById(int id) {
        Object item = getById(id);

        return new Result(item);
    }
    
    public Object getById(int id) {
        DBHelp dbHelp = new DBHelp(tableName);
        return dbHelp.GetById(id);
    }
    
    public Result GetByCode(String code) {
        Object item = getByCode(code);

        return new Result(item);
    }
    
    public Object getByCode(String code) {
        DBHelp dbHelp = new DBHelp(tableName);
        return dbHelp.GetByCode(code);
    }

    public Result GetByFilter(PageFilter pf) {
        Object items = getByFilter(pf);
        return new Result(items);
    }
    
    public Object getByFilter(PageFilter pf) {
        DBHelp dbHelp = new DBHelp(tableName);
        return dbHelp.GetByFilter(pf);
    }
    
    public Result GetTreeByFilter(PageFilter pf) {
        Object items = getTreeByFilter(pf);
        return new Result(items);
    }
    
    public Object getTreeByFilter(PageFilter pf) {
        DBHelp dbHelp = new DBHelp(tableName);
        return dbHelp.GetTreeByFilter(pf);
    }
    
    public Result GetCountByFilter(PageFilter pf) {        
        int count = getCountByFilter(pf);
        return new Result(count);
    }
    
    public int getCountByFilter(PageFilter pf) {
        DBHelp dbHelp = new DBHelp(tableName);
        return dbHelp.GetRecordCount(tableName, pf.getConditions());
    }

    public Object Insert(Object request) {
        DBHelp dbHelp = new DBHelp(tableName);
        Object item = dbHelp.Save(request, true);

        return item;
    }

    public int Save(Object request) {
        DBHelp dbHelp = new DBHelp(tableName);
        int result = (int) dbHelp.Save(request, false);

        return result;
    }

    public Result Delete(int id) {
        int result = delete(id);

        return new Result(result);
    }
    
    public int delete(int id) {
        DBHelp dbHelp = new DBHelp(tableName);
        return dbHelp.Delete(id);
    }
    
    public int deleteFilter(Object request, String methodName) {
        DBHelp dbHelp = new DBHelp(tableName);
        return dbHelp.DeleteByFilter(request, methodName);
    }
    
    public Object GetMultiByRequest(Object request, String methodName) {
    	 DBHelp dbHelp = new DBHelp();
         return dbHelp.GetMultiByRequest(request, methodName);
    }
   
}
