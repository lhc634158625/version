package teamwish.common;

import com.alibaba.druid.pool.DruidDataSource;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Properties;

import org.apache.ibatis.io.Resources;


public class DruidManager {
    private static DruidManager single = null;
    private List<DruidDataSource> dataSources = new java.util.ArrayList<DruidDataSource>();    
    private final String resource = "config/database.properties";

    private DruidManager() {
    }

    public synchronized static DruidManager getInstance() throws IOException {
        if (single == null) {
            single = new DruidManager();
            single.initPool();
        }

        return single;
    }

    private void initPool() throws IOException {
    	Properties properties = new Properties();
        InputStream in = Resources.getResourceAsStream(resource);
        properties.load(in);
        try {
        	dataSources.clear();
        	
        	DruidDataSource dataSource = null;        	
        	dataSource = new DruidDataSource();
            dataSource.setName("master");
            dataSource.setDriverClassName(properties.getProperty("master.driver"));
            dataSource.setUsername(properties.getProperty("master.username"));
            dataSource.setPassword(properties.getProperty("master.password"));
            dataSource.setUrl(properties.getProperty("master.url"));
            
            dataSource.setInitialSize(1);
            dataSource.setMinIdle(1);
            dataSource.setMaxActive(500);
            
            dataSource.setRemoveAbandoned(true);
            dataSource.setRemoveAbandonedTimeout(180);
            dataSource.setMaxWait(3000);
            
            dataSource.setValidationQuery("select 1");
            
            dataSource.setTestWhileIdle(true);
            
            dataSources.add(dataSource);
            
            dataSource = new  DruidDataSource();
            dataSource.setName("salve");
            dataSource.setDriverClassName(properties.getProperty("salve.driver"));
            dataSource.setUsername(properties.getProperty("salve.username"));
            dataSource.setPassword(properties.getProperty("salve.password"));
            dataSource.setUrl(properties.getProperty("salve.url"));
            
            dataSource.setInitialSize(1);
            dataSource.setMinIdle(1);
            dataSource.setMaxActive(500);
            
            dataSource.setRemoveAbandoned(true);
            dataSource.setRemoveAbandonedTimeout(180);
            dataSource.setMaxWait(3000);
            
            dataSource.setValidationQuery("select 1");
            
            dataSource.setTestWhileIdle(true);
            
            dataSources.add(dataSource);
       			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    //要考虑多线程的情况     
    public Connection getConnection(int type) throws Exception {
        Connection connection = null;        
        try {
            synchronized (dataSources) {
            	int Index = 0;
            	if(type != 1) Index = 1;
                connection = dataSources.get(Index).getConnection();
            }
        } catch (SQLException e) {        	
            throw new Exception(e);
        }

        return connection;
    }
}
