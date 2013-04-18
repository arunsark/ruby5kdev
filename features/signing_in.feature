Feature: Signing in
  In order to use the system
  As a user
  I want to be able to sign in

  Scenario: Signing via confirmation
    Given there are the following users:
      | email             | password | unconfirmed | 
      | user@ruby5k.in    | password | true        |

    And "user@ruby5k.in" opens the email with subject "Confirmation instructions"
    And they click the first link in the email
    Then I should see "Your account was successfully confirmed"
    And I should see "Signed in as user@ruby5k.in"

  Scenario: Signing in via form
    Given there are the following users:
      | email             | password | unconfirmed | 
      | user@ruby5k.in    | password | false       |
    And I am on the homepage
    When I follow "Sign in"
    And I fill in "Email" with "user@ruby5k.in"
    And I fill in "Password" with "password"
    And I press "Sign in"
    Then I should see "Signed in successfully"
