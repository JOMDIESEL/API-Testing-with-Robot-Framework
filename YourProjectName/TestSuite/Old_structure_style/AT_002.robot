*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
***Variables***
${stat_err}=   404
${invalid_id}=    1234
${json_data}=    {}
***Keywords***
Verify response status code should be 404 
    [Arguments]    ${stat_err}     ${invalid_id}
    RequestsLibrary.Create session     alias=get_assets    url=https://reqres.in
    ${response}=    GET On Session    get_assets    api/users/${invalid_id}    expected_status=${stat_err} 
    Should be equal as strings    ${response.status_code}    ${stat_err}
    
Verify response data is empty
    [Arguments]    ${stat_err}     ${id}
    RequestsLibrary.Create session     alias=get_assets    url=https://reqres.in
    ${response}=    GET On Session    get_assets    api/users/${id}    expected_status=${stat_err} 
    Should be equal as strings    ${response.content}    ${json_data}

***Test Cases***
TC_002 Get user profile but user not found 
    Verify response status code should be 404       ${stat_err}    ${invalid_id}
    Verify response data is empty                   ${stat_err}     ${invalid_id}