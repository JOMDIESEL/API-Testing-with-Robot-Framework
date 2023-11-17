*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary

***Variables***
${stat_correct}=   200
${id}=    12
${email}=   rachel.howell@reqres.in 
${first_name}=    Rachel
${Last_name}=    Howell 
${avatar}=    https://reqres.in/img/faces/12-image.jpg
${stat_err}=   404
${invalid_id}=    1234
${json_data}=    {}

***Keywords***
Verify response status code should be 200 
    [Arguments]    ${stat_correct}
    RequestsLibrary.Create session     alias=get_assets    url=https://reqres.in
    ${response}=    GET On Session    get_assets    api/users/${id}    expected_status=${stat_correct}  
    Should be equal as strings    ${response.status_code}    ${stat_correct}

Compare the response body with expected ID
    [Arguments]        ${id}                 
    RequestsLibrary.Create session     alias=get_assets    url=https://reqres.in
    ${response}=    GET On Session    get_assets    api/users/${id} 
    ${User_id}=    Convert To String    ${response.json()['data']['id']}
    Should be equal as strings    ${User_id}    ${id}

Compare the response body with expected email
    [Arguments]    ${email}
    RequestsLibrary.Create session     alias=get_assets    url=https://reqres.in
    ${response}=    GET On Session    get_assets    api/users/${id} 
    ${User_email}=    Convert To String    ${response.json()['data']['email']}
    Should be equal as strings    ${User_email}    ${email}

Compare the response body with expected first name
    [Arguments]    ${first_name}
    RequestsLibrary.Create session     alias=get_assets    url=https://reqres.in
    ${response}=    GET On Session    get_assets    api/users/${id} 
    ${User_first_name}=    Convert To String    ${response.json()['data']['first_name']}
    Should be equal as strings    ${User_first_name}    ${first_name}
    
Compare the response body with expected last name
    [Arguments]    ${Last_name}
    RequestsLibrary.Create session     alias=get_assets    url=https://reqres.in
    ${response}=    GET On Session    get_assets    api/users/${id} 
    ${User_last_name}=    Convert To String    ${response.json()['data']['last_name']}
    Should be equal as strings    ${User_last_name}    ${last_name}

Compare the response body with expected avatar
    [Arguments]    ${avatar}
    RequestsLibrary.Create session     alias=get_assets    url=https://reqres.in
    ${response}=    GET On Session    get_assets    api/users/${id} 
    ${User_avatar}=    Convert To String    ${response.json()['data']['avatar']}
    Should be equal as strings    ${User_avatar}    ${avatar}

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

*** Test Cases ***
TC_001 Get user profile success 
    Verify response status code should be 200             ${stat_correct}
    Compare the response body with expected ID            ${id}
    Compare the response body with expected email         ${email}
    Compare the response body with expected first name    ${first_name}
    Compare the response body with expected last name     ${Last_name}
    Compare the response body with expected avatar        ${avatar}

TC_002 Get user profile but user not found 
    Verify response status code should be 404       ${stat_err}    ${invalid_id}
    Verify response data is empty                   ${stat_err}    ${invalid_id}

