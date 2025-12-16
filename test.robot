*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Suite Setup    Set Screenshot Directory    ${OUTPUT DIR}${/}screenshots
Test Teardown     Close Browser
Test Setup    Login And Go to Dashboard
*** Variables ***
${BROWSER}                      chrome
${LOGIN_URL}                    http://localhost:3001/
${OVERVIEW_URL}                 http://localhost:3001/dashboard
${MarketTrend_URL}              http://localhost:3001/market-trend
${MarketTrend_Button}           xpath=//*[@id="root"]/div/div[1]/a[3]
${EMAIL_INPUT}                  xpath=//*[@id="root"]/div/div/form/input[1]
${PASSWORD_INPUT}               xpath=//*[@id="root"]/div/div/form/input[2]
${LOGIN_BUTTON}                 xpath=//*[@id="root"]/div/div/form/button
${STOCK_SELECT}                 xpath=//*[@id="root"]/div/div[2]/div/div/div[1]/select[2]
${TIMEFRAME}                    xpath=//*[@id="root"]/div/div[2]/div/div/div[1]/select[3]
${INDICATOR}                    xpath=//*[@id="root"]/div/div[2]/div/div/div[2]
${ADVANC_INDICATOR}             xpath=//*[@id="root"]/div/div[2]/div/div/div[3]
${Signals}                      xpath=//*[@id="root"]/div/div[2]/div/div/div[4]
${COUNTRY_SELECT}                 xpath=//*[@id="root"]/div/div[2]/div/div/div[1]/div/select[1]


# Test data
${VALID_EMAIL}                  kittipob.jir@rmutto.ac.th
${VALID_PASSWORD}               1234
${MSG_LOGIN_SUCCESS}        เข้าสู่ระบบแอดมินสำเร็จ

*** Test Cases ***
Login Success ตรวจสอบการเข้าสู่ระบบด้วยอีเมลและรหัสที่ถูกต้อง
    Wait Until Location Is    ${OVERVIEW_URL}    10s

Select Country TH Success
    [Setup]    Login And Go to Dashboard
    Click Element    ${MarketTrend_Button} 
    Wait Until Location Is     ${MarketTrend_URL}    10s
    Select Country    Thailand (TH)    

Select Country USA Success
    [Setup]    Login And Go to Dashboard
    Click Element    ${MarketTrend_Button} 
    Wait Until Location Is     ${MarketTrend_URL}    10s
    Select Country    United States (USA)  

Select Stock Success
    [Setup]    Login And Go to Dashboard
    Click Element    ${MarketTrend_Button} 
    Wait Until Location Is     ${MarketTrend_URL}    10s
    Select Country    United States (USA)  

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN_URL}    ${BROWSER} 
    Wait Until Element Is Visible    ${EMAIL_INPUT}    10s

Perform Login With Alert
    [Arguments]    ${username}    ${password}    ${expected_alert}
    Input Text    ${EMAIL_INPUT}      ${username}
    Input Text    ${PASSWORD_INPUT}   ${password}
    Click Element    ${LOGIN_BUTTON}
    ${alert_text}=    Handle Alert    ACCEPT    timeout=5s
    Should Be Equal    ${alert_text}    ${expected_alert}

Login And Go to Dashboard
    Open Browser To Login Page
    Perform Login With Alert    ${VALID_EMAIL}    ${VALID_PASSWORD}    ${MSG_LOGIN_SUCCESS}
    Wait Until Location Is    ${OVERVIEW_URL}    10s

Select Country
    [Arguments]    ${country_name}
    [Documentation]    เลือกประเทศจาก Dropdown
    Select From List By Label    ${COUNTRY_SELECT}    ${country_name}
    List Selection Should Be     ${COUNTRY_SELECT}    ${country_name}

Select Stock
    [Arguments]    ${STOCK_name}
    [Documentation]    เลือกหุ้นจาก Dropdown
    Select From List By Label    ${STOCK_SELECT}    ${STOCK_name}
    List Selection Should Be     ${STOCK_SELECT}    ${STOCK_name}