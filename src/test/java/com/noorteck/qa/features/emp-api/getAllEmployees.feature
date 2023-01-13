@getEmployees
Feature: Create Employee Functionality

  Background: 
    * def filePath = read(file_path)
    * def testDataFilePath = filePath.EmpTestData
    * def hrServerData = read(hrApiServerData)
    * def baseURL = env == 'scrum' ? hrServerData.baseScrumURL : hrServerData.baseSitURL
    * def getHeaderInfo = env == 'scrum' ? filePath.Headers+'@scrum' : filePath.Headers+'@sit'
    * def setHeader = call read(getHeaderInfo)
    * configure headers = setHeader.HEADER

  #1.Creating new resource POST REQUEST   # data is your test data => fill => request-body is your empty template for the request body
  Scenario Outline: Verify User able to get all employees.
    * def apiURI = hrServerData.Employee.GetAllEmp
    * def endpoint = baseURL+apiURI
    Given url endpoint
    When method GET
    * print response
    Then status <status_code>
    And assert responseTime < 2000

    @scrum
    Examples: 
      | region | status_code |
      | scrum  |         200 |

    @sit
    Examples: 
      | region | status_code |
      | sit    |         200 |
