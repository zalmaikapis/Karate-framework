Feature: Generate Authentication token for Sit Environment

  #sit
  @token
  Scenario: Generate Bearer Token
    * def hrServerData = read(hrApiServerData)
    * def baseURL =  hrServerData.baseSitURL
    * def apiURI = hrServerData.authSignIn
    * def endpoint = baseURL+apiURI
    * def request_body =
      """
      {
      "username": '#(username)',
      "password": '#(password)'
      }
      """
    Given headers {Accept: 'application/json'}
    And url endpoint
    And request request_body
    When method POST
    * print response
    * def token = 'Bearer ' + response.token
