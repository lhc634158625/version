package teamwish.logic.base;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import teamwish.dataContracts.base.*;
import teamwish.dataContracts.common.*;

public class Buss {

	public Result<Integer> GetRecordCount(String tableName, Condition[] conditions) {
		DBHelp dbHelp = new DBHelp();

		return dbHelp.GetRecordCount(tableName, conditions);
	}

	/*********** 基本字典 ********************/
	public Result<BaseDict> GetBaseDictById(int id) {
		DBHelp dbHelp = new DBHelp();
		BaseDict BaseDict = (BaseDict) dbHelp.GetById(id, "BaseDict");
		return new Result<BaseDict>(BaseDict);
	}

	public Result<List<BaseDict>> GetBaseDictByFilter(PageFilter pf) {
		DBHelp dbHelp = new DBHelp();
		List<BaseDict> BaseDicts = (List<BaseDict>) dbHelp.GetByFilter(pf, "BaseDict");
		return new Result<List<BaseDict>>(BaseDicts);

	}

	public Result<BaseDict> SaveBaseDict(BaseDict baseDict) {
		DBHelp dbHelp = new DBHelp();
		if (baseDict.getId() == 0) {
			// initial something
		}
		baseDict = (BaseDict) dbHelp.Save(baseDict, "BaseDict", (baseDict.getId() == 0));
		dbHelp.Commit();
		return new Result<BaseDict>(baseDict);
	}

	public Result DeleteBaseDict(int id) {
		DBHelp dbHelp = new DBHelp();
		dbHelp.Delete(id, "BaseDict");
		dbHelp.Commit();
		return new Result();
	}
	/***********排班班别********************/
	public Result<ShiftType> GetShiftTypeById(int id) {
	  DBHelp dbHelp=new DBHelp();
	  ShiftType ShiftType= (ShiftType)dbHelp.GetById(id,"ShiftType");
	  return new Result<ShiftType>(ShiftType);  
	 }
	 public Result<List<ShiftType>> GetShiftTypeByFilter(PageFilter pf) {
	  DBHelp dbHelp=new DBHelp();
	  List<ShiftType> ShiftTypes= (List<ShiftType>)dbHelp.GetByFilter(pf,"ShiftType");
	  return new Result<List<ShiftType>>(ShiftTypes);
	  
	 }
	 public Result<ShiftType> SaveShiftType(ShiftType shiftType)  {
	  DBHelp dbHelp=new DBHelp();  
	  if(shiftType.getId()==0) {
	   //initial something
	  }
	  shiftType=(ShiftType)dbHelp.Save(shiftType,"ShiftType",(shiftType.getId()==0));
	  dbHelp.Commit();
	  return new Result<ShiftType>(shiftType);  
	 }
	 public Result DeleteShiftType(int id) {
	  DBHelp dbHelp=new DBHelp();  
	  dbHelp.Delete(id, "ShiftType");
	  dbHelp.Commit();
	  return new Result();  
	 }
	 
	 /***********附件********************/
	 public Result<Attachment> GetAttachmentById(int id) {
	   DBHelp dbHelp=new DBHelp();
	   Attachment Attachment= (Attachment)dbHelp.GetById(id,"Attachment");
	   return new Result<Attachment>(Attachment);  
	  }
	  public Result<List<Attachment>> GetAttachmentByFilter(PageFilter pf) {
	   DBHelp dbHelp=new DBHelp();
	   List<Attachment> Attachments= (List<Attachment>)dbHelp.GetByFilter(pf,"Attachment");
	   return new Result<List<Attachment>>(Attachments);
	   
	  }
	  public Result<Attachment> SaveAttachment(Attachment attachment)  {
	   DBHelp dbHelp=new DBHelp();  
	   if(attachment.getId()==0) {
	    //initial something
	   }
	   attachment=(Attachment)dbHelp.Save(attachment,"Attachment",(attachment.getId()==0));
	   dbHelp.Commit();
	   return new Result<Attachment>(attachment);  
	  }
	  public Result DeleteAttachment(int id) {
	   DBHelp dbHelp=new DBHelp();  
	   dbHelp.Delete(id, "Attachment");
	   dbHelp.Commit();
	   return new Result();  
	  }

}
