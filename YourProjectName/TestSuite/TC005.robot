*** Settings ***
Resource    ${CURDIR}/../Resource/Lib/Lib.resource

*** Test Cases ***
Verify should be create users success status 200
    [Documentation]    
    [Tags]    API
    RequestsLibrary.Create Session    alias=mySession    url=https://reqres.in    disable_warnings=1
    ${payloads}=    BuiltIn.Evaluate    json.loads('{"name": "Phattharaphon", "job": "Quality Assurance"}')
    ${getResponse}=    RequestsLibrary.PUT On Session    mySession    /api/users/2    data=${payloads}
    ${data}=    BuiltIn.Set Variable      ${getResponse.json()}
    BuiltIn.Should Be Equal    ${data['name']}    Phattharaphon
    BuiltIn.Should Be Equal    ${data['job']}    Quality Assurance
    RequestsLibrary.Delete All Sessions