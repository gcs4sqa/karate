
Feature: signup feature

Background:
    * def dataGenerator = Java.type('helpers.DataGenerator')
    Given url apiUrl
    * def randomEmail = dataGenerator.getRandomEmail();
    * def randomUsername = dataGenerator.getRandomUsername();



Scenario: signing up a new user 

    Given path 'users'
    And request 
    """
        {"user":
           {
            "email":#(randomEmail), 
            "password":"123karate", 
            "username":#(randomUsername)
            }
        }
    """
    When method Post 
    Then status 201   
    And match response ==
    """
        {
  "user": {
    "email": "#string",
    "username": "#string",
    "bio": "##string",
    "image": "#string",
    "token": "#string"
  }
}
    """

Scenario Outline: Validate signup error messages
  

    Given path 'users'
    And request 
    """
        {"user":
           {
            "email":"<email>", 
            "password":"<password>", 
            "username":"<username>"
            }
        }
    """
    When method Post 
    Then status 422
    And match response == <errorResponse>
    
    Examples:
    | email                      | password  | username          | errorResponse                                      |
    | #(randomEmail)             | karate123 | KarateUser123     | {"errors":{"username":["has already been taken"]}} |
    | goldbuildkarate@karate.com | karate123 | #(randomUsername) | {"errors": {"email": ["has already been taken"]}}  |