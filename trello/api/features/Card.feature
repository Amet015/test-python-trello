Feature: Card
  As a regular user, it wants to manage a card, and creates a card.

  @Smoke
  Scenario: Creates new card
    Given Sets a "POST" request to "/boards/"
      | key  | value        |
      | name | GherkinBoard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Sets a "POST" request to "/lists/"
      | key     | value            |
      | idBoard | (BoardObject.id) |
      | name    | GherkinList      |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    When Sets a "POST" request to "/cards/"
      | key    | value           |
      | idList | (ListObject.id) |
    And Sends request
    Then Should return status code 200
    And Saves response as "CardObject"
    And Validates response body with
      | key                                   | value  |
      | badges.attachmentsByType.trello.board | 0      |
      | badges.attachmentsByType.trello.card  | 0      |
      | badges.location                       | False  |
      | cover.size                            | normal |
      | cover.brightness                      | light  |
    And Validates schema with "card_schema.json"
    And Sets a "GET" request to "/cards/CardObject.id"
    And Sends request
    And Should return status code 200


  @Smoke
  Scenario: Delete a Card
    Given Sets a "POST" request to "/boards/"
      | key  | value                |
      | name | board to delete card |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Sets a "POST" request to "/lists/"
      | key     | value            |
      | idBoard | (BoardObject.id) |
      | name    | list of card     |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    And Sets a "POST" request to "/cards/"
      | key    | value           |
      | idList | (ListObject.id) |
    And Sends request
    And Should return status code 200
    And Saves response as "CardObject"
    When Sets a "DELETE" request to "/cards/CardObject.id"
    And Sends request
    Then Should return status code 200
    And Validates response body with
      | key    | value |
      | Limits | None  |
    And Validates schema with "delete_card_label_schema.json"
    And Sets a "GET" request to "/cards/CardObject.id"
    And Sends request
    And Should return status code 404


  @Acceptance
  Scenario: Add a new card with name
    Given Sets a "POST" request to "/boards/"
      | key  | value                |
      | name | boardForCardWithName |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Sets a "POST" request to "/lists/"
      | key     | value            |
      | idBoard | (BoardObject.id) |
      | name    | cardListName     |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    When Sets a "POST" request to "/cards/"
      | key    | value           |
      | idList | (ListObject.id) |
      | name   | newCardName     |
    And Sends request
    Then Should return status code 200
    And Saves response as "CardObject"
    And Validates response body with
      | key  | value       |
      | name | newCardName |
    And Validates schema with "card_schema.json"
    And Sets a "GET" request to "/cards/CardObject.id"
    And Sends request
    And Should return status code 200


  @Acceptance
  Scenario: Create a new checklist on a card
    Given Sets a "POST" request to "/boards/"
      | key  | value    |
      | name | newBoard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Sets a "POST" request to "/lists/"
      | key     | value            |
      | idBoard | (BoardObject.id) |
      | name    | GherkinList      |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    And Sets a "POST" request to "/cards/"
      | key    | value           |
      | idList | (ListObject.id) |
    And Sends request
    And Should return status code 200
    And Saves response as "CardObject"
    When Sets a "POST" request to "/cards/CardObject.id/checklists"
      | key  | value       |
      | name | myChecklist |
    And Sends request
    Then Should return status code 200
    And Saves response as "CardObjectUpdate"
    And Validates response body with
      | key        | value       |
      | name       | myChecklist |
      | checkItems | []          |
    And Validates schema with "checklist_schema.json"
    And Sets a "GET" request to "/cards/CardObject.id"
    And Sends request
    And Should return status code 200


  @Functional
  Scenario: Creates a new card with parameters
    Given Sets a "POST" request to "/boards/"
      | key  | value               |
      | name | boardFunctionalCard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Sets a "POST" request to "/lists/"
      | key     | value               |
      | idBoard | (BoardObject.id)    |
      | name    | boardFunctionalList |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    When Sets a "POST" request to "/cards/"
      | key         | value                 |
      | name        | functionalCard        |
      | desc        | this is a description |
      | pos         | top                   |
      | dueComplete | false                 |
      | idList      | (ListObject.id)       |
      | website     | (website)             |
    And Sends request
    Then Should return status code 200
    And Saves response as "CardObject"
    And Validates response body with
      | key                                   | value          |
      | badges.attachmentsByType.trello.board | 0              |
      | badges.attachmentsByType.trello.card  | 0              |
      | closed                                | False          |
      | name                                  | functionalCard |
    And Validates schema with "card_schema.json"
    And Sets a "GET" request to "/cards/CardObject.id"
    And Sends request
    And Should return status code 200


  @Functional
  Scenario: Adds a sticker to a card
    Given Sets a "POST" request to "/boards/"
      | key  | value                      |
      | name | boardFunctionalCardSticker |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Sets a "POST" request to "/lists/"
      | key     | value                      |
      | idBoard | (BoardObject.id)           |
      | name    | boardFunctionalListSticker |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    And Sets a "POST" request to "/cards/"
      | key    | value                 |
      | name   | functionalCardSticker |
      | idList | (ListObject.id)       |
    And Sends request
    And Should return status code 200
    And Saves response as "CardObject"
    When Sets a "POST" request to "/cards/CardObject.id/stickers"
      | key    | value |
      | image  | heart |
      | top    | 0     |
      | left   | 47    |
      | zIndex | 1     |
    And Sends request
    Then Should return status code 200
    And Validates response body with
      | key    | value |
      | top    | 0     |
      | left   | 47    |
      | image  | heart |
      | zIndex | 1     |
    And Validates schema with "card_sticker_schema.json"
    And Sets a "GET" request to "/cards/CardObject.id"
    And Sends request
    And Should return status code 200


  @Functional
  Scenario: Add a new comment to a card
    Given Sets a "POST" request to "/boards/"
      | key  | value               |
      | name | boardForCardComment |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Sets a "POST" request to "/lists/"
      | key     | value            |
      | idBoard | (BoardObject.id) |
      | name    | cardList         |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    And Sets a "POST" request to "/cards/"
      | key    | value           |
      | idList | (ListObject.id) |
    And Sends request
    And Should return status code 200
    And Saves response as "CardObject"
    And Should return status code 200
    When Sets a "POST" request to "/cards/CardObject.id/actions/comments"
      | key  | value             |
      | text | This is a comment |
    And Sends request
    Then Should return status code 200
    And Validates response body with
      | key       | value             |
      | data.text | This is a comment |
    And Validates schema with "card_add_comment_schema.json"
    And Sets a "GET" request to "/cards/CardObject.id"
    And Sends request
    And Should return status code 200


  @Functional
  Scenario: Add a new label to a card
    Given Sets a "POST" request to "/boards/"
      | key  | value                 |
      | name | boardForCardWithLabel |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Sets a "POST" request to "/lists/"
      | key     | value            |
      | idBoard | (BoardObject.id) |
      | name    | cardListName     |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    And Sets a "POST" request to "/cards/"
      | key    | value           |
      | idList | (ListObject.id) |
      | name   | newCardLabel    |
    And Sends request
    And Should return status code 200
    And Saves response as "CardObject"
    When Sets a "POST" request to "/cards/CardObject.id/labels"
      | key   | value           |
      | id    | (CardObject.id) |
      | color | green           |
      | name  | greenLabel      |
    And Sends request
    Then Should return status code 200
    And Saves response as "CardLabelObject"
    And Validates response body with
      | key   | value      |
      | color | green      |
      | name  | greenLabel |
    And Validates schema with "card_label_schema.json"
    And Sets a "GET" request to "/cards/CardObject.id"
    And Sends request
    And Should return status code 200


  @Functional
  Scenario: Add a new comment to a card
    Given Sets a "POST" request to "/boards/"
      | key  | value               |
      | name | boardForCardComment |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Sets a "POST" request to "/lists/"
      | key     | value            |
      | idBoard | (BoardObject.id) |
      | name    | cardList         |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    And Sets a "POST" request to "/cards/"
      | key    | value           |
      | idList | (ListObject.id) |
    And Sends request
    And Should return status code 200
    And Saves response as "CardObject"
    And Should return status code 200
    When Sets a "POST" request to "/cards/CardObject.id/actions/comments"
      | key  | value             |
      | text | This is a comment |
    And Sends request
    Then Should return status code 200
    And Validates response body with
      | key       | value             |
      | data.text | This is a comment |
    And Validates schema with "card_add_comment_schema.json"
    And Sets a "GET" request to "/cards/CardObject.id"
    And Sends request
    And Should return status code 200


  @Functional
  Scenario: Modify the name of a card
    Given Sets a "POST" request to "/boards/"
      | key  | value               |
      | name | boardFunctionalCard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Sets a "POST" request to "/lists/"
      | key     | value               |
      | idBoard | (BoardObject.id)    |
      | name    | boardFunctionalList |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    And Sets a "POST" request to "/cards/"
      | key    | value           |
      | name   | functionalCard  |
      | idList | (ListObject.id) |
    And Sends request
    And Should return status code 200
    And Saves response as "CardObject"
    When Sets a "PUT" request to "/cards/CardObject.id"
      | key  | value                |
      | name | new name of the card |
    And Sends request
    Then Should return status code 200
    And Validates response body with
      | key                                   | value                |
      | badges.attachmentsByType.trello.board | 0                    |
      | badges.attachmentsByType.trello.card  | 0                    |
      | closed                                | False                |
      | name                                  | new name of the card |
    And Validates schema with "put_card_schema.json"
    And Sets a "GET" request to "/cards/CardObject.id"
    And Sends request
    And Should return status code 200


  @Functional
  Scenario: Creates a new checklist in a card with a top position
    Given Sets a "POST" request to "/boards/"
      | key  | value                    |
      | name | board to check list card |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Sets a "POST" request to "/lists/"
      | key     | value               |
      | idBoard | (BoardObject.id)    |
      | name    | boardFunctionalList |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    And Sets a "POST" request to "/cards/"
      | key    | value           |
      | name   | functionalCard  |
      | idList | (ListObject.id) |
    And Sends request
    And Should return status code 200
    And Saves response as "CardObject"
    When Sets a "POST" request to "/cards/CardObject.id/checklists"
      | key  | value                      |
      | name | Check List Card Functional |
      | pos  | top                        |
    And Sends request
    Then Should return status code 200
    And Saves response as "Card_AObject"
    And Validates response body with
      | key        | value                      |
      | name       | Check List Card Functional |
      | checkItems | []                         |
    And Validates schema with "put_card_add_checklist.json"
    And Sets a "GET" request to "/cards/CardObject.id/checklists"
    And Sends request
    And Should return status code 200


  @Functional
  Scenario: Gets the checklists on a card
    Given Sets a "POST" request to "/boards/"
      | key  | value          |
      | name | newBoardToCard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Sets a "POST" request to "/lists/"
      | key     | value            |
      | idBoard | (BoardObject.id) |
      | name    | newListToCard    |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    And Sets a "POST" request to "/cards/"
      | key    | value           |
      | idList | (ListObject.id) |
    And Sends request
    And Should return status code 200
    And Saves response as "CardObject"
    And Sets a "POST" request to "/cards/CardObject.id/checklists"
      | key  | value         |
      | name | checklistName |
      | pos  | top           |
    And Sends request
    And Should return status code 200
    And Saves response as "ChecklistObject"
    When Sets a "GET" request to "/cards/CardObject.id/checklists"
      | key              | value |
      | checkItems       | all   |
      | checkItem_fields | all   |
      | filter           | all   |
      | fields           | all   |
    And Sends request
    Then Should return status code 200
    And Validates response body with
      | key          | value         |
      | 0.checkItems | []            |
      | 0.name       | checklistName |
    And Validates schema with "checklist_schema_array.json"
    And Sets a "GET" request to "/checklists/ChecklistObject.id"
      | key    | value |
      | fields | all   |
      | cards  | all   |
    And Sends request
    And Should return status code 200


  @Functional
  Scenario: Find a card by id
    Given Sets a "POST" request to "/boards/"
      | key  | value            |
      | name | boardForFindCard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Sets a "POST" request to "/lists/"
      | key     | value            |
      | idBoard | (BoardObject.id) |
      | name    | findCardList     |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    And Sets a "POST" request to "/cards/"
      | key    | value           |
      | name   | findCard        |
      | idList | (ListObject.id) |
    And Sends request
    And Should return status code 200
    And Saves response as "CardObject"
    When Sets a "GET" request to "/cards/CardObject.id"
      | key  | value    |
      | name | findCard |
    And Sends request
    Then Should return status code 200
    And Validates response body with
      | key    | value    |
      | closed | False    |
      | name   | findCard |
    And Validates schema with "get_card_schema.json"


  @Negative
  Scenario: A list without name should not be created
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


  @Negative
  Scenario: It can not get a card by incorrect idCard
    When Sets a "GET" request to "/cards/5e3d75852b8afb5c7c60dc45invalidId/actions"
    And Sends request
    Then Should return status code 400
    And Validates response message with message "invalid id"


  @Negative
  Scenario: It can not get the member of a card that doesn't exist
    When Sets a "GET" request to "/cards/5e3d75852b8afb5c7c60dc45invalidId/members"
    And Sends request
    Then Should return status code 400
    And Validates response message with message "invalid id"
