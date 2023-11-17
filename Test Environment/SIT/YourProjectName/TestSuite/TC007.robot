*** Settings ***
Resource    ${CURDIR}/../Resource/Lib/Lib.resource

*** Test Cases ***
Verify user register success and status 200
    [Documentation]    
    [Tags]    API
    RequestsLibrary.Create Session    alias=mySession    url=https://reqres.in    disable_warnings=1
    ${payload}=    BuiltIn.Evaluate    json.loads('{"email": "eve.holt@reqres.in","password": "pistol"}')
    ${getResponse}=    RequestsLibrary.POST On Session    mySession    /api/register     data=${payload}
    BuiltIn.Should Be Equal As Strings         ${getResponse.reason}    OK
    RequestsLibrary.Status Should Be    200
    ${data}    BuiltIn.Set Variable    ${getResponse.json()} 
    Log To Console    ${data}
    Should Be Equal     ${data['id']}    ${4}
    Should Be Equal     ${data['token']}    QpwL5tke4Pnpja7X4
    