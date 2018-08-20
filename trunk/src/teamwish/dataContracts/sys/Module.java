package teamwish.dataContracts.sys;

import javax.xml.bind.annotation.XmlRootElement;
import java.sql.Date;
import java.sql.Timestamp;

@XmlRootElement
public class Module {
	private int id;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	private int pId;

	public int getPId() {
		return this.pId;
	}

	public void setPId(int pId) {
		this.pId = pId;
	}

	private String name;

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	private String url;

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	private String target;

	public String getTarget() {
		return this.target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	private String sortNo;

	public String getSortNo() {
		return this.sortNo;
	}

	public void setSortNo(String sortNo) {
		this.sortNo = sortNo;
	}

	private Boolean isMenu;

	public Boolean getIsMenu() {
		return this.isMenu;
	}

	public void setIsMenu(Boolean isMenu) {
		this.isMenu = isMenu;
	}

	private String type = "";

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	 private Boolean selected;
	 public Boolean getSelected(){
	  return this.selected;
	 }
	 
	 public void setSelected( Boolean selected){
	  this.selected = selected;
	 }
	 private Boolean open;
	 public Boolean getOpen(){
	  return this.open;
	 }
	 
	 public void setOpen( Boolean open){
	  this.open = open;
	 }

}
