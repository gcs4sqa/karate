
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
    And match response.articles[*].favoritesCount contains 0
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

Scenario: conditional logic
    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    * def favoritesCount = response.articles[0].favoritesCount
    * def articleObject = response.articles[0]

    # * if (favoritesCount == 0 ) karate.call('classpath:helpers/AddLikes.feature', articleObject)

    * def result = favoritesCount == 0 ? karate.call('classpath:helpers/AddLikes.feature', articleObject).likesCount : favoritesCount

    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].favoritesCount == result


@ignore
Scenario: retry
    * configure retry = { count: 10, interval: 5000}

    Given params {limit: 10, offset: 0}
    Given path 'articles'
    And retry until response.articles[0].favoritesCount == 1
    When method Get
    Then status 200

@debug
Scenario: sleep call
   * def sleep = function(pause){ java.lang.Thread.sleep(pause) }
   
    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    * eval sleep(5000)
    Then status 200

Scenario: number to string
    * def foo = 10
    * def json = {"bar": #(foo+'')}
    * match json == {"bar": '10'}

Scenario: string to number
    * def foo = '10'
    * def json = {"bar": #(foo*1)}
    * def json2 = {"bar": #(~~parseInt(foo))}
    * match json == {"bar": 10}
    * match json2 == {"bar": 10}