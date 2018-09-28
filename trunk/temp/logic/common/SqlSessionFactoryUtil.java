package teamwish.duty.logic.common;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

public class SqlSessionFactoryUtil {
	
	private static SqlSessionFactoryUtil single = null;
    private SqlSessionFactory sqlSessionFactory;
    private Configuration config;
    private Map<String,MappedStatement> mappedStatements = new HashMap<String,MappedStatement>();
        
	private final String resource = "config/mybatis.config.xml";

    private SqlSessionFactoryUtil() {
    	
    }

    public synchronized static SqlSessionFactoryUtil getInstance() {
        if (single == null) {
            single = new SqlSessionFactoryUtil();
            try {
				single.initPool();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }

        return single;
    }

    private void initPool() throws IOException {
    	
    	InputStream inputStream;

        try {
            inputStream = Resources.getResourceAsStream(resource);

            sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);            
            config = sqlSessionFactory.getConfiguration();
            loadMappersInfo();
            
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
    }

    //要考虑多线程的情况     
    public SqlSession openSession() {
    	SqlSession sqlSession = null;
    	
        try {
            synchronized (sqlSessionFactory) {
            	sqlSession = sqlSessionFactory.openSession();
            }
        } catch (Exception e) {
        	return null;
        }

        return sqlSession;
    }
    
    
    public Configuration getConfiguration() {
    	return config;
    }
    
    public Map<String, MappedStatement> getMappedStatements() {
		return mappedStatements;
	}
    
    private void loadMappersInfo() {
    	URL url = this.getClass().getClassLoader().getResource("config/sys/userInfo.xml");
    	File file = new File(url.getPath());
    	loadMapperInfo(file);
    }
    
    private void loadMapperInfo(File file) {
    	SAXReader reader = new SAXReader();
    	Document document = null;
    	try {
    		document = reader.read(file);
    	}catch(DocumentException e){
    		
    		e.printStackTrace();
    	}
    	
    	Element node = document.getRootElement();
    	
    	String namespace = node.attribute("namespace").getData().toString();
    	List<Element> selects = node.elements("select");
    	for(Element element : selects) {
    		MappedStatement mappedStatement = new MappedStatement();
    		String id = element.attribute("id").getData().toString();
    		String resultType = element.attribute("resultType").getData().toString();
    		String sql = element.getData().toString();
    		String sourceId = namespace + "." + id;
    		
    		mappedStatement.setNamespace(namespace);
    		mappedStatement.setResultType(resultType);
    		mappedStatement.setSourceId(sourceId);
    		mappedStatement.setSql(sql);
    		
    		mappedStatements.put(sourceId, mappedStatement);
    	}
    }
}