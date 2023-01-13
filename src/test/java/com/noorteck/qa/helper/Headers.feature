Feature: Set up Headers

  #scrum
  @scrum
  Scenario: Headers with no Authentication
    * def HEADER = {Content-Type: 'application/json', Accept: 'application/json'}

  #sit
  @sit
  Scenario: Headers with Valid Authentication
    * def filePath = read(file_path)
    * def getTokenData = call read(filePath.GenerateAuthToken+'@token')
    * def setToken = getTokenData.token
    * print setToken
    * def HEADER = {Content-Type: 'application/json', Accept: 'application/json', Authorization: '#(setToken)'}
