package teamwish.common;

import org.apache.commons.collections4.map.CaseInsensitiveMap;

import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.session.defaults.DefaultSqlSession.StrictMap;

import java.lang.reflect.Field;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;


public class JDBCHelper {
    /**
     * 创建数据库连接对象
     */
    private Connection connnection = null;

    /**
     * 创建PreparedStatement对象
     */
    private PreparedStatement preparedStatement = null;

    /**
     * 创建CallableStatement对象
     */
    private CallableStatement callableStatement = null;

    /**
     * 创建结果集对象
     */
    private ResultSet resultSet = null;
    private int type = 1;

    public JDBCHelper() {
    }

    public JDBCHelper(int _type) {
        this.type = _type;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    /**
     * 建立数据库连接
     * @return 数据库连接
     * @throws Exception
     */
    public Connection getConnection() throws Exception {
        try {
            // 获取连接  
            //connnection =  DataSourceUtil.getDataSource(type).getConnection();
            connnection = DruidManager.getInstance().getConnection(this.type);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return connnection;
    }

    /**
     * insert SQL语句的执行的统一方法
     * @param sql SQL语句
     * @param params 参数数组，若没有参数则为null
     * @return 受影响的主键
     * @throws Exception
     */
    public String executeUpdateReturnKey(String sql, Object[] params) {
        long startTime = System.currentTimeMillis();

        //返回自动生成键的值
        Object keys = "";

        // 受影响的行数  
        int affectedLine = 0;

        try {
            // 获得连接  
            connnection = this.getConnection();
            // 调用SQL   
            preparedStatement = connnection.prepareStatement(sql,
                    Statement.RETURN_GENERATED_KEYS);

            // 参数赋值  
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    preparedStatement.setObject(i + 1, params[i]);
                }
            }

            // 执行  
            affectedLine = preparedStatement.executeUpdate();

            if (affectedLine == 0) {
                return "";
            }

            if (affectedLine > 0) {
                resultSet = preparedStatement.getGeneratedKeys();

                if ((resultSet != null) && resultSet.next()) {
                    keys = resultSet.getObject(1);
                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        } finally {
            // 释放资源  
            closeAll();

            long endTime = System.currentTimeMillis();
            long sqlCost = endTime - startTime;
            System.out.println("SQL：[" + formatSql(sql, null, null) + "]执行耗时[" +
                sqlCost + "ms]");
        }

        return (keys == null) ? "" : keys.toString();
    }

    /**
     * insert update delete SQL语句的执行的统一方法
     * @param sql SQL语句
     * @param params 参数数组，若没有参数则为null
     * @return 受影响的行数
     * @throws Exception
     */
    public int executeUpdate(String sql, Object[] params) {
        long startTime = System.currentTimeMillis();

        // 受影响的行数  
        int affectedLine = 0;

        try {
            // 获得连接  
            connnection = this.getConnection();
            // 调用SQL   
            preparedStatement = connnection.prepareStatement(sql);

            // 参数赋值  
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    preparedStatement.setObject(i + 1, params[i]);
                }
            }

            // 执行  
            affectedLine = preparedStatement.executeUpdate();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        } finally {
            // 释放资源  
            closeAll();

            long endTime = System.currentTimeMillis();
            long sqlCost = endTime - startTime;
            System.out.println("SQL：[" + formatSql(sql, null, null) + "]执行耗时[" +
                sqlCost + "ms]");
        }

        return affectedLine;
    }

    /**
     * SQL 查询将查询结果直接放入ResultSet中
     * @param sql SQL语句
     * @param params 参数数组，若没有参数则为null
     * @return 结果集
     * @throws Exception
     */
    private ResultSet executeQueryRS(String sql, Object[] params) {
        long startTime = System.currentTimeMillis();

        try {
            // 获得连接  
            connnection = this.getConnection();

            // 调用SQL  
            preparedStatement = connnection.prepareStatement(sql);

            // 参数赋值  
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    preparedStatement.setObject(i + 1, params[i]);
                }
            }

