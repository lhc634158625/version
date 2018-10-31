package teamwish.duty.logic.common;

import teamwish.duty.dataContracts.common.*;

import java.util.List;


public class DBHelp {
    private String tableName = "";

    public DBHelp() {
    }

    public DBHelp(String tableName) {
        this.tableName = tableName;
    }

    public Object GetById(int id) {
        MySqlSession mySqlSession = new MySqlSession();

        return mySqlSession.selectOne("config.Get" + tableName + "ById", id);
    }

    public Object GetByCode(String code) {
        MySqlSession mySqlSession = new MySqlSession();

        return mySqlSession.selectOne("config.Get" + tableName + "ByCode", code);
    }

    public Object GetByFilter(PageFilter filter) {
        String filterStr = GetFilter(filter);
        filter.setFilter(filterStr);

        if ((filter.getPage() - 1) < 0) {
            filter.setPage(1);
        }

        filter.setFromRecord((filter.getPage() - 1) * filter.getPageSize());
        filter.setToRecord(filter.getFromRecord() + filter.getPageSize());

        MySqlSession mySqlSession = new MySqlSession();

        return mySqlSession.selectList("config.Get" + tableName + "ByFilter",
            filter);
    }
    
    public Object GetTreeByFilter(PageFilter filter) {
        String filterStr = GetFilter(filter);
        filter.setFilter(filterStr);

        if ((filter.getPage() - 1) < 0) {
            filter.setPage(1);
        }

        filter.setFromRecord((filter.getPage() - 1) * filter.getPageSize());
        filter.setToRecord(filter.getFromRecord() + filter.getPageSize());

        MySqlSession mySqlSession = new MySqlSession();

        return mySqlSession.selectList("config.Get" + tableName + "TreeByFilter",
            filter);
    }

    public int GetCountByFilter(PageFilter filter) {
        RecordCountParam param = GetRecordCountParam(filter, tableName);

        MySqlSession mySqlSession = new MySqlSession();

        return (int) mySqlSession.selectOne("config.Get" + tableName + "CountByFilter", param);
    }

    public Integer GetRecordCount(String _tableName, Condition[] conditions) {
        PageFilter filter = new PageFilter();
        filter.setConditions(conditions);

        RecordCountParam param = GetRecordCountParam(filter, _tableName);

        MySqlSession mySqlSession = new MySqlSession();

        return (int) mySqlSession.selectOne("config.getRecordCount", param);
    }

    public Object GetMultiByRequest(Object request, String methodName) {
        MySqlSession mySqlSession = new MySqlSession();

        return mySqlSession.selectList("config." + methodName, request);
    }

    public Object Save(Object data, boolean isInsert) {
        if (isInsert) {
            MySqlSession mySqlSession = new MySqlSession();

            return mySqlSession.insert("config.Insert" + tableName, data);
        } else {
            MySqlSession mySqlSession = new MySqlSession();

            return mySqlSession.save("config.Update" + tableName, data);
        }
    }

    public int Delete(int id) {
        MySqlSession mySqlSession = new MySqlSession();

        return mySqlSession.delete("config.Delete" + tableName, id);
    }
    
    public int DeleteByFilter(Object request, String methodName) {
        MySqlSession mySqlSession = new MySqlSession();

        return mySqlSession.delete("config." + methodName, request);
    }

    private RecordCountParam GetRecordCountParam(PageFilter pf, String _tableName) {
        Condition[] conditions = pf.getConditions();

        RecordCountParam rcParam = new RecordCountParam();

        if (conditions == null) {
            rcParam.setFilter("1=1");
        } else {
            String filter = GetFilterByCondition(java.util.Arrays.asList(conditions));
            rcParam.setFilter(filter);
        }

        rcParam.setTableName(_tableName);

        return rcParam;
    }

    private String GetFilter(PageFilter pf) {
        Condition[] conditions = pf.getConditions();

        String filter = "";

        if (conditions == null) {
            filter = "1=1";
        } else {
            filter = GetFilterByCondition(java.util.Arrays.asList(conditions));
        }

        return filter;
    }

    private String GetFilterByCondition(List<Condition> conditions) {
        if ((conditions == null) || (conditions.size() == 0)) {
            return "1=1";
        }

        String filter = "";
        String opt;

        for (Condition item : conditions) {
            opt = item.getOpt().trim().toLowerCase();

            if (opt.equals("=") || opt.equals(">=") || opt.equals("<=") ||
                    opt.equals(">") || opt.equals("<") || opt.equals("<") ||
                    opt.equals("<>")) {
                filter += (" (" + item.getFieldName() + opt +
                GetFieldValue(item.getValue(), item.getFieldType()) + ") and ");
            }

            else if (opt.equals("in") || opt.equals("not in")) {
                filter += (" (" + item.getFieldName() + " " + opt + " (" +
                item.getValue() + " )) and ");
            }

            else if (opt.equals("is") || opt.equals("is not")) {
                filter += (" (" + item.getFieldName() + " " + opt + " " +
                item.getValue() + " ) and ");
            }

            else if (opt.equals("包含")) {
                filter += (" (" + item.getFieldName() + " like '%" +
                item.getValue() + "%') and ");
            }

            else if (opt.equals("前包含")) {
                filter += (" (" + item.getFieldName() + " like '%" +
                item.getValue() + "') and ");
            }

            else if (opt.equals("后包含")) {
                filter += (" (" + item.getFieldName() + " like '" +
                item.getValue() + "%') and ");
            }
            else {
            	conditions.remove(item);
            }
            
        }

        if (filter.length() > 0) {
            filter = filter.substring(0, filter.length() - 4);
        }

        if (filter.isEmpty()) {
            filter = "1=1";
        }

        return filter;
    }

    private String GetFieldValue(String value, String fieldType) {
        if (fieldType.toLowerCase().equals("number")) {
            return value;
        }

        return "'" + value.replace("'", "") + "'";
    }
}
