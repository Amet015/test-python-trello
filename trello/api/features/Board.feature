Feature: Board
  As a regular user, it wants to manage a board, and creates a board.

   @Smoke
  Scenario: Creates new board with a name
    When Sets a "POST" request to "/boards/"
      | key  | value    |
      | name | newBoard |
    And Sends request
    Then Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Validates response body with
      | key                   | value    |
      | name                  | newBoard |
      | desc                  |          |
      | closed                | False    |
      | prefs.permissionLevel | private  |
    And Validates schema with "board_schema.json"
    And Sets a "GET" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200


  @Smoke
  Scenario: Deletes a board by Id
    Given Sets a "POST" request to "/boards/"
      | key  | value    |
      | name | newBoard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    When Sets a "DELETE" request to "/boards/BoardObject.id"
    And Sends request
    Then Should return status code 200
    And Validates response body with
      | key    | value |
      | _value | None  |
    And Validates schema with "delete_board_schema.json"
    And Sets a "GET" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 404


  @Acceptance
  Scenario: Changes the name of the board
    Given Sets a "POST" request to "/boards/"
      | key  | value        |
      | name | GherkinBoard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    When Sets a "PUT" request to "/boards/BoardObject.id"
      | key  | value           |
      | name | UpdateBoardName |
    And Sends request
    Then Should return status code 200
    And Validates response body with
      | key  | value           |
      | name | UpdateBoardName |
    And Validates schema with "board_schema.json"
    And Sets a "GET" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200


  @Acceptance
  Scenario: Updates members in a Board
    Given Sets a "POST" request to "/boards/"
      | key  | value     |
      | name | boardTest |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    When Sets a "PUT" request to "/boards/BoardObject.id/members"
      | key   | value   |
      | email | (email) |
    And Sends request
    Then Should return status code 200
    And Validates response body with
      | key                     | value |
      | members.activityBlocked | None  |
      | memberships.memberType  | None  |
      | memberships.nonPublic   | None  |
    And Validates schema with "put_boards_members.json"
    And Sets a "GET" request to "/boards/BoardObject.id/members"
    And Sends request
    And Should return status code 200


  @defect
  Scenario: Board marked as a viewed
    Given Sets a "POST" request to "/boards/"
      | key  | value        |
      | name | GherkinBoard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    When Sets a "POST" request to "/boards/BoardObject.id/markedAsViewed"
    And Sends request
    Then Should return status code 200
    And Validates schema with "board_schema.json"


  @Acceptance
  Scenario: Add label to existent Board
    Given Sets a "POST" request to "/boards/"
      | key  | value      |
      | name | BoardLabel |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    When Sets a "POST" request to "/boards/BoardObject.id/labels"
      | key   | value       |
      | name  | nameOfLabel |
      | color | yellow      |
    And Sends request
    Then Should return status code 200
    And Saves response as "LabelObject"
    And Validates response body with
      | key   | value       |
      | name  | nameOfLabel |
      | color | yellow      |
    And Validates schema with "label_schema.json"
    And Sets a "GET" request to "/labels/LabelObject.id"
    And Sends request
    And Should return status code 200


  @Acceptance
  Scenario: Add powerUps to existent Board
    Given Sets a "POST" request to "/boards/"
      | key  | value             |
      | name | postBoardPowerUps |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    When Sets a "POST" request to "/boards/BoardObject.id/powerUps"
      | key   | value    |
      | value | calendar |
    And Sends request
    Then Should return status code 410
    And Validates response body with
      | key     | value |
      | message | Gone  |
    And Validates schema with "powerups_schema.json"


  @Functional
  Scenario: Creates a label in board
    Given Sets a "POST" request to "/boards/"
      | key  | value    |
      | name | newBoard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    When Sets a "POST" request to "/labels"
      | key     | value            |
      | name    | newLabel         |
      | color   | green            |
      | idBoard | (BoardObject.id) |
    And Sends request
    Then Should return status code 200
    And Saves response as "LabelObject"
    And Validates response body with
      | key  | value    |
      | name | newLabel |
    And Validates schema with "label_schema.json"
    And Sets a "GET" request to "/labels/LabelObject.id"
    And Sends request
    And Should return status code 200


  @Functional
  Scenario: Creates a list in board
  This scenario allows to create a list on an existing board
    Given Sets a "POST" request to "/boards/"
      | key  | value    |
      | name | newBoard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    When Sets a "POST" request to "/lists"
      | key     | value            |
      | name    | newList          |
      | idBoard | (BoardObject.id) |
    And Sends request
    Then Should return status code 200
    And Saves response as "ListObject"
    And Validates schema with "list_schema.json"
    And Sets a "GET" request to "/lists/ListObject.id"
    And Sends request
    And Should return status code 200
    And Validates response body with
      | key  | value   |
      | name | newList |


  @Acceptance
  Scenario: Creates a new Board with description
    When Sets a "POST" request to "/boards/"
      | key  | value          |
      | name | newBoard       |
      | desc | newDescription |
    And Sends request
    Then Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Validates response body with
      | key                   | value          |
      | name                  | newBoard       |
      | desc                  | newDescription |
      | closed                | False          |
      | prefs.permissionLevel | private        |
    And Validates schema with "board_schema.json"
    And Sets a "GET" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200


  @Negative
  Scenario: Board can't be got by invalid Id
    When  Sets a "GET" request to "/boards/idBoardNotValid"
    And Sends request
    Then Should return status code 400
    And Validates response message with message "invalid id"


  @defect
  Scenario Outline: Board can't be created with spaces or empty as name
    When Sets a "POST" request to "/boards/"
      | key  | value  |
      | name | <name> |
      | desc | <desc> |
    And Sends request
    Then Should return status code <status_code>
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Sets a "DELETE" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code <status_code>
    Examples:
      | name           | desc                | status_code |
      | (empty)        | This is description | 400         |
      | (blank_spaces) | This is description | 200         |


  @Negative
  Scenario: It can not Update members with an invalid Id
    When Sets a "PUT" request to "/boards/BoardObject.id/members"
      | key   | value   |
      | email | (email) |
    And Sends request
    Then Should return status code 400
    And Validates response message with message "invalid id"