            // 执行  
            resultSet = preparedStatement.executeQuery();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        } finally {
            long endTime = System.currentTimeMillis();
            long sqlCost = endTime - startTime;
            System.out.println("SQL：[" + formatSql(sql, null, null) + "]执行耗时[" +
                sqlCost + "ms]");
        }

        return resultSet;
    }

    /**
     * 获取结果集，并将结果放在List中
     *
     * @param sql
     *            SQL语句
     * @return List
     *                       结果集
     * @throws Exception
     */
    public List<Object> excuteQuery(String sql, Object[] params) {
        // 执行SQL获得结果集  
        ResultSet rs = executeQueryRS(sql, params);

        // 创建ResultSetMetaData对象  
        ResultSetMetaData rsmd = null;

        // 结果集列数  
        int columnCount = 0;

        try {
            rsmd = rs.getMetaData();

            // 获得结果集列数  
            columnCount = rsmd.getColumnCount();
        } catch (SQLException e1) {
            System.out.println(e1.getMessage());
        }

        // 创建List  
        List<Object> list = new ArrayList<Object>();

        try {
        	 if(columnCount == 1){
        		// 将ResultSet的结果保存到List中  
 	            while (rs.next()) {	                
 	                list.add(rs.getObject(1));
 	            }
             }
        	 else {
	            // 将ResultSet的结果保存到List中  
	            while (rs.next()) {
	                Map<String, Object> map = new CaseInsensitiveMap<String, Object>();
	
	                for (int i = 1; i <= columnCount; i++) {
	                    map.put(rsmd.getColumnLabel(i), rs.getObject(i));
	                }
	
	                list.add(map);
	            }
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            // 关闭所有资源  
            closeAll();
        }

        return list;
    }

    /**
     * 获取单一对象
     *
     * @param sql
     *            SQL语句
     * @return Object
     *                       结果集
     * @throws Exception
     */
    public Object excuteQueryOne(String sql, Object[] params) {
        List<Object> list = excuteQuery(sql, params);

        if (list.size() == 1) {
            return list.get(0);
        } else {
            return null;
        }
    }

    /**
     * 存储过程带有一个输出参数的方法
     * @param sql 存储过程语句
     * @param params 参数数组
     * @param outParamPos 输出参数位置
     * @param SqlType 输出参数类型
     * @return 输出参数的值
     * @throws Exception
     */
    public Object excuteQuery(String sql, Object[] params, int outParamPos,
        int SqlType) {
        long startTime = System.currentTimeMillis();

        Object object = null;

        try {
            connnection = this.getConnection();

            // 调用存储过程  
            callableStatement = connnection.prepareCall(sql);

            // 给参数赋值  
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    callableStatement.setObject(i + 1, params[i]);
                }
            }

            // 注册输出参数  
            callableStatement.registerOutParameter(outParamPos, SqlType);

            // 执行  
            callableStatement.execute();

            // 得到输出参数  
            object = callableStatement.getObject(outParamPos);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        } finally {
            // 释放资源  
            closeAll();

            long endTime = System.currentTimeMillis();
            long sqlCost = endTime - startTime;
            System.out.println("SQL：[" + formatSql(sql, null, null) + "]执行耗时[" +
                sqlCost + "ms]");
        }

        return object;
    }

    /**
     * 关闭所有资源
     */
    private void closeAll() {
        // 关闭结果集对象  
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }
        }

        // 关闭PreparedStatement对象  
        if (preparedStatement != null) {
            try {
                preparedStatement.close();
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }
        }

        // 关闭CallableStatement 对象  
        if (callableStatement != null) {
            try {
                callableStatement.close();
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }
        }

        // 关闭Connection 对象  
        if (connnection != null) {
            try {
                connnection.close();
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }
        }
    }

    @SuppressWarnings("unchecked")
    public String formatSql(String sql, Object parameterObject,
        List<ParameterMapping> parameterMappingList) {
        // 输入sql字符串空判断
        if ((sql == null) || (sql.length() == 0)) {
            return "";
        }

        // 美化sql
        sql = beautifySql(sql);

        // 不传参数的场景，直接把Sql美化一下返回出去
        if ((parameterObject == null) || (parameterMappingList == null) ||
                (parameterMappingList.size() == 0)) {
            return sql;
        }

        // 定义一个没有替换过占位符的sql，用于出异常时返回
        String sqlWithoutReplacePlaceholder = sql;

        try {
            if (parameterMappingList != null) {
                Class<?> parameterObjectClass = parameterObject.getClass();

                // 如果参数是StrictMap且Value类型为Collection，获取key="list"的属性，这里主要是为了处理<foreach>循环时传入List这种参数的占位符替换
                // 例如select * from xxx where id in <foreach collection="list">...</foreach>
                if (isStrictMap(parameterObjectClass)) {
                    StrictMap<Collection<?>> strictMap = (StrictMap<Collection<?>>) parameterObject;

                    if (isList(strictMap.get("list").getClass())) {
                        sql = handleListParameter(sql, strictMap.get("list"));
                    }
                } else if (isMap(parameterObjectClass)) {
                    // 如果参数是Map则直接强转，通过map.get(key)方法获取真正的属性值
                    // 这里主要是为了处理<insert>、<delete>、<update>、<select>时传入parameterType为map的场景
                    Map<?, ?> paramMap = (Map<?, ?>) parameterObject;
                    sql = handleMapParameter(sql, paramMap, parameterMappingList);
                } else {
                    // 通用场景，比如传的是一个自定义的对象或者八种基本数据类型之一或者String
                    sql = handleCommonParameter(sql, parameterMappingList,
                            parameterObjectClass, parameterObject);
                }
            }
        } catch (Exception e) {
            // 占位符替换过程中出现异常，则返回没有替换过占位符但是格式美化过的sql，这样至少保证sql语句比BoundSql中的sql更好看
            return sqlWithoutReplacePlaceholder;
        }

        return sql;
    }

    /**
     * 美化Sql
     */
    private String beautifySql(String sql) {
        // sql = sql.replace("\n", "").replace("\t", "").replace("  ", " ").replace("( ", "(").replace(" )", ")").replace(" ,", ",");
        sql = sql.replaceAll("[\\s\n ]+", " ");

        return sql;
    }

    /**
     * 处理参数为List的场景
     */
    private String handleListParameter(String sql, Collection<?> col) {
        if ((col != null) && (col.size() != 0)) {
            for (Object obj : col) {
                String value = null;
                Class<?> objClass = obj.getClass();

                // 只处理基本数据类型、基本数据类型的包装类、String这三种
                // 如果是复合类型也是可以的，不过复杂点且这种场景较少，写代码的时候要判断一下要拿到的是复合类型中的哪个属性
                if (isPrimitiveOrPrimitiveWrapper(objClass)) {
                    value = obj.toString();
                } else if (objClass.isAssignableFrom(String.class)) {
                    value = "\"" + obj.toString() + "\"";
                }

                sql = sql.replaceFirst("\\?", value);
            }
        }

        return sql;
    }

    /**
     * 处理参数为Map的场景
     */
    private String handleMapParameter(String sql, Map<?, ?> paramMap,
        List<ParameterMapping> parameterMappingList) {
        for (ParameterMapping parameterMapping : parameterMappingList) {
            Object propertyName = parameterMapping.getProperty();
            Object propertyValue = paramMap.get(propertyName);

            if (propertyValue != null) {
                if (propertyValue.getClass().isAssignableFrom(String.class)) {
                    propertyValue = "\"" + propertyValue + "\"";
                }

                sql = sql.replaceFirst("\\?", propertyValue.toString());
            }
        }

        return sql;
    }

    /**
     * 处理通用的场景
     */
    private String handleCommonParameter(String sql,
        List<ParameterMapping> parameterMappingList,
        Class<?> parameterObjectClass, Object parameterObject)
        throws Exception {
        for (ParameterMapping parameterMapping : parameterMappingList) {
            String propertyValue = null;

            // 基本数据类型或者基本数据类型的包装类，直接toString即可获取其真正的参数值，其余直接取paramterMapping中的property属性即可
            if (isPrimitiveOrPrimitiveWrapper(parameterObjectClass)) {
                propertyValue = parameterObject.toString();
            } else {
                String propertyName = parameterMapping.getProperty();

                Field field = parameterObjectClass.getDeclaredField(propertyName);
                // 要获取Field中的属性值，这里必须将私有属性的accessible设置为true
                field.setAccessible(true);
                propertyValue = String.valueOf(field.get(parameterObject));

                if (parameterMapping.getJavaType().isAssignableFrom(String.class)) {
                    propertyValue = "\"" + propertyValue + "\"";
                }
            }

            sql = sql.replaceFirst("\\?", propertyValue);
        }

        return sql;
    }

    /**
     * 是否基本数据类型或者基本数据类型的包装类
     */
    private boolean isPrimitiveOrPrimitiveWrapper(Class<?> parameterObjectClass) {
        return parameterObjectClass.isPrimitive() ||
        (parameterObjectClass.isAssignableFrom(Byte.class) ||
        parameterObjectClass.isAssignableFrom(Short.class) ||
        parameterObjectClass.isAssignableFrom(Integer.class) ||
        parameterObjectClass.isAssignableFrom(Long.class) ||
        parameterObjectClass.isAssignableFrom(Double.class) ||
        parameterObjectClass.isAssignableFrom(Float.class) ||
        parameterObjectClass.isAssignableFrom(Character.class) ||
        parameterObjectClass.isAssignableFrom(Boolean.class));
    }

    /**
     * 是否DefaultSqlSession的内部类StrictMap
     */
    private boolean isStrictMap(Class<?> parameterObjectClass) {
        return parameterObjectClass.isAssignableFrom(StrictMap.class);
    }

    /**
     * 是否List的实现类
     */
    private boolean isList(Class<?> clazz) {
        Class<?>[] interfaceClasses = clazz.getInterfaces();

        for (Class<?> interfaceClass : interfaceClasses) {
            if (interfaceClass.isAssignableFrom(List.class)) {
                return true;
            }
        }

        return false;
    }

    /**
     * 是否Map的实现类
     */
    private boolean isMap(Class<?> parameterObjectClass) {
        Class<?>[] interfaceClasses = parameterObjectClass.getInterfaces();

        for (Class<?> interfaceClass : interfaceClasses) {
            if (interfaceClass.isAssignableFrom(Map.class)) {
                return true;
            }
        }

        return false;
    }
}
