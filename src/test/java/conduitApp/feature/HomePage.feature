Feature: test for the home page

Background: define url
    Given url apiUrl

@debug
Scenario: get all tags
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains ['et', 'welcome']
    And match response.tags == '#array'
    And match each response.tags == '#string'

@smoke
Scenario: get 10 articals from the page
    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles == '#[10]'
    And match response.articlesCount == 197