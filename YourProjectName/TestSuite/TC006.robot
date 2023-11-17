*** Settings ***
Resource    ${CURDIR}/../Resource/Lib/Lib.resource

*** Test Cases ***
Verify should be delete users success status 200
    [Documentation]    
    [Tags]    API
    RequestsLibrary.Create Session    alias=mySession    url=https://reqres.in    disable_warnings=1
    ${getResponse}=    RequestsLibrary.DELETE On Session    mySession    /api/users?page    params=${2}
    ${data}=    BuiltIn.Set Variable   ${getResponse.json}
    BuiltIn.Should Be Equal As Strings         ${getResponse.reason}    No Content
    RequestsLibrary.Status Should Be    204