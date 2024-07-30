package com.aischool.model;


public class FirstScreenVO {
	
	private String email;
	private String locationName;
	private String latitude;
	private String longitude;
	private String location;
	private String address;
	private String phone;
	private String img;
	private String tag;
	private String TravelList;
	private int DateIndex;
	private int ScheduleIndex;
	

	public FirstScreenVO() {
		
	}

	public FirstScreenVO(String locationName, String latitude, String longitude) {
		this.locationName = locationName;
		this.latitude= latitude;
		this.longitude= longitude;
	}
	
	public FirstScreenVO(String locationName, String latitude, String longitude, String img, String address,
			String tag) {
		this.locationName = locationName;
		this.latitude= latitude;
		this.longitude= longitude;
		this.img=img;
		this.address=address;
		this.tag=tag;
		
	}
	
	
	public FirstScreenVO(String TravelList, int DateIndex, int ScheduleIndex) {
		this.TravelList = TravelList;
		this.DateIndex= DateIndex;
		this.ScheduleIndex= ScheduleIndex;
	}

	
	public FirstScreenVO(String latitude, String longitude) {
		this.latitude= latitude;
		this.longitude= longitude;
	}

	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	public String getLocationName() {
		return locationName;
	}
	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}

	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}

	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public String getTravelList() {
		return TravelList;
	}
	public String setTravelList(String travelList) {
		return TravelList;
	}
	public int getDateIndex() {
		return DateIndex;
	}
	public int setDateIndex(int dateIndex) {
		return DateIndex;
	}
	public void setScheduleIndex(int scheduleIndex) {
		this.ScheduleIndex = scheduleIndex;
	}
	public int getScheduleIndex() {
		return ScheduleIndex;
	}



	
}

