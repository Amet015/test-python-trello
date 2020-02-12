Feature: Organization
  As a regular user, it wants to manage a organization, and creates a organization.

  @Smoke
  Scenario: Creates new Organization
    When Sets a "POST" request to "/organizations/"
      | key         | value            |
      | displayName | new Organization |
    And Sends request
    Then Should return status code 200
    And Saves response as "organizationObject"
    And Saves endpoint to delete
    And Validates response body with
      | key         | value            |
      | displayName | new Organization |
      | desc        |                  |
      | website     | None             |
    And Validates schema with "organization_schema.json"
    And Sets a "GET" request to "/organizations/organizationObject.id"
    And Sends request
    And Should return status code 200


  @defect
  Scenario: Add a member to an Organization
    Given Sets a "POST" request to "/organizations/"
      | key         | value            |
      | displayName | new Organization |
    And Sends request
    And Should return status code 200
    And Saves response as "organizationObject"
    And Saves endpoint to delete
    When Sets a "PUT" request to "/organizations/organizationObject.id/members"
      | key      | value      |
      | email    | (email)    |
      | fullName | Angel Owen |
    And Sends request
    Then Should return status code 200
    And Saves response as "organization_membersObject"
    And Validates response body with
      | key                      | value      |
      | memberships.1.memberType | normal     |
      | members.1.fullName       | Angel Owen |
    And Validates schema with "put_organization_members.json"
    And Sets a "GET" request to "/organizations/organization_membersObject.id/members"
    And Sends request
    And Should return status code 200


  @Functional
  Scenario: Change the name of the Organization
    Given Sets a "POST" request to "/organizations/"
      | key         | value            |
      | displayName | new Organization |
    And Sends request
    And Should return status code 200
    And Saves response as "organizationObject"
    And Saves endpoint to delete
    When Sets a "PUT" request to "/organizations/organizationObject.id"
      | key         | value                    |
      | displayName | new Name of Organization |
    And Sends request
    Then Should return status code 200
    And Saves response as "organizationNameObject"
    And Validates response body with
      | key         | value                    |
      | displayName | new Name of Organization |
      | teamType    | None                     |
      | desc        |                          |
      | descData    | None                     |
    And Validates schema with "put_organization.json"


  @Functional
  Scenario: Gets organization
    Given Sets a "POST" request to "/organizations/"
      | key         | value                |
      | displayName | TeamToOrganization   |
      | desc        | This is my team AT11 |
      | name        | 123                  |
      | website     | (website)            |
    And Sends request
    And Should return status code 200
    And Saves response as "OrganizationObject"
    And Saves endpoint to delete
    When Sets a "GET" request to "/organizations/OrganizationObject.id"
    And Sends request
    Then Should return status code 200
    And Saves response as "ResponseOrganizationObject"
    And Validates response body with
      | key         | value                |
      | displayName | TeamToOrganization   |
      | desc        | This is my team AT11 |
      | teamType    | None                 |
    And Validates schema with "get_organization_schema.json"
