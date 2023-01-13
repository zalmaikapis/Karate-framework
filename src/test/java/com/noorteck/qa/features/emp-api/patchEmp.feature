@US111
Feature: udpate Employee Functionality 

  Background: 
    * def filePath = read(file_path)
    * def testDataFilePath = filePath.EmpTestData
    * def hrServerData = read(hrApiServerData)
    * def baseURL = env == 'scrum' ? hrServerData.baseScrumURL : hrServerData.baseSitURL
    * def getHeaderInfo = env == 'scrum' ? filePath.Headers+'@scrum' : filePath.Headers+'@sit'
    * def setHeader = call read(getHeaderInfo)
    * configure headers = setHeader.HEADER

	  #1.Creating new resource POST REQUEST   # data is your test data => fill => request-body is your empty template for the request body
	  Scenario Outline: Verify User able to update new Employee
	    * def apiURI = hrServerData.Employee.PatchExistingEmp
	    * def endpoint = baseURL+apiURI
	    * def generateTestData = call read('file:' + filePath.GenerateTestData+'@generateEmpData'){fileName:'#(testDataFilePath)', region: '<region>', index: '<index>'}
	    * def data = read('file:'+filePath.EmpTestData)
	    * def request_body = read('file:'+ filePath.EmpPatchRBody)
	    * set request_body.employeeId = data.<region>[<index>].employeeId
	    * set request_body.firstName = data.<region>[<index>].firstName
	    * set request_body.lastName = data.<region>[<index>].lastName
	    * set request_body.email = data.<region>[<index>].email
	    * set request_body.phoneNumber = data.<region>[<index>].phoneNumber
	    * set request_body.hireDate = data.<region>[<index>].hireDate
	    * set request_body.jobId = data.<region>[<index>].jobId
	    * set request_body.salary = data.<region>[<index>].salary
	    * set request_body.comissionPct = data.<region>[<index>].comissionPct
	    * set request_body.managerId = data.<region>[<index>].managerId
	    * set request_body.departmentId = data.<region>[<index>].departmentId
	    * print request_body
	    Given url endpoint
	    And request request_body
	    When method PATCH 
	    * print response
	    Then status <status_code>  
	    And match response.message == <exp_messsage>
	    * def updateTestData = call read('file:' + filePath.GenerateTestData+'@updateEmpId'){fileName:'#(testDataFilePath)', region: '<region>', index: '<index>', empId:'#(request_body.employeeId)' }


    @scrum
    Examples: 
      | region | index | status_code | exp_messsage       |
      | scrum  |    0 |         200 | 'Successfully updated' |

    @sit
    Examples: 
      | region | index | status_code | exp_messsage       |
      | sit    |     0 |         200 | 'Successfully updated' |

  #1.Creating new resource POST REQUEST
  #Scenario Outline: Verify Server Error Message for missing required fields
    #* def apiURI = hrServerData.Employee.PostNewEmp
    #* def endpoint = baseURL+apiURI
    #* def generateTestData = call read('file:'+filePath.GenerateTestData+'@generateEmpData'){fileName:'#(testDataFilePath)', region: '<region>', index: '<index>'}
    #* def data = read('file:'+filePath.EmpTestData)
    #* def request_body =  read('file:'+ filePath.EmpPostRBody)
    #* set request_body.firstName = data.<region>[<index>].firstName
    #* set request_body.lastName = data.<region>[<index>].lastName
    #* set request_body.email = data.<region>[<index>].email
    #* set request_body.phoneNumber = data.<region>[<index>].phoneNumber
    #* set request_body.hireDate = data.<region>[<index>].hireDate
    #* set request_body.jobId = data.<region>[<index>].jobId
    #* set request_body.salary = data.<region>[<index>].salary
    #* set request_body.comissionPct = data.<region>[<index>].comissionPct
    #* set request_body.managerId = data.<region>[<index>].managerId
    #* set request_body.departmentId = data.<region>[<index>].departmentId
    #* remove request_body.<field>
    #* print request_body
    #Given url endpoint
    #And request request_body
    #When method POST
    #* print response
    #Then status <status_code>
    #And match response.message == <exp_messsage>
    #And match response.errors[0].msg == <exp_error_msg>
    #And match response.errors[0].param == <exp_error_param>
#
    #@scrum
    #Examples: 
      #| region | index | status_code | field        | exp_messsage       | exp_error_msg   | exp_error_param |
      #| scrum  |     0 |         422 | firstName    | 'Validation error' | 'Invalid value' | 'firstName'     |
      #| scrum  |     0 |         422 | lastName     | 'Validation error' | 'Invalid value' | 'lastName'      |
      #| scrum  |     0 |         422 | jobId        | 'Validation error' | 'Invalid value' | 'jobId'         |
      #| scrum  |     0 |         422 | managerId    | 'Validation error' | 'Invalid value' | 'managerId'     |
      #| scrum  |     0 |         422 | phoneNumber  | 'Validation error' | 'Invalid value' | 'phoneNumber'   |
      #| scrum  |     0 |         422 | email        | 'Validation error' | 'Invalid value' | 'email'         |
      #| scrum  |     0 |         422 | comissionPct | 'Validation error' | 'Invalid value' | 'comissionPct'  |
#
    #@sit
    #Examples: 
      #| region | index | status_code | field        | exp_messsage       | exp_error_msg   | exp_error_param |
      #| sit    |     0 |         422 | firstName    | 'Validation error' | 'Invalid value' | 'firstName'     |
      #| sit    |     0 |         422 | lastName     | 'Validation error' | 'Invalid value' | 'lastName'      |
      #| sit    |     0 |         422 | jobId        | 'Validation error' | 'Invalid value' | 'jobId'         |
      #| sit    |     0 |         422 | managerId    | 'Validation error' | 'Invalid value' | 'managerId'     |
      #| sit    |     0 |         422 | phoneNumber  | 'Validation error' | 'Invalid value' | 'phoneNumber'   |
      #| sit    |     0 |         422 | email        | 'Validation error' | 'Invalid value' | 'email'         |
      #| sit    |     0 |         422 | comissionPct | 'Validation error' | 'Invalid value' | 'comissionPct'  |
#
  #1.Creating new resource POST REQUEST
  #Scenario Outline: Verify Server Error Message for invalid request body
    #* def apiURI = hrServerData.Employee.PostNewEmp
    #* def endpoint = baseURL+apiURI
    #* def request_body = <body>
    #Given url endpoint
    #And request request_body
    #When method POST
    #* print response
    #Then status <status_code>
    #And match response.message == <exp_messsage>
#
    #@scrum
    #Examples: 
      #| region | index | body | status_code | exp_messsage                   |
      #| scrum  |     0 | ''  |         400 | 'Unexpected end of JSON input' |
#
    #@sit
    #Examples: 
      #| region | index | body | status_code | exp_messsage                   |
      #| sit    |     0 | ' '  |         400 | 'Unexpected end of JSON input' |
