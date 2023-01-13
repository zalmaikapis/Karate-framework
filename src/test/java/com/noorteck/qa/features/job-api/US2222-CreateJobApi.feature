@US2222
Feature: Create Job Functionality

  Background: 
    * def filePath = read(file_path)
    * def testDataFilePath = filePath.JobTestData
    * def hrServerData = read(hrApiServerData)
    * def baseURL = env == 'scrum' ? hrServerData.baseScrumURL : hrServerData.baseSitURL
    * def getHeaderInfo = env == 'scrum' ? filePath.Headers+'@scrum' : filePath.Headers+'@sit'
    * def setHeader = call read(getHeaderInfo)
    * configure headers = setHeader.HEADER

  #1.Creating new resource POST REQUEST
  Scenario Outline: Verify User able to Create new Job
    * def apiURI = hrServerData.Job.PostNewJob
    * def endpoint = baseURL+apiURI
    * def generateTestData = call read('file:' +filePath.GenerateTestData+'@generateJobData'){fileName:'#(testDataFilePath)', region: '<region>', index: '<index>'}
    * def data = read('file:' +filePath.JobTestData)
    * def request_body = read('file:' + filePath.JobPostRBody)
    * set request_body.jobId = data.<region>[<index>].jobId
    * set request_body.jobTitle = data.<region>[<index>].jobTitle
    * set request_body.minSalary = data.<region>[<index>].minSalary
    * set request_body.maxSalary = data.<region>[<index>].maxSalary
    * print request_body
    Given url endpoint
    And request request_body
    When method POST
    * print response
    Then status <status_code>
    And match response.message == <exp_messsage>
    
    
    
    @scrum
    Examples: 
      | region | index | status_code | exp_messsage           |
      | scrum  |     0 |         200 | 'Successfully created' |

    @sit
    Examples: 
      | region | index | status_code | exp_messsage           |
      | sit    |     0 |         200 | 'Successfully created' |
