package teamwish.logic.base;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import teamwish.dataContracts.common.*;


public class DBHelp {
	SqlSession ss = null;
	SqlSessionFactory sqlSessionFactory;
	public DBHelp() {
		String resource = "config/mybatis.config.xml";
		InputStream inputStream;
		
		try {
			inputStream = Resources.getResourceAsStream(resource);

			SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
			ss = sqlSessionFactory.openSession();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();			
		}
	}
	protected void finalize( )
	{
		ss.close();
	// finalization code here
	}
	public void Commit() {
		
		ss.commit();
		
	}
	public Object GetById(int id, String tableName) {
		
	
			return ss.selectOne("config.Get" + tableName + "ById", id);

		
	}
	
	public Object GetByCode(String code, String tableName) {
		
		
		return ss.selectOne("config.Get" + tableName + "ByCode", code);

	
}

	public Object GetByFilter(PageFilter filter, String tableName) {		
		
			if(filter.getFilter()==null) {
				List<Condition> conditions=java.util.Arrays.asList(filter.getConditions());
				filter.setFilter(GetFilterByCondition(conditions));
			}		
			filter.setToRecord(filter.getFromRecord()+filter.getPageSize());
			return ss.selectList("config.Get" + tableName + "ByFilter", filter);

	}
	public Object GetMultiByRequest(Request request, String methodName) {
		return ss.selectList("config." + methodName , request);

}
	public Object Save(Object data, String tableName, boolean isInsert) {
		
		
			if (isInsert)
				ss.insert("config.Insert" + tableName, data);
			else
				ss.update("config.Update" + tableName, data);
			
			return data;

		
	}

	public Object Delete(int id, String tableName) {
		
	
			ss.delete("config.Delete" + tableName, id);

			return null;		
	}
	public Object DeleteByFilter(PageFilter pf, String methodName) {		
		
		ss.delete("config." + methodName, pf);

		return null;		
}
	public Result<Integer> GetRecordCount(String tableName,Condition[] conditions) {
			RecordCountParam rcParam = new RecordCountParam();
			String filter=GetFilterByCondition(java.util.Arrays.asList(conditions));			
			rcParam.setFilter(filter);
			rcParam.setTableName(tableName);
			Integer rc = ss.selectOne("config.getRecordCount", rcParam);
	
			return new Result<Integer>(rc);	
	}

	public static String GetFilterByCondition(List<Condition> conditions) {
		if (conditions == null)
			return "1=1";

		String filter = "";
		String opt;
		for (Condition item : conditions) {
			opt = item.getOpt().trim().toLowerCase();
			if (opt.equals("=") || opt.equals(">=") || opt.equals("<=") ||opt.equals( ">") ||opt.equals("<") ||opt.equals("<")
					|| opt.equals( "<>")) {
				filter += " (" + item.getFieldName() + opt + GetFieldValue(item.getValue(), item.getFieldType())
						+ ") and ";
			}
			if (opt.equals("in") || opt.equals( "not in")) {
				filter += " (" + item.getFieldName() + " " + opt + " (" + item.getValue() + " )) and ";
			}
			if (opt.equals("is") || opt.equals( "is not")) {
				filter += " (" + item.getFieldName() + " " + opt + " " + item.getValue() + " ) and ";
			}
			if (opt.equals("exists") || opt.equals("not exists")) {
				filter += " " + opt + " (" + item.getValue() + " ) and ";
			}
			if (opt.equals("包含")) {
				filter += " (" + item.getFieldName() + " like '%" + item.getValue() + "%') and ";
			}
			if (opt.equals("前包含")) {
				filter += " (" + item.getFieldName() + " like '%" + item.getValue() + "') and ";
			}
			if (opt.equals("后包含")) {
				filter += " (" + item.getFieldName() + " like '" + item.getValue() + "%') and ";
			}
			if (opt.equals("自定义")) {
				filter += " (" + item.getValue() + ") and ";
			}
		}

		if (filter.length() > 0)
			filter = filter.substring(0, filter.length() - 4);

		if (filter.isEmpty())
			filter = "1=1";
		return filter;
	}

	private static String GetFieldValue(String value, String fieldType) {
		if (fieldType.toLowerCase().equals("number"))
			return value;
		return "'" + value.replace("'", "") + "'";
	}
}
