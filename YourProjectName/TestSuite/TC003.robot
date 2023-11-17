*** Settings ***
Resource    ${CURDIR}/../Resource/Lib/Lib.resource

*** Test Cases ***
Verify should be get users unsuccess status 404
    [Documentation]    
    [Tags]    API
    RequestsLibrary.Create Session    alias=mySession    url=https://reqres.in    disable_warnings=1
    ${getResponse}=    RequestsLibrary.GET On Session    mySession    /api/users/23    expected_status=404    
    ${test}=    BuiltIn.Set Variable   ${getResponse.json()}
    BuiltIn.Should Be Equal As Strings         ${getResponse.reason}    Not Found
    RequestsLibrary.Status Should Be    404