*** Settings ***
Resource    ${CURDIR}/../Resource/Lib/Lib.resource

*** Test Cases ***
Verify user register success and status 200
    [Documentation]    
    [Tags]    API
    RequestsLibrary.Create Session    alias=mySession    url=https://reqres.in    disable_warnings=1
    ${payload}=    BuiltIn.Evaluate    json.loads('{"email": "eve.holt@reqres.in"}')
    ${getResponse}=    RequestsLibrary.POST On Session    mySession    /api/register     data=${payload}    expected_status=400    
    BuiltIn.Should Be Equal As Strings         ${getResponse.reason}    Bad Request 
    RequestsLibrary.Status Should Be    400
    ${data}    BuiltIn.Set Variable    ${getResponse.json()} 
    BuiltIn.Should Be Equal     ${data['error']}    Missing password
