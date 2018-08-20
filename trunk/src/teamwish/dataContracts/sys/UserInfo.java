package teamwish.dataContracts.sys;

import javax.xml.bind.annotation.XmlRootElement;
import java.sql.Date;
import java.sql.Timestamp;

@XmlRootElement
public class UserInfo {
	private int id;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	private String nickName;

	public String getNickName() {
		return this.nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	private int stationId;

	public int getStationId() {
		return this.stationId;
	}

	public void setStationId(int stationId) {
		this.stationId = stationId;
	}

	private String password;

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	private double longitude;

	public double getLongitude() {
		return this.longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	private double latitude;

	public double getLatitude() {
		return this.latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	private int roleId;

	public int getRoleId() {
		return this.roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	private String state;

	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	private Timestamp created;

	public Timestamp getCreated() {
		return this.created;
	}

	public void setCreated(Timestamp created) {
		this.created = created;
	}

	private int zoom;

	public int getZoom() {
		return this.zoom;
	}

	public void setZoom(int zoom) {
		this.zoom = zoom;
	}

	private String name;

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	private String stationName;

	public String getStationName() {
		return this.stationName;
	}

	public void setStationName(String stationName) {
		this.stationName = stationName;
	}

	private String token;

	public String getToken() {
		return this.token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	private Timestamp tokenTime;

	public Timestamp getTokenTime() {
		return this.tokenTime;
	}

	public void setTokenTime(Timestamp tokenTime) {
		this.tokenTime = tokenTime;
	}

	private Timestamp loginDt;

	public Timestamp getLoginDt() {
		return this.loginDt;
	}

	public void setLoginDt(Timestamp loginDt) {
		this.loginDt = loginDt;
	}

	private int[] moduleIds;

	public int[] getModuleIds() {
		return this.moduleIds;
	}

	public void setModuleIds(int[] moduleIds) {
		this.moduleIds = moduleIds;
	}

}
