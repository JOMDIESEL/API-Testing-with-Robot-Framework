*** Settings ***
Resource    ${CURDIR}/../Resource/Lib/Lib.resource

*** Test Cases ***
Verify should be get all users on page no.2 success status 200
    [Documentation]    This document describes a test case that verifies that the GET request to retrieve all users on page number 2 of the https://reqres.in API returns a successful response with a status code of 200. The test case also verifies that the response data contains the expected values for the page number, per page, total, and total pages.
    [Tags]    API
    RequestsLibrary.Create Session    alias=mySession    url=https://reqres.in    disable_warnings=1
    ${getResponse}=    RequestsLibrary.GET On Session    mySession    /api/users?page    params=${2}
    ${data}=    BuiltIn.Set Variable   ${getResponse.json()}
    BuiltIn.Should Be Equal As Strings         ${getResponse.reason}  OK
    RequestsLibrary.Status Should Be    200
    BuiltIn.Should Be Equal    ${data['page']}    ${1}
    BuiltIn.Should Be Equal    ${data['per_page']}    ${6}
    BuiltIn.Should Be Equal    ${data['total']}    ${12}
    BuiltIn.Should Be Equal    ${data['total_pages']}    ${2}


   