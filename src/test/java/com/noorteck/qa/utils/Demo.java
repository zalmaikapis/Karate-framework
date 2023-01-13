package com.noorteck.qa.utils;

import java.io.IOException;
import java.sql.SQLException;

import org.json.JSONException;

public class Demo {
	
	public static void main(String[] args) throws JSONException, IOException, SQLException {
		DataGenerator obj = new DataGenerator();
		
		obj.gernerateJobData("./src/test/java/com/noorteck/qa/data/job-api/JobTestData.json", "scrum", "0");
	}

}
