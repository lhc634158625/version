package teamwish.duty.logic.common;

import teamwish.duty.dataContracts.common.*;

import teamwish.duty.logic.common.DBHelp;


public class CommonBuss {
    public String tableName = "";

    public Result GetRecordCount(String tableName, Condition[] conditions) {
        DBHelp dbHelp = new DBHelp(tableName);
        Integer count = dbHelp.GetRecordCount(tableName, conditions);

        return new Result(count);
    }

    public Result GetById(int id) {
        DBHelp dbHelp = new DBHelp(tableName);
        Object item = dbHelp.GetById(id);

        return new Result(item);
    }

    public Result GetByFilter(PageFilter pf) {
        DBHelp dbHelp = new DBHelp(tableName);
        Object items = dbHelp.GetByFilter(pf);

        return new Result(items);
    }

    public Object Insert(Object request) {
        DBHelp dbHelp = new DBHelp(tableName);
        Object item = dbHelp.Save(request, true);

        return item;
    }

    public int Save(Object request) {
        DBHelp dbHelp = new DBHelp();
        int result = (int) dbHelp.Save(request, false);

        return result;
    }

    public Result Delete(int id) {
        DBHelp dbHelp = new DBHelp(tableName);
        int result = dbHelp.Delete(id);

        return new Result(result);
    }
}
