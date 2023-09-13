@debug
Feature: Hooks

Background: hooks
    # * def result = callonce read('classpath:helpers/Dummy.feature')
    # * def username = result.username

    # afterhook
    #  * configure afterFeature = function(){ karate.call('classpath:helpers/Dummy.feature')}
     * configure afterFeature = 
     """
        function() 
        {
            karate.log('after feature')
            karate.call('classpath:helpers/Dummy.feature')    
        }
     """
     

    * configure afterScenario = function() {karate.log('after scenario')}


Scenario: first scenario
    # * print username
    * print 'this is the first scenario'

Scenario: second scenario
    # * print username
    * print 'this is the second scenario'
