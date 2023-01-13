@SmokeTest
Feature: HRAPI-Employeee Modulo SmokeTest Scenario

  Background: 
    * def filePath = read(file_path)
    * def testDataFilePath = filePath.EmpTestData
    * def hrServerData = read(hrApiServerData)
    * def baseURL = env == 'scrum' ? hrServerData.baseScrumURL : hrServerData.baseSitURL
    * def getHeaderInfo = env == 'scrum' ? filePath.Headers+'@scrum' : filePath.Headers+'@sit'
    * def setHeader = call read(getHeaderInfo)
    * configure headers = setHeader.HEADER

  #1.Creating new resource POST REQUEST
  Scenario Outline: Verify User able to Create new Employee
    * def apiURI = hrServerData.Employee.PostNewEmp
    * def endpoint = baseURL+apiURI
    * def generateTestData = call read("file:"+filePath.GenerateTestData+'@generateEmpData'){fileName:'#(testDataFilePath)', region: '<region>', index: '<index>'}
    * def data = read('file:'+filePath.EmpTestData)
    * def request_body = read('file:'+ filePath.EmpPostRBody)
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
    When method POST
    * print response
    * def empId = response.id
    * def updateTestData = call read("file:"+filePath.GenerateTestData+'@updateEmpId'){fileName:'#(testDataFilePath)', region: '<region>', index: '<index>', empId:'#(empId)' }
    * print empId

    @scrum
    Examples: 
      | region | index |
      | scrum  |     0 |

    @sit
    Examples: 
      | region | index |
      | sit    |     0 |

  #2.Retrieving the resource we create in scenario 1 with GET REQUEST
  Scenario Outline: Verify User able to retrieve the existing Employee Information
    * def apiURI = hrServerData.Employee.GetEmpById
    * def endpoint = baseURL+apiURI
    * def data = read("file:"+filePath.EmpTestData)
    * def empId = data.<region>[<index>].employeeId
    Given params {id:'#(empId)'}
    And url endpoint
    When method GET
    * print response

    @scrum
    Examples: 
      | region | index |
      | scrum  |     0 |

    @sit
    Examples: 
      | region | index |
      | sit    |     0 |

  #3.Updating the resource we create in scenario 1 with PUT REQUEST
  Scenario Outline: Verify User able to Update Employee Information
    * def apiURI = hrServerData.Employee.PutExistingEmp
    * def endpoint = baseURL+apiURI
    * def generateTestData = call read('file:' + filePath.GenerateTestData+'@generateEmpData'){fileName:'#(testDataFilePath)', region: '<region>', index: '<index>'}
    * def data = read('file:'+filePath.EmpTestData)
   * def request_body = read('file:'+ filePath.EmpPutRBody)
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
    Given url endpoint
    * print request_body
    And request request_body
    When method PUT
    * print response

    @scrum
    Examples: 
      | region | index |
      | scrum  |     0 |

    @sit
    Examples: 
      | region | index |
      | sit    |     0 |

  #4. Partially Updating the resource we create in scenario 1 with PATCH REQUEST
  Scenario Outline: Verify User able to update specific employee field
    * def apiURI = hrServerData.Employee.PatchExistingEmp
    * def endpoint = baseURL+apiURI
    * def generateTestData = call read("file:"+filePath.GenerateTestData+'@generateEmpData'){fileName:'#(testDataFilePath)', region: '<region>', index: '<index>'}
    * def data = read("file:"+filePath.EmpTestData)
    * def request_body = read("file:"+ filePath.EmpPatchRBody)
    * set request_body.employeeId = data.<region>[<index>].employeeId
    * set request_body.firstName = data.<region>[<index>].firstName
    * set request_body.lastName = data.<region>[<index>].lastName
    * set request_body.phoneNumber = data.<region>[<index>].phoneNumber
    Given url endpoint
    * print request_body
    And request request_body
    When method PATCH
    * print response

    @scrum
    Examples: 
      | region | index |
      | scrum  |     0 |

    @sit
    Examples: 
      | region | index |
      | sit    |     0 |

  #5.Deleting the resource we create in scenario 1 with DELETE REQUEST
  Scenario Outline: Verify User able to delete existing employee
    * def apiURI = hrServerData.Employee.DeleteEmp
    * def endpoint = baseURL+apiURI
    * def data = read("file:"+filePath.EmpTestData)
    * def PATH = data.<region>[<index>].employeeId
    Given url endpoint
    And path PATH
    When method DELETE
    * print response

    @scrum
    Examples: 
      | region | index |
      | scrum  |     0 |

    @sit
    Examples: 
      | region | index |
      | sit    |     0 |
