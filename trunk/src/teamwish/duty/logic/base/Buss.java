package teamwish.duty.logic.base;

import teamwish.duty.dataContracts.common.*;
import teamwish.duty.dataContracts.duty.*;

import teamwish.duty.logic.common.CommonBuss;
import teamwish.duty.logic.common.DBHelp;

import java.util.List;


public class Buss extends CommonBuss {

	public Buss(String tableName) {
		this.tableName = tableName;
	}
	
	
}
