package com.noorteck.qa.utils;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.LinkedHashMap;
import java.util.Map;

import org.json.JSONException;

import com.github.javafaker.Faker;

public class DataGenerator extends JsonFileUtils {

	public void updateEmpID(String apiName, String region, String indexStr, int id)
			throws JSONException, IOException {
		int index = Integer.parseInt(indexStr);

		Map<String, Object> map = new LinkedHashMap<String, Object>();
		map.put("employeeId", id);

		modifyTestData(map, apiName, region, index);

	}
	
	public void updateDepID(String apiName, String region, String indexStr, int id)
			throws JSONException, IOException {
		int index = Integer.parseInt(indexStr);

		Map<String, Object> map = new LinkedHashMap<String, Object>();
		map.put("departmentId", id);

		modifyTestData(map, apiName, region, index);

	}

	public void gernerateJobData(String apiName, String region, String indexStr) throws JSONException, IOException {
		int index = Integer.parseInt(indexStr);
		Faker fakeData = new Faker();
		Map<String, Object> map = new LinkedHashMap<String, Object>();

		String jobID = fakeData.company().industry();
		
		jobID = jobID.replaceAll(" ", "");
		String professions[] = {"Music", "java developer", "java developer", "tutor"};
		
		//TODO check with the database and see if the jobID we have is already in DB
		
		// if it does then go back and regeneate and re check until it is unique
		
		if(jobID.length() > 7) {
			jobID= jobID.substring(0,7);
		}
		
		int i = (int) ((int)1 + Math.random()* 999);
		jobID = jobID + i;
		System.out.println(jobID);
		
		String jobTitle = fakeData.company().industry();

		double minSalary = fakeData.number().numberBetween(1000, 99999);
		double maxSalary = fakeData.number().numberBetween(1000, 99999);

		if (maxSalary < minSalary) {
			double temp = maxSalary;
			maxSalary = minSalary;
			minSalary = temp;
		}
		
		map.put("jobId", jobID);
		map.put("jobTitle", jobTitle);
		map.put("minSalary", minSalary);
		map.put("maxSalary", maxSalary);

		modifyTestData(map, apiName, region, index);


		System.out.println(jobID);
		System.out.println(jobTitle);
		System.out.println(minSalary);
		System.out.println(maxSalary);
	}
	
	public void updateJobData(String apiName, String region, String indexStr) throws JSONException, IOException {
		int index = Integer.parseInt(indexStr);
		Faker fakeData = new Faker();
		Map<String, Object> map = new LinkedHashMap<String, Object>();

		
		
		//TODO check with the database and see if the jobID we have is already in DB
		
		// if it does then go back and regeneate and re check until it is unique
		
		String jobTitle = fakeData.company().industry();

		double minSalary = fakeData.number().numberBetween(1000, 99999);
		double maxSalary = fakeData.number().numberBetween(1000, 99999);

		if (maxSalary < minSalary) {
			double temp = maxSalary;
			maxSalary = minSalary;
			minSalary = temp;
		}
		
		map.put("jobTitle", jobTitle);
		map.put("minSalary", minSalary);
		map.put("maxSalary", maxSalary);

		modifyTestData(map, apiName, region, index);
		
		System.out.println(jobTitle);
		System.out.println(minSalary);
		System.out.println(maxSalary);
	}


	public void gernerateEmployeeData(String apiName, String region, String indexStr)
			throws JSONException, IOException, SQLException {
		int index = Integer.parseInt(indexStr);
		
		// pick employeeId, managerId, departmentId and jobId from database and assign one of them randomly to the request body.
		Constants.setQuery(region);
		Map<String, String> emp = DBUtils.makeDBRequest(Constants.query, region).get(0);
		// get required fields from result set.
		String jobId = emp.get("job_id");
		int managerId = Integer.parseInt(emp.get("manager_id"));
		int depId = Integer.parseInt(emp.get("department_id"));
		int empId = Integer.parseInt(emp.get("employee_id"));
		
		
	

		Faker fakeData = new Faker();
		Map<String, Object> map = new LinkedHashMap<String, Object>();

		String firstName = fakeData.name().firstName();
		String lastName = fakeData.name().lastName();

		String email = firstName + "@test.com";
		String phone = fakeData.phoneNumber().cellPhone();

		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
		String hireDate = sdf.format(fakeData.date().birthday());

		double minSalary = 10000;
		double maxSalary = 200000;

		double salary = minSalary + (maxSalary - minSalary) * fakeData.random().nextDouble();

		salary = Double.parseDouble(String.format("%.2f", salary));
		double minCommission = 0.0;
		double maxCommission = 0.8;
		double commission = minCommission + (maxCommission - minCommission) * fakeData.random().nextDouble();

		commission = Double.parseDouble(String.format("%.2f", commission));
		
		map.put("firstName", firstName);
		map.put("lastName", lastName);
		map.put("email", email);
		map.put("phoneNumber", phone);
		map.put("salary", salary);
		map.put("comissionPct", commission);
		// we get values for these from DB selecting random employee.
		map.put("employeeId",empId);
		map.put("departmentId", depId);
		map.put("managerId", managerId);
		map.put("jobId", jobId);
		

		System.out.println("FirstName: " + firstName);
		System.out.println("LastName: " + lastName);
		System.out.println("Email: " + email);
		System.out.println("Phone: " + phone);
		System.out.println("Date: " + hireDate);
		System.out.println("Salary: " + salary);
		System.out.println("Commission: " + commission);
		System.out.println("dep id: " + depId);
		System.out.println("comm pct: " + managerId);
		System.out.println("job id: " + jobId);

		modifyTestData(map, apiName, region, index);

	}
	
	
	public void gernerateDepartmentData(String apiName, String region, String indexStr)
			throws JSONException, IOException, SQLException {
		int index = Integer.parseInt(indexStr);
		

		Constants.setQuery(region);
		Map<String, String> dep = DBUtils.makeDBRequest(Constants.depQuery, region).get(0);
		// get required fields from result set.	
		int managerId = Integer.parseInt(dep.get("manager_id"));
		int depId = Integer.parseInt(dep.get("department_id"));
		int locationId = Integer.parseInt(dep.get("location_id"));
		
		
	

		Faker fakeData = new Faker();
		Map<String, Object> map = new LinkedHashMap<String, Object>();



		
		String depName = fakeData.company().name();
		int limit = depName.length() > 20 ? 20 : depName.length();
		map.put("departmentName", depName.substring(0, limit));
		// we get values for these from DB selecting random employee.
		map.put("departmentId",depId);
		map.put("managerId", managerId);
		map.put("locationId", locationId);
		

		modifyTestData(map, apiName, region, index);

	}

}
