@debug
Feature: test for the home page

Background: define url
    Given url apiUrl

Scenario: get all tags
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains ['et', 'welcome']
    And match response.tags contains any ['dog', 'cat','et']
    And match response.tags == '#array'
    And match each response.tags == '#string'

@smoke
Scenario: get 10 articals from the page
    * def timeValidator = read('classpath:helpers/TimeValidator.js')

    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles == '#[10]'
    And match response.articlesCount == 200
    And match response.articlesCount != 201
    And match response == {"articles":"#array", "articlesCount":200}
    And match response.articles[0].createdAt contains '2023'
    And match response.articles[*].favoritesCount contains 495
    And match response.articles[*].author.bio contains null
    And match response..bio contains null
    And match each response..following == false
    And match each response..following == '#boolean'
    And match each response..favoritesCount == '#number'
    And match each response..bio == '##string'
    And match each response.articles ==
    """
        {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": "#array",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "favorited": "#boolean",
            "favoritesCount": "#number",
            "author": {
                "username": "#string",
                "bio": "##string",
                "image": "#string",
                "following": "#boolean"
            }
        }
    """