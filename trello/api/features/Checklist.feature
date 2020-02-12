Feature: Checklist
  As a regular user, it wants to manage a checklist on a card.

  @Functional
  Scenario: Adds checkitem to checklist
    Given Sets a "POST" request to "/boards/"
      | key  | value            |
      | name | BoardToCheckItem |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Sets a "POST" request to "/lists"
      | key     | value            |
      | name    | ListToCheckItem  |
      | idBoard | (BoardObject.id) |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    And Sets a "POST" request to "/cards/"
      | key    | value           |
      | idList | (ListObject.id) |
      | name   | CardToCheckItem |
    And Sends request
    And Should return status code 200
    And Saves response as "CardObject"
    And Sets a "POST" request to "/checklists"
      | key    | value                |
      | idCard | (CardObject.id)      |
      | name   | CheckListToCheckItem |
      | pos    | top                  |
    And Sends request
    And Should return status code 200
    And Saves response as "CheckListAObject"
    When Sets a "POST" request to "/checklists/CheckListAObject.id/checkItems"
      | key     | value       |
      | name    | CheckItem01 |
      | pos     | top         |
      | checked | false       |
    And Sends request
    Then Should return status code 200
    And Saves response as "CheckItemaObject"
    And Validates response body with
      | key    | value       |
      | name   | CheckItem01 |
      | state  | incomplete  |
      | limits | {}          |
    And Validates schema with "check_item_schema.json"
    And Sets a "GET" request to "/checklists/CheckListAObject.id/checkItems"
      | key    | value |
      | filter | all   |
      | fields | all   |
    And Sends request
    And Should return status code 200
