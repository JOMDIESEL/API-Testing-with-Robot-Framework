*** Settings ***
Resource    ${CURDIR}/../Resource/Lib/Lib.resource

*** Test Cases ***
Verify user login success and status 200
    [Documentation]    
    [Tags]    API
    RequestsLibrary.Create Session    alias=mySession    url=https://reqres.in    disable_warnings=1
    ${getResponse}=    RequestsLibrary.POST On Session    mySession    /api/users?  params=delay=1    expected_status=201    
    BuiltIn.Should Be Equal As Strings         ${getResponse.reason}    Created 
    RequestsLibrary.Status Should Be    201
    ${data}    BuiltIn.Set Variable    ${getResponse.json()} 
    Log To Console    ${data}
