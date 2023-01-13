@SmokeTest
Feature: HRAPI-Department Modulo SmokeTest Scenario

  Background: 
    * def filePath = read(file_path)
    * def testDataFilePath = filePath.DepTestData
    * def hrServerData = read(hrApiServerData)
    * def baseURL = env == 'scrum' ? hrServerData.baseScrumURL : hrServerData.baseSitURL
    * def getHeaderInfo = env == 'scrum' ? filePath.Headers+'@scrum' : filePath.Headers+'@sit'
    * def setHeader = call read(getHeaderInfo)
    * configure headers = setHeader.HEADER

  #1.Creating new resource POST REQUEST
  Scenario Outline: Verify User able to Create new Department
    * def apiURI = hrServerData.Department.PostNewDept
    * def endpoint = baseURL+apiURI
    * def generateTestData = call read("file:"+filePath.GenerateTestData+'@generateDepData'){fileName:'#(testDataFilePath)', region: '<region>', index: '<index>'}
    * def data = read('file:'+filePath.DepTestData)
    * def request_body = read('file:'+ filePath.DepPostRBody)
    * set request_body.departmentName = data.<region>[<index>].departmentName
    * set request_body.locationId = data.<region>[<index>].locationId
    * set request_body.departmentId = data.<region>[<index>].departmentId
    * set request_body.managerId = data.<region>[<index>].managerId
    * print request_body
    Given url endpoint
    And request request_body
    When method POST
    * print response
    * def depId = response.departmentId
    * def updateTestData = call read("file:"+filePath.GenerateTestData+'@updateDepId'){fileName:'#(testDataFilePath)', region: '<region>', index: '<index>', depId:'#(depId)' }
    * print depId

    @scrum
    Examples: 
      | region | index | status_code |
      | scrum  |     0 |         201 |

    @sit
    Examples: 
      | region | index | status_code |
      | sit    |     0 |         201 |

  #2.Retrieving the resource we create in scenario 1 with GET REQUEST
  Scenario Outline: Verify User able to retrieve the existing Department Information
    * def apiURI = hrServerData.Department.GetDeptById
    * def data = read("file:"+filePath.DepTestData)
    * def depId = data.<region>[<index>].departmentId
    * print depId
    * def endpoint = baseURL+apiURI + depId
    * print endpoint
    And url endpoint
    When method GET
    * print response
    * match responseStatus == <status_code>

    @scrum
    Examples: 
      | region | index | status_code |
      | scrum  |     0 |         200 |

    @sit
    Examples: 
      | region | index | status_code |
      | sit    |     0 |         200 |

  #
  #3.Updating the resource we create in scenario 1 with PUT REQUEST
  Scenario Outline: Verify User able to Update Department Information
    * def apiURI = hrServerData.Department.PutExistingDept
    * def endpoint = baseURL+apiURI
    * def generateTestData = call read('file:' + filePath.GenerateTestData+'@generateDepData'){fileName:'#(testDataFilePath)', region: '<region>', index: '<index>'}
    * def data = read('file:'+filePath.DepTestData)
    * def request_body = read('file:'+ filePath.DepPutRBody)
    * set request_body.departmentName = data.<region>[<index>].departmentName
    * set request_body.locationId = data.<region>[<index>].locationId
    * set request_body.managerId = data.<region>[<index>].managerId
    * set request_body.departmentId = data.<region>[<index>].departmentId
    Given url endpoint
    * print request_body
    And request request_body
    When method PUT
    * print response
     * match responseStatus == <status_code>

    @scrum
    Examples: 
      | region | index | status_code |
      | scrum  |     0 |         200 |

    @sit
    Examples: 
      | region | index | status_code |
      | sit    |     0 |         200 |

  #
  #4. Partially Updating the resource we create in scenario 1 with PATCH REQUEST
  Scenario Outline: Verify User able to update specific employee field
    * def apiURI = hrServerData.Department.PatchDeptByName
    * def endpoint = baseURL+apiURI
    * def generateTestData = call read('file:' + filePath.GenerateTestData+'@generateDepData'){fileName:'#(testDataFilePath)', region: '<region>', index: '<index>'}
    * def data = read('file:'+filePath.DepTestData)
    * def request_body = read('file:'+ filePath.DepPutRBody)
    * set request_body.departmentName = data.<region>[<index>].departmentName
    * set request_body.departmentId = data.<region>[<index>].departmentId
    Given url endpoint
    * print request_body
    And request request_body
    When method PATCH
    * print response
     * match responseStatus == <status_code>

    @scrum
    Examples: 
      | region | index | status_code |
      | scrum  |     0 |         200 |

    @sit
    Examples: 
      | region | index | status_code |
      | sit    |     0 |         200 |
#
  #5.Deleting the resource we create in scenario 1 with DELETE REQUEST
  Scenario Outline: Verify User able to delete existing Department
    * def apiURI = hrServerData.Department.DeleteDept
    * def data = read("file:"+filePath.DepTestData)
    * def PATH = data.<region>[<index>].departmentId
    * def endpoint = baseURL+apiURI + PATH
    Given url endpoint
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
#
