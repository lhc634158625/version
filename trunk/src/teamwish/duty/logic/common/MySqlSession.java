package teamwish.duty.logic.common;

import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMapping;

import teamwish.common.JDBCHelper;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;

import java.util.List;
import java.util.Map;


public class MySqlSession {
    public int delete(String statement, Object params) {
        BoundSql boundSql = GetBoundSql(statement, params);
        List<ParameterMapping> parmaeters = boundSql.getParameterMappings();
        Object[] objs = getParams(params, parmaeters);

        JDBCHelper util = new JDBCHelper();
        String sql = util.formatSql(boundSql.getSql(), params, parmaeters);
        System.out.println("SQL：[" + sql + "]");

        return util.executeUpdate(boundSql.getSql(), objs);
    }

    public Object insert(String statement, Object params) {
        BoundSql boundSql = GetBoundSql(statement, params);
        List<ParameterMapping> parmaeters = boundSql.getParameterMappings();
        Object[] objs = getParams(params, parmaeters);

        JDBCHelper util = new JDBCHelper();
        String sql = util.formatSql(boundSql.getSql(), params, parmaeters);
        System.out.println("SQL：[" + sql + "]");

        Object id = util.executeUpdateReturnKey(boundSql.getSql(), objs);

        return id;
    }

    public int save(String statement, Object params) {
        BoundSql boundSql = GetBoundSql(statement, params);
        List<ParameterMapping> parmaeters = boundSql.getParameterMappings();
        Object[] objs = getParams(params, parmaeters);

        JDBCHelper util = new JDBCHelper();
        String sql = util.formatSql(boundSql.getSql(), params, parmaeters);
        System.out.println("SQL：[" + sql + "]");

        int count = util.executeUpdate(boundSql.getSql(), objs);

        return count;
    }

    public List<Object> selectList(String statement, Object params) {
        BoundSql boundSql = GetBoundSql(statement, params);
        List<ParameterMapping> parmaeters = boundSql.getParameterMappings();
        Object[] objs = getParams(params, parmaeters);

        JDBCHelper util = new JDBCHelper();
        String sql = util.formatSql(boundSql.getSql(), params, parmaeters);
        System.out.println("SQL：[" + sql + "]");

        List<Object> _result = util.excuteQuery(boundSql.getSql(), objs);

        if ((_result == null) || (_result.size() == 0)) {
            return _result;
        }

        List<Object> result = new java.util.ArrayList<Object>();

        try {
            String resultType = getResultType(statement);
            Class<?> clz = Class.forName(resultType);

            for (Object _item : _result) {
                try {
                    Object item = mapToObject((Map) _item, clz);
                    result.add(item);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return result;
    }

    public Object selectOne(String statement, Object params) {
        BoundSql boundSql = GetBoundSql(statement, params);
        List<ParameterMapping> parmaeters = boundSql.getParameterMappings();
        Object[] objs = getParams(params, parmaeters);

        JDBCHelper util = new JDBCHelper();
        String sql = util.formatSql(boundSql.getSql(), params, parmaeters);
        System.out.println("SQL：[" + sql + "]");

        Object _result = util.excuteQueryOne(boundSql.getSql(), objs);

        if (_result == null) {
            return _result;
        }

        Object result = null;

        try {
        	if(_result instanceof Map) {
        		String resultType = getResultType(statement);
                Class<?> clz = Class.forName(resultType);

                try {
                    result = mapToObject((Map) _result, clz);
                } catch (Exception e) {
                    e.printStackTrace();
                }
        	}
        	else {
        		return _result;
        	}            
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return result;
    }

    private BoundSql GetBoundSql(String statement, Object parameter) {
        MappedStatement ms = SqlSessionFactoryUtil.getInstance()
                                                  .getConfiguration()
                                                  .getMappedStatement(statement);
        BoundSql boundSql = ms.getBoundSql(parameter);

        return boundSql;
    }

    private Object[] getParams(Object params, List<ParameterMapping> parmaeters) {
        List<Object> objs = new java.util.ArrayList<Object>();

        if (parmaeters.size() == 0) {
            return objs.toArray();
        }

        if ((parmaeters.size() == 1) &&
                (params.getClass().getName() == parmaeters.get(0).getJavaType()
                                                              .getName())) {
            objs.add(params);
        } else {
            for (ParameterMapping item : parmaeters) {
                objs.add(get(params, item.getProperty()));
            }
        }

        return objs.toArray();
    }

    private String getResultType(String statement) {
        Map<String, teamwish.duty.logic.common.MappedStatement> mappedStatements =
            SqlSessionFactoryUtil.getInstance().getMappedStatements();
        teamwish.duty.logic.common.MappedStatement mappedStatement = mappedStatements.get(statement);

        if (mappedStatement == null) {
            return "";
        }

        return mappedStatement.getResultType();
    }

    public Object mapToObject(Map<String, Object> map, Class<?> beanClass)
        throws Exception {
        if (map == null) {
            return null;
        }

        Object obj = beanClass.newInstance();

        Field[] fields = obj.getClass().getDeclaredFields();

        for (Field field : fields) {
            int mod = field.getModifiers();

            if (Modifier.isStatic(mod) || Modifier.isFinal(mod)) {
                continue;
            }

            if (map.containsKey(field.getName())) {
                try {
                    field.setAccessible(true);

                    Object value = map.get(field.getName());

                    if (value == null) {
                        continue;
                    }

                    if (field.getType().getName() == "java.lang.String") {
                        field.set(obj, map.get(field.getName()).toString());
                    } else {
                        field.set(obj, map.get(field.getName()));
                    }
                } catch (Exception e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
        }

        return obj;
    }

    /**
    * 通过反射获取属性值
    */
    public Object get(Object object, String propertyName) {
        if ((object != null) && (propertyName != null)) {
            return get(object, object.getClass(), propertyName);
        }

        return null;
    }

    public Object get(Object object, Class<?> clazz, String propertyName) {
        if ((object != null) && (clazz != null) && (propertyName != null) &&
                (clazz != Object.class)) {
            try {
                Field field = clazz.getDeclaredField(propertyName);
                field.setAccessible(true);

                return field.get(object);
            } catch (NoSuchFieldException e) {
                return get(object, clazz.getSuperclass(), propertyName);
            } catch (Exception e) {
                return null;
            }
        }

        return null;
    }
}
