Feature: Set up Headers

  @generateEmpData
  Scenario: Headers with no Authentication
    * def javaClassObject = Java.type('com.noorteck.qa.utils.DataGenerator')
    * print fileName
    * def result = new javaClassObject().gernerateEmployeeData(fileName, region,index)

  @updateEmpId
  Scenario: Headers with no Authentication
    * def javaClassObject = Java.type('com.noorteck.qa.utils.DataGenerator')
    * print fileName
    * def result = new javaClassObject().updateEmpID(fileName, region,index, empId)
    
     @updateDepId
  Scenario: Headers with no Authentication
    * def javaClassObject = Java.type('com.noorteck.qa.utils.DataGenerator')
    * print fileName
    * def result = new javaClassObject().updateDepID(fileName, region,index, depId)

    
    
    
  @generateJobData
  Scenario: Headers with no Authentication
    * def javaClassObject = Java.type('com.noorteck.qa.utils.DataGenerator')
    * print fileName
    * def result = new javaClassObject().gernerateJobData(fileName, region,index)
    
    @updateJobData
  Scenario: Headers with no Authentication
    * def javaClassObject = Java.type('com.noorteck.qa.utils.DataGenerator')
    * print fileName
    * def result = new javaClassObject().updateJobData(fileName, region,index) 
    
     @generateDepData
  Scenario: Headers with no Authentication
    * def javaClassObject = Java.type('com.noorteck.qa.utils.DataGenerator')
    * print fileName
    * def result = new javaClassObject().gernerateDepartmentData(fileName, region,index)
    