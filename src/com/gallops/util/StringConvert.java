package com.gallops.util;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import yn.ck.util.StringEX;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class StringConvert {
	
	public static String getUUIDString() {
		String uuid = new StringEX().getUUIDString().toString();
		return uuid;
	}
	
	public static String convertToJson(Object obj) {
		String result = "";
		if(obj instanceof List){
			JSONArray ja = JSONArray.fromObject(obj);
			result = ja.toString();
		} else {
			JSONObject jo = JSONObject.fromObject(obj);	
			result = jo.toString();
		}
		return result;
	}

}
