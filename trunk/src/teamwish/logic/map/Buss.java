package teamwish.logic.map;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import sun.misc.BASE64Encoder;
import teamwish.dataContracts.common.*;
import teamwish.dataContracts.map.*;
import teamwish.logic.base.DBHelp;

public class Buss {
	public Result<PointInfo> GetPointInfoById(int id) {
		  DBHelp dbHelp=new DBHelp();
		  PointInfo PointInfo= (PointInfo)dbHelp.GetById(id,"PointInfo");
		  return new Result<PointInfo>(PointInfo);  
		 }
		 public Result<List<PointInfo>> GetPointInfoByFilter(PageFilter pf) {
		  DBHelp dbHelp=new DBHelp();
		  List<PointInfo> PointInfos= (List<PointInfo>)dbHelp.GetByFilter(pf,"PointInfo");
		  return new Result<List<PointInfo>>(PointInfos);
		  
		 }
		 public Result<PointInfo> SavePointInfo(PointInfo pointInfo)  {
		  DBHelp dbHelp=new DBHelp();  
		  if(pointInfo.getId()==0) {
		   //initial something
		  }
		  pointInfo=(PointInfo)dbHelp.Save(pointInfo,"PointInfo",(pointInfo.getId()==0));
		  dbHelp.Commit();
		  return new Result<PointInfo>(pointInfo);  
		 }
		 public Result DeletePointInfo(int id) {
		  DBHelp dbHelp=new DBHelp();  
		  dbHelp.Delete(id, "PointInfo");
		  dbHelp.Commit();
		  return new Result();  
		 }
     
}