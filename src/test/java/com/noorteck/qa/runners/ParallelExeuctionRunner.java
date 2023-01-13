package com.noorteck.qa.runners;

import org.junit.Test;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;

public class ParallelExeuctionRunner {

	@Test
	public void testParallel() {

		//Executes without tag
		Results results = Runner.path("classpath:com/noorteck/qa/features").parallel(1);
		
		//Execute with tag
	//	Results results = Runner.path("classpath:com/noorteck/qa/features").tags("regression").parallel(2);

		System.out.println("ERROR MESSAGE: " + results.getErrorMessages());
		System.out.println("FAIL COUNT: " + results.getFailCount());
		
	}

}

/**
NOTES:
	1. We are using JUnit 4. To perform parallel execution with Karate-JUnit4 we do not use @RunWith(Karate.class) annotation. 
	Instead we use normal JUnit 4 test class.
	
	2. We will have @Test tag and in the method body we will the 
			Runner.path() method which takes the path of our feature file package we want to execute
	
	3. Runner.Path() method can take single package, multiple packages or individual feature file path as parameter. 
	
	4. tags() method takes the tagName we want to execute
	
	5. parallel() method has to be the last method and we pass the number of parallel threads needed.  
	Parallel() method returns a Results object that has all the information we need like the number of PASSED/FAILED TestCases

*/
