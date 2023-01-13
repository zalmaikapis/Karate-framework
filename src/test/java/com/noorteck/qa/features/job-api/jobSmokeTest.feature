@jobSmokeTest
Feature: HRAPI-Department Modulo SmokeTest Scenario

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
    * def generateTestData = call read("file:"+filePath.GenerateTestData+'@generateJobData'){fileName:'#(testDataFilePath)', region: '<region>', index: '<index>'}
    * def data = read('file:'+filePath.JobTestData)
    * def request_body = read('file:'+ filePath.JobPostRBody)
    * set request_body.jobId = data.<region>[<index>].jobId
    * set request_body.jobTitle = data.<region>[<index>].jobTitle
    * set request_body.minSalary = data.<region>[<index>].minSalary
    * set request_body.maxSalary = data.<region>[<index>].maxSalary
    * print request_body
    Given url endpoint
    And request request_body
    When method POST
    * print response
    And match responseStatus == <status_code>

    @scrum
    Examples: 
      | region | index | status_code |
      | scrum  |     0 |         200 |

    @sit
    Examples: 
      | region | index | status_code |
      | sit    |     0 |         200 |

  #2.Retrieving the resource we create in scenario 1 with GET REQUEST
  Scenario Outline: Verify User able to retrieve the existing Job Information
    * def apiURI = hrServerData.Job.getJobById
    * def data = read("file:"+filePath.JobTestData)
    * def jobId = data.<region>[<index>].jobId
    * params {id: '#(jobId)'}
    * def endpoint = baseURL+apiURI
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
  #
  #3.Updating the resource we create in scenario 1 with PUT REQUEST
  Scenario Outline: Verify User able to Update Job Information
    * def apiURI = hrServerData.Job.updateExistingJob
    * def endpoint = baseURL+apiURI
    * def generateTestData = call read('file:' + filePath.GenerateTestData+'@updateJobData'){fileName:'#(testDataFilePath)', region: '<region>', index: '<index>'}
    * def data = read('file:'+filePath.JobTestData)
    * def request_body = read('file:'+ filePath.JobPostRBody)
    * set request_body.jobId = data.<region>[<index>].jobId
    * set request_body.jobTitle = data.<region>[<index>].jobTitle
    * set request_body.minSalary = data.<region>[<index>].minSalary
    * set request_body.maxSalary = data.<region>[<index>].maxSalary
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
  #
  #4. Partially Updating the resource we create in scenario 1 with PATCH REQUEST
  Scenario Outline: Verify User able to update specific Job field
    * def apiURI = hrServerData.Job.patchJobByTitle
    * def endpoint = baseURL+apiURI
    * def generateTestData = call read('file:' + filePath.GenerateTestData+'@updateJobData'){fileName:'#(testDataFilePath)', region: '<region>', index: '<index>'}
    * def data = read('file:'+filePath.JobTestData)
    * def request_body = read('file:'+ filePath.JobPatchRBody)
    * set request_body.jobId = data.<region>[<index>].jobId
    * set request_body.jobTitle = data.<region>[<index>].jobTitle
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
  Scenario Outline: Verify User able to delete existing Job
    * def apiURI = hrServerData.Job.deleteJob
    * def data = read("file:"+filePath.JobTestData)
    * def PATH = data.<region>[<index>].jobId
    * def endpoint = baseURL+apiURI + PATH
    Given url endpoint
    When method DELETE
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
