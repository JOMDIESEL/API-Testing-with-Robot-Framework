*** Settings ***
Resource    ${CURDIR}/../Resource/Lib/Lib.resource

*** Test Cases ***
Verify should be get users detail success status 200
    [Documentation]    Verify should be get users detail success status 200.This test case verifies that the GET /api/users/2 endpoint returns a successful response with status code 200 and the expected user details.
    [Tags]    API
    RequestsLibrary.Create Session    alias=mySession    url=https://reqres.in    disable_warnings=1
    ${getResponse}=    RequestsLibrary.GET On Session    mySession    /api/users/2    
    ${test}=    BuiltIn.Set Variable   ${getResponse.json()}
    BuiltIn.Should Be Equal As Strings         ${getResponse.reason}  OK
    RequestsLibrary.Status Should Be    200
    BuiltIn.Should Be Equal    ${test['data']['id']}    ${2}
    BuiltIn.Should Be Equal    ${test['data']['email']}    janet.weaver@reqres.in
    BuiltIn.Should Be Equal    ${test['data']['first_name']}    Janet
    BuiltIn.Should Be Equal    ${test['data']['last_name']}    Weaver
    BuiltIn.Should Be Equal    ${test['data']['avatar']}    https://reqres.in/img/faces/2-image.jpg
    BuiltIn.Should Be Equal    ${test['support']['url']}    https://reqres.in/#support-heading
    BuiltIn.Should Be Equal    ${test['support']['text']}    To keep ReqRes free, contributions towards server costs are appreciated!
    
