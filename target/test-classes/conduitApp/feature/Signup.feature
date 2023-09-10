@ignore
Feature: signup feature

Background:
    Given url apiUrl


Scenario: signing up a new user
    Given def userData = {"email":"goldbuildKarate125@test.com", "username":"goldbuildKarate125"} 

    Given path 'users'
    And request 
    """
        {"user":
           {
            "email":#(userData.email), 
            "password":"123karate", 
            "username":#(userData.username)
            }
        }
    """
    When method Post 
    Then status 201   