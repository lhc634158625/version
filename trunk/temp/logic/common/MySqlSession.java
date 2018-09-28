package teamwish.duty.logic.common;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMapping;
import teamwish.common.JDBCHelper;

public class MySqlSession {	
	
	public int delete(String statement, Object params) {
		
		BoundSql boundSql = GetBoundSql(statement, params);
		List<ParameterMapping> parmaeters = boundSql.getParameterMappings();
		Object[] objs = getParams(params, parmaeters);
		
		JDBCHelper util = new JDBCHelper();		
		return util.executeUpdate(boundSql.getSql(), objs);		
	}	
	
	public Object insert(String statement, Object params) {
		
		BoundSql boundSql = GetBoundSql(statement, params);
		List<ParameterMapping> parmaeters = boundSql.getParameterMappings();
		Object[] objs = getParams(params, parmaeters);
		
		JDBCHelper util = new JDBCHelper();	
		Object id = util.executeUpdateReturnKey(boundSql.getSql(), objs);	
		
		return id;
	}
	
	public int save(String statement, Object params) {
		
		BoundSql boundSql = GetBoundSql(statement, params);
		List<ParameterMapping> parmaeters = boundSql.getParameterMappings();
		Object[] objs = getParams(params, parmaeters);
		
		JDBCHelper util = new JDBCHelper();	
		int count = util.executeUpdate(boundSql.getSql(), objs);
		
		return count;
	}
		
	public List<Object> selectList(String statement, Object params) {
		
		BoundSql boundSql = GetBoundSql(statement, params);
		List<ParameterMapping> parmaeters = boundSql.getParameterMappings();
		Object[] objs = getParams(params, parmaeters);
		
		JDBCHelper util = new JDBCHelper();		
		List<Object> _result = util.excuteQuery(boundSql.getSql(), objs);
	    if(_result == null || _result.size() == 0) return _result;
	    
	    
		List<Object> result = new java.util.ArrayList<Object>();
		try {
			String resultType = getResultType(statement);
			Class<?> clz = Class.forName(resultType);						
			for(Object _item : _result) {
				try {
				  Object item = mapToObject((Map)_item, clz);
				  result.add(item);
				} catch (Exception e) {
					//result.add(item);
				}
			}				
		} catch (ClassNotFoundException e) {
			
		}		
		return result;
	}
	
	public Object selectOne(String statement, Object params) {
		
		BoundSql boundSql = GetBoundSql(statement, params);
		List<ParameterMapping> parmaeters = boundSql.getParameterMappings();
		Object[] objs = getParams(params, parmaeters);
		
		JDBCHelper util = new JDBCHelper();		
		Object _result = util.excuteQueryOne(boundSql.getSql(), objs);
		if(_result == null) return _result;
		
		Object result = null;
		try {
			String resultType = getResultType(statement);
			Class<?> clz = Class.forName(resultType);						
			
			try {
			  result = mapToObject((Map)_result, clz);
			} catch (Exception e) {
				//result.add(item);
			}
						
		} catch (ClassNotFoundException e) {
			
		}
		return result;
	}

	

	public int selectCount(String statement, Object parameter) {
		Object obj = selectOne(statement, parameter);
		if(obj == null) return 0;
		Object count = 0;
		try {
			count = mapToObject((Map)obj, int.class);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return (int)count;
	}
	
	private BoundSql GetBoundSql(String statement, Object parameter){
	    	  	
    	MappedStatement ms = SqlSessionFactoryUtil.getInstance().getConfiguration().getMappedStatement(statement);    	
        BoundSql boundSql =  ms.getBoundSql(parameter);
                                
        return boundSql;
    }
	
	private Object[] getParams(Object params, List<ParameterMapping> parmaeters) {
		List<Object> objs = new java.util.ArrayList<Object>();
		
		if(parmaeters.size() >0){			
			if(parmaeters.size() == 1) {
				if(params.getClass().getName() == parmaeters.get(0).getJavaType().getName()) {
					objs.add(params);
				}
			}
			else {				
				for(ParameterMapping item : parmaeters) {
					objs.add(get(params, item.getProperty()));
				}
			}
		}
		return objs.toArray();
	}
	
	private String getResultType(String statement) {
		Map<String, teamwish.duty.logic.common.MappedStatement> mappedStatements = SqlSessionFactoryUtil.getInstance().getMappedStatements();
		teamwish.duty.logic.common.MappedStatement mappedStatement =mappedStatements.get(statement);
		if(mappedStatement == null) return "";
		return mappedStatement.getResultType();
	}
	
	public Object mapToObject(Map<String, Object> map, Class<?> beanClass) throws Exception {    
        if (map == null)  
            return null;    
  
        Object obj = beanClass.newInstance();  
  
        Field[] fields = obj.getClass().getDeclaredFields();   
        for (Field field : fields) {    
            int mod = field.getModifiers();    
            if(Modifier.isStatic(mod) || Modifier.isFinal(mod)){    
                continue;    
            }    
  
            field.setAccessible(true);    
            field.set(obj, map.get(field.getName()));   
        }   
  
        return obj;    
    } 
	
	/**
     * 通过反射获取属性值
     */
    public Object get(Object object, String propertyName) {
    	if (object != null && propertyName != null) {
            return get(object, object.getClass(), propertyName);
        }
        return null;
    }
    public Object get(Object object,Class clazz, String propertyName) {
        if (object != null&&clazz!=null && propertyName != null&&clazz!=Object.class) {
            try {
                Field field = clazz.getDeclaredField(propertyName);
                field.setAccessible(true);
                return field.get(object);
            } catch (NoSuchFieldException e) {
                return get(object, clazz.getSuperclass(), propertyName);
            }catch (Exception e) {
                return null;
            }
        }
        return null;
    }
 
}
