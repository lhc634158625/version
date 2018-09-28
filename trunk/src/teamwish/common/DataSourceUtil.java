package teamwish.common;

import java.io.InputStream;
import java.util.Properties;
import javax.sql.DataSource;

import org.apache.ibatis.io.Resources;

import com.alibaba.druid.pool.DruidDataSourceFactory;
 
public class DataSourceUtil {
	  /** 使用配置文件构建Druid数据源. */  
    public static final int DRUID_MSSQL_MASTER = 1;  
	  /** 使用配置文件构建Druid数据源. */  
    public static final int DRUID_MSSQL_SALVE = 2;  
    
    private final static String resource = "config/database.properties";
   
	
	public static final DataSource getDataSource(int sourceType) throws Exception {
		
		 DataSource dataSource = null;
		 
		 Properties properties = new Properties();
	     InputStream in = Resources.getResourceAsStream(resource);
	     properties.load(in);
		
		 Properties p =new Properties();		
		 p.put("initialSize", "1");
		 p.put("minIdle", "1");
		 p.put("maxActive", "500");
		 
		 p.put("removeAbandoned","true");
		 p.put("removeAbandonedTimeout","180");
		 p.put("maxWait", "3000");
		 
		 p.put("validationQuery", "SELECT 1");
		 
		 p.put("testWhileIdle", "true");
     
        switch (sourceType) {  
        case DRUID_MSSQL_MASTER:
          p.put("driverclassname", properties.getProperty("master.driver"));
          p.put("url", properties.getProperty("master.url"));
          p.put("username", properties.getProperty("master.username"));
          p.put("password", properties.getProperty("master.password"));
        	
          dataSource = DruidDataSourceFactory.createDataSource(p);  	
          break;  
        case DRUID_MSSQL_SALVE:  
           p.put("driverclassname", properties.getProperty("salve.driver"));
           p.put("url", properties.getProperty("salve.url"));
           p.put("username", properties.getProperty("salve.username"));
           p.put("password", properties.getProperty("salve.password"));
           	
          dataSource = DruidDataSourceFactory.createDataSource(p);  	  
          break;      
        }  
        return dataSource;  
    }  
	
 
}

