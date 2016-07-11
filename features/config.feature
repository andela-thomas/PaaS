Feature: Provision and Install
   Background:
    Given I have heroku toolbelt installed
    And I am logged in

  Scenario: Clone app
    When I Clone app
    Then It should be successful
    And app should exist in app folder

  Scenario: Create app on heroku
    When I Create app in heroku
    Then It should be successful
    And app should exist in heroku

  Scenario: Deploy app to heroku
    When I deploy app to heroku
    Then It should be successful

  Scenario: Scale app
    When I scale the app instances
    Then It should be successful

  Scenario: configure db addon
    When I configure db addon
    Then It should be successful
    And db should exisit in heroku

  Scenario: Open app in browser
    When I open app in browser
    Then It should be successful