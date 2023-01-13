package com.noorteck.qa.utils;

import java.io.FileWriter;
import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class JsonFileUtils {

	/**
	 * This method converts JSON file to String
	 * 
	 * @param fileName
	 * @return
	 */
	public static String jsonToStrConvertion(String fileName) {
		String str = null;
		try {
			byte[] encoded = Files
					.readAllBytes(Paths.get(fileName));
			str = new String(encoded, Charset.defaultCharset());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return str;
	}

	

	public static void modifyTestData(Map<String, Object> map,String fileName, String region, int index) throws JSONException, IOException {
		
		String jsonToString = JsonFileUtils.jsonToStrConvertion(fileName);
		
		JSONObject obj = new JSONObject(jsonToString);
		System.out.println(obj);
		JSONArray regionArr = obj.getJSONArray(region);
		JSONObject regionData = regionArr.getJSONObject(index);
		

		for (Map.Entry<String, Object> entry : map.entrySet()) {

			String key = entry.getKey();
			Object value = entry.getValue();
			regionData.put(key, value);
			System.out.println(key + ":" + value);
		}

		System.out.println(obj.toString());

		FileWriter file = new FileWriter(fileName, false);
		file.write(obj.toString());
		file.flush();

	}
	
	public static Map<String, Object> jsonToMap(String filePath, String region) {
		Map<String, Object> regionDataMap = new LinkedHashMap<String, Object>();
		
		String jsonToString = jsonToStrConvertion(filePath);
		try {
			// Convert to JSON object
			JSONObject obj = new JSONObject(jsonToString);
			JSONObject envMap = (JSONObject) obj.get(region);

			Iterator<String> keys = envMap.keys();
			// loop through json object and store in map
			while (keys.hasNext()) {
				String key = keys.next();

				// if key is null or empty then dont add value to map
				if (envMap.get(key) != null && !envMap.optString(key).equals("")) {
					regionDataMap.put(key, envMap.get(key));
				}
			}

			

		} catch (Exception e) {
			e.printStackTrace();
		}
		return regionDataMap;
		
	}

}
