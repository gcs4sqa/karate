@articles
Feature: article

Background: define url
    Given url "https://api.realworld.io/api"
    Given path 'users/login'
    And request {"user": {"email": "goldbuildkarate@karate.com","password": "karate"}}
    When method Post
    Then status 200
    * def token = response.user.token

Scenario: Create a new article
    Given header Authorization = 'Token '+ token
    Given path 'articles'
    And request {"article": {"taglist":[], "title": "world today", "description": "test test", "body": "body"}}
    When method Post
    Then status 201
    And match response.article.title == 'world today'
    * def slug = response.article.slug

    
    Given header Authorization = 'Token '+ token
    Given params {author: goldbuildkarate, limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title == 'world today' 


    Given header Authorization = 'Token '+ token
    Given path 'articles',slug
    When method delete
    Then status 204

    Given header Authorization = 'Token '+ token
    Given params {author: goldbuildkarate, limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title != 'world today' 

