Feature: Board's list
 As a regular user, it wants to manage a list, and creates a list.

  @Smoke
  Scenario: Create a new list on a board
    Given Sets a "POST" request to "/boards/"
      | key  | value              |
      | name | newBoardPOSTToList |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    When Sets a "POST" request to "/list"
      | key     | value            |
      | name    | newListName      |
      | idBoard | (BoardObject.id) |
    And Sends request
    Then Should return status code 200
    And Saves response as "ListObject"
    And Validates response body with
      | key    | value       |
      | name   | newListName |
      | closed | False       |
      | limits | {}          |
    And Validates schema with "list_schema.json"
    And Sets a "GET" request to "/lists/ListObject.id"
    And Sends request
    And Should return status code 200


  @Acceptance
  Scenario: Update the name of a list using id
    Given Sets a "POST" request to "/boards/"
      | key  | value    |
      | name | newBoard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    When Sets a "POST" request to "/list"
      | key     | value            |
      | name    | newListName      |
      | idBoard | (BoardObject.id) |
    And Sends request
    Then Should return status code 200
    And Saves response as "ListObject"
    And Sets a "PUT" request to "/lists/ListObject.id"
      | key  | value       |
      | name | newListName |
    And Sends request
    And Should return status code 200
    And Validates response body with
      | key  | value       |
      | name | newListName |
    And Validates schema with "put_list_schema.json"
    And Sets a "GET" request to "/lists/ListObject.id"
    And Sends request
    And Should return status code 200


  @Functional
  Scenario: Creates a list with name and position
    Given Sets a "POST" request to "/boards/"
      | key  | value              |
      | name | newBoardFunctional |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    When Sets a "POST" request to "/lists/"
      | key     | value            |
      | name    | functionalList   |
      | idBoard | (BoardObject.id) |
      | pos     | top              |
    And Sends request
    Then Should return status code 200
    And Saves response as "ListObject"
    And Validates response body with
      | key    | value          |
      | name   | functionalList |
      | closed | False          |
      | limits | {}             |
    And Validates schema with "list_schema.json"
    And Sets a "GET" request to "/lists/ListObject.id"
    And Sends request
    And Should return status code 200


  @Functional
  Scenario: Moves a list from a board to another one
    Given Sets a "POST" request to "/boards/"
      | key  | value              |
      | name | newBoardFunctional |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Sets a "POST" request to "/boards/"
      | key  | value              |
      | name | newBoardFunctional |
    And Sends request
    And Should return status code 200
    And Saves response as "Board_AObject"
    When Sets a "POST" request to "/lists/"
      | key     | value            |
      | name    | functionalList   |
      | idBoard | (BoardObject.id) |
    And Sends request
    Then Should return status code 200
    And Saves response as "ListObject"
    And Validates response body with
      | key    | value          |
      | name   | functionalList |
      | closed | False          |
      | limits | {}             |
    And Validates schema with "list_schema.json"
    And Sets a "GET" request to "/lists/ListObject.id"
    And Sends request
    And Should return status code 200


  @Functional
  Scenario: Creates a list from another list
    Given Sets a "POST" request to "/boards/"
      | key  | value              |
      | name | newBoardFunctional |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Sets a "POST" request to "/lists/"
      | key     | value            |
      | name    | functionalList   |
      | idBoard | (BoardObject.id) |
      | pos     | top              |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    When Sets a "POST" request to "/lists/"
      | key          | value            |
      | name         | functionalList01 |
      | idListSource | (ListObject.id)  |
      | idBoard      | (BoardObject.id) |
    And Sends request
    Then Should return status code 200
    And Saves response as "SecondObjectList"
    And Validates response body with
      | key    | value            |
      | name   | functionalList01 |
      | closed | False            |
      | limits | {}               |
    And Validates schema with "list_schema.json"
    And Sets a "GET" request to "/lists/SecondObjectList.id"
    And Sends request
    And Should return status code 200


  @Functional
  Scenario: Modifies the list position to bottom
    Given Sets a "POST" request to "/boards/"
      | key  | value              |
      | name | newBoardFunctional |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Sets a "POST" request to "/lists/"
      | key     | value            |
      | name    | functionalList   |
      | idBoard | (BoardObject.id) |
      | pos     | top              |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    When Sets a "PUT" request to "/lists/ListObject.id/pos"
      | key   | value  |
      | value | bottom |
    And Sends request
    Then Should return status code 200
    And Validates response body with
      | key    | value          |
      | name   | functionalList |
      | closed | False          |
    And Validates schema with "put_list_schema.json"
    And Sets a "GET" request to "/lists/ListObject.id"
    And Sends request
    And Should return status code 200


  @Functional
  Scenario: Moves all cards from list to another list
    Given Sets a "POST" request to "/boards/"
      | key  | value        |
      | name | newBoardList |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Sets a "POST" request to "/list"
      | key     | value            |
      | name    | newFistList      |
      | idBoard | (BoardObject.id) |
    And Sends request
    And Should return status code 200
    And Saves response as "FirstListObject"
    And Sets a "POST" request to "/cards/"
      | key    | value                |
      | idList | (FirstListObject.id) |
      | name   | newFirstCard         |
    And Sends request
    And Should return status code 200
    And Saves response as "FirstCardObject"
    And Sets a "POST" request to "/cards/"
      | key    | value                |
      | idList | (FirstListObject.id) |
      | name   | newSecondCard        |
    And Sends request
    And Should return status code 200
    And Saves response as "SecondCardObject"
    And Sets a "POST" request to "/list"
      | key     | value            |
      | name    | newSecondList    |
      | idBoard | (BoardObject.id) |
    And Sends request
    And Should return status code 200
    And Saves response as "SecondListObject"
    When Sets a "POST" request to "/lists/FirstListObject.id/moveAllCards"
      | key     | value                 |
      | idBoard | (BoardObject.id)      |
      | idList  | (SecondListObject.id) |
    And Sends request
    Then Should return status code 200
    And Validates schema with "list_move_cards_to_list.json"
    And Sets a "GET" request to "/lists/SecondListObject.id"
    And Sends request
    And Should return status code 200


  @Functional
  Scenario: Closes a List
    Given Sets a "POST" request to "/boards/"
      | key  | value              |
      | name | newBoardFunctional |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Sets a "POST" request to "/lists/"
      | key     | value            |
      | name    | functionalList   |
      | idBoard | (BoardObject.id) |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    When Sets a "PUT" request to "/lists/ListObject.id/closed"
      | key   | value |
      | value | true  |
    And Sends request
    Then Should return status code 200
    And Saves response as "List_Object"
    And Validates response body with
      | key    | value          |
      | name   | functionalList |
      | closed | True           |
    And Validates schema with "put_list_schema.json"
    And Sets a "GET" request to "/lists/List_Object.id"
    And Sends request
    And Should return status code 200


  @Negative
  Scenario: A list without name could not be created
    Given Sets a "POST" request to "/boards/"
      | key  | value              |
      | name | newBoardPOSTToList |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    When Sets a "POST" request to "/list"
      | key     | value            |
      | idBoard | (BoardObject.id) |
    And Sends request
    Then Should return status code 400
    And Validates response message with message "invalid value for name"


  @defect
  Scenario: A list can't be created without a correct idBoard
    When Sets a "POST" request to "/list"
      | key     | value |
      | idBoard | None  |
    And Sends request
    Then Should return status code 400
    And Validates response message with message "invalid value for id"


  @defect
  Scenario: List does not allow to set softlimit over the limit 5000
    Given Sets a "POST" request to "/boards/"
      | key  | value              |
      | name | newBoardPOSTToList |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Sets a "POST" request to "/lists/"
      | key     | value            |
      | name    | functionalList   |
      | idBoard | (BoardObject.id) |
      | pos     | top              |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    When Sets a "PUT" request to "/lists/ListObject.id/softLimit"
      | key   | value |
      | value | 5001  |
    And Sends request
    Then Should return status code 400
    And Validates response message with message "invalid value for value"
