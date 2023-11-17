***Settings***
Library                 SeleniumLibrary
Test Setup              SeleniumLibrary.Open Browser            ${url}              ${browser}              
Test Teardown           SeleniumLibrary.Close Browser

***Variables***
${url}=             http://the-internet.herokuapp.com/login 
${browser}=         gc
${username}=        tomsmith
${no_username}=     tomholland
${inv_password}=    password
${password}=        SuperSecretPassword!
&{dict_login_page_path}
...    Find_Login_page=xpath=//h2[contains(., "Login Page")]
...    Input_username=xpath=//input[@id='username']
...    Input_password=xpath=//input[@id='password']
...    Click_Login=xpath=//i[@class='fa fa-2x fa-sign-in']
...    Login_text=You logged into a secure area!
...    Logout_text=You logged out of the secure area!
...    Pass_Login_fail_text=Your password is invalid!
...    User_Login_fail_text=Your username is invalid!
&{dict_logout_page_path}
...    Click_logout=xpath=//i[@class='icon-2x icon-signout'] 

***Keywords***
Find Login page 
    SeleniumLibrary.Page Should Contain Element    ${dict_login_page_path}[Find_Login_page]

Input username on Login page 
    [Arguments]                    ${username}
    SeleniumLibrary.Input Text                     ${dict_login_page_path}[Input_username]    ${username}

Input password on Login page  
    [Arguments]                    ${password}
    SeleniumLibrary.Input Text                     ${dict_login_page_path}[Input_password]     ${password}

Click login on Login page 
    SeleniumLibrary.Click Element                  ${dict_login_page_path}[Click_Login]

Find login success on home page 
    SeleniumLibrary.Page Should Contain            ${dict_login_page_path}[Login_text]

Click logout on Logout page 
    SeleniumLibrary.Click Element                  ${dict_logout_page_path}[Click_logout]

Find logout success on Login page
    SeleniumLibrary.Page Should Contain            ${dict_login_page_path}[Logout_text]  
    
Find password login failed on Login page
    SeleniumLibrary.Page Should Contain            ${dict_login_page_path}[Pass_Login_fail_text]

Find username login failed on login page
    SeleniumLibrary.Page Should Contain            ${dict_login_page_path}[User_Login_fail_text]

***Test Cases***
TC_001 Login success 
    Find login page 
    Input username on Login page            ${username}
    Input password on Login page            ${password}
    Click login on Login page 
    Find login success on home page
    Click logout on Logout page 
    Find logout success on Login page

TC_002 Login failed password incorrect 
    Find Login page     
    Input username on Login page           ${username}
    Input password on Login page           ${inv_password}
    Click login on Login page 
    Find password login failed on Login page

TC_003 Login failed username not found 
    Find Login page 
    Input username on Login page           ${no_username}
    Input password on Login page           ${inv_password}
    Click login on Login page
    Find username login failed on login page
   