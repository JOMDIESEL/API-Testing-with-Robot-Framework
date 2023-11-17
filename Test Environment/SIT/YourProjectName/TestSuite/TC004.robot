*** Settings ***
Resource    ${CURDIR}/../Resource/Lib/Lib.resource

*** Test Cases ***
Verify should be create users success status 200
    [Documentation]    
    [Tags]    API
    RequestsLibrary.Create Session    alias=mySession    url=https://reqres.in    disable_warnings=1
    ${payloads}=    BuiltIn.Evaluate    json.loads('{"name": "Test Tester", "job": "QA"}')
    ${getResponse}=    RequestsLibrary.POST On Session    mySession    /api/users    data=${payloads}    expected_status=201
    BuiltIn.Should Be Equal As Strings         ${getResponse.reason}    Created
    RequestsLibrary.Status Should Be    201
    ${data}    BuiltIn.Set Variable    ${getResponse.json()}
    Log To Console     ${data}
    BuiltIn.Should Be Equal    ${data['name']}    Test Tester
    BuiltIn.Should Be Equal    ${data['job']}    QA
    BuiltIn.Should Not Be Empty    ${data['id']}  
    BuiltIn.Should Not Be Empty     ${data['createdAt']}