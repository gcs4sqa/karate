@articles
Feature: article

Background: define url
    Given url apiUrl
   
Scenario: Create a new article
    Given path 'articles'
    And request {"article": {"taglist":[], "title": "world today", "description": "test test", "body": "body"}}
    When method Post
    Then status 201
    And match response.article.title == 'world today'
    * def slug = response.article.slug

    
    Given params {author: goldbuildkarate, limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title == 'world today' 


    Given path 'articles',slug
    When method delete
    Then status 204

    Given params {author: goldbuildkarate, limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title != 'world today' 

