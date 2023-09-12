@articles
Feature: article

Background: define url
    * url apiUrl
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def newArticleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
    * set newArticleRequestBody.article.title = dataGenerator.getRandomArticleValues().title
    * set newArticleRequestBody.article.description = dataGenerator.getRandomArticleValues().description
    * set newArticleRequestBody.article.body = dataGenerator.getRandomArticleValues().body
   
Scenario: Create a new article
    Given path 'articles'
    And request newArticleRequestBody
    When method Post
    Then status 201
    And match response.article.title == newArticleRequestBody.article.title
    * def slug = response.article.slug

    
    Given params {author: goldbuildkarate, limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title == newArticleRequestBody.article.title 


    Given path 'articles',slug
    When method delete
    Then status 204

    Given params {author: goldbuildkarate, limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title != newArticleRequestBody.article.title 

