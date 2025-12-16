*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Suite Setup    Set Screenshot Directory    ${OUTPUT DIR}${/}screenshots

*** Variables ***
${BROWSER}              chrome
${LOGIN_URL}            http://localhost:3001/
${OVERVIEW_URL}         http://localhost:3001/dashboard
${ManageUser_URL}       http://localhost:3001/manageuser
${EMAIL_INPUT}          xpath=//*[@id="root"]/div/div/form/input[1]
${PASSWORD_INPUT}       xpath=//*[@id="root"]/div/div/form/input[2]
${LOGIN_BUTTON}         xpath=//*[@id="root"]/div/div/form/button
${ManageUser_BUTTON}    xpath=//*[@id="root"]/div/div[1]/a[7]
${MANAGEUSER_INPUT}     xpath=//*[@id="root"]/div/div[2]/div[2]/div/div[1]/input
${MANAGEEMAIL_INPUT}    xpath=//*[@id="root"]/div/div[2]/div[2]/div/div[2]/input

# Test data
${VALID_EMAIL}          kittipob.jir@rmutto.ac.th
${VALID_PASSWORD}       1234
${VALID_EDIT_USER}      StockMaster_RealXD123
${VALID_EDIT_EMAIL}     testUser123@gmail.com
${INVALID_EDIT_EMAIL}      testUser123gmail.com

*** Test Cases ***
View User information ตรวจสอบการดูข้อมูลผู้ใช้ที่ถูกต้อง
    [Setup]    Login And Go To Dashboard
    
    Click Element   xpath=//*[@id="root"]/div/div[2]/div/div/table/tbody/tr[1]/td[4]/button[1]
    Wait Until Element Is Visible    xpath=//*[@id="root"]/div/div[2]/div[2]/div[1]/h3    10s
    Wait Until Element Is Visible    xpath=//*[@id="root"]/div/div[2]/div[2]/div[2]/div[2]/div[1]   10s
    Click Element   xpath=//*[@id="root"]/div/div[2]/div[2]/div[1]/button
    Wait Until Element Is Visible    xpath=//*[@id="root"]/div/div[2]/div/div/table/tbody/tr[1]/td[4]/button[1]

    Close Browser

Edit User information Success ตรวจสอบการแก้ไขข้อมูลผู้ใช้ที่ถูกต้อง
    [Setup]    Login And Go To Dashboard

    Click Element   xpath=//*[@id="root"]/div/div[2]/div/div/table/tbody/tr[2]/td[4]/button[2]
    Wait Until Element Is Visible     ${MANAGEUSER_INPUT}     10s
    Press Keys    ${MANAGEUSER_INPUT}       CTRL+A
    Press Keys    ${MANAGEUSER_INPUT}       BACKSPACE
    Input Text    ${MANAGEUSER_INPUT}       ${VALID_EDIT_USER}
    Wait Until Element Is Visible     ${MANAGEEMAIL_INPUT}    10s
    Press Keys    ${MANAGEEMAIL_INPUT}      CTRL+A
    Press Keys    ${MANAGEEMAIL_INPUT}      BACKSPACE
    Input Text    ${MANAGEEMAIL_INPUT}      ${VALID_EDIT_EMAIL}
    Click Element   xpath=//*[@id="root"]/div/div[2]/div[2]/div/div[3]/button[2]
    Wait Until Page Contains Element    xpath=//*[@id="root"]/div/div[2]/div/div/table/tbody/tr[2]/td[1][normalize-space()='${VALID_EDIT_USER}']     10s
    Wait Until Page Contains Element    xpath=//*[@id="root"]/div/div[2]/div/div/table/tbody/tr[2]/td[2][normalize-space()='${VALID_EDIT_EMAIL}']    10s

    Close Browser

Edit User information Fails ตรวจสอบการแก้ไขข้อมูลผู้ใช้ด้วยอีเมลที่ผิดฟอร์แมต
    [Setup]    Login And Go To Dashboard
    Click Element   xpath=//*[@id="root"]/div/div[2]/div/div/table/tbody/tr[2]/td[4]/button[2]
    Wait Until Element Is Visible     ${MANAGEUSER_INPUT}     10s
    Press Keys    ${MANAGEUSER_INPUT}       CTRL+A
    Press Keys    ${MANAGEUSER_INPUT}       BACKSPACE
    Input Text    ${MANAGEUSER_INPUT}       ${VALID_EDIT_USER}
    Wait Until Element Is Visible     ${MANAGEEMAIL_INPUT}    10s
    Press Keys    ${MANAGEEMAIL_INPUT}      CTRL+A
    Press Keys    ${MANAGEEMAIL_INPUT}      BACKSPACE
    Input Text    ${MANAGEEMAIL_INPUT}      ${INVALID_EDIT_EMAIL}
    Handle Alert    ACCEPT    timeout=5s
    Wait Until Element Is Visible     ${MANAGEEMAIL_INPUT}    10s

    Close Browser

suspend User information Success ตรวจสอบการระงับบัญชีผู้ใช้ชั่วคราว
    [Setup]    Login And Go To Dashboard
    Wait Until Element Is Visible   xpath=//*[@id="root"]/div/div[2]/div/header[normalize-space()='User Management']      
    Wait Until Element Is Visible   xpath=//*[@id="root"]/div/div[2]/div/div/table/tbody/tr[3]/td[3]/span[normalize-space()='Active']     10s  
    Click Element    xpath=//*[@id="root"]/div/div[2]/div/div/table/tbody/tr[1]/td[4]/button[3]
    Wait Until Element Is Visible  xpath=//*[@id="root"]/div/div[2]/div[2]/div/h2[normalize-space()='ยืนยันการระงับบัญชี']    10s
    Click Element    xpath=//*[@id="root"]/div/div[2]/div[2]/div/div/button[2]
    ${alert_text}=    Handle Alert    ACCEPT    timeout=5s
    Wait Until Element Is Visible   xpath=//*[@id="root"]/div/div[2]/div/div/table/tbody/tr[1]/td[3]/span[normalize-space()='ระงับ']     10s 

    Click Element    xpath=//*[@id="root"]/div/div[2]/div/div/table/tbody/tr[2]/td[4]/button[3]
    Wait Until Element Is Visible  xpath=//*[@id="root"]/div/div[2]/div[2]/div/div/button[2]    10s
    Click Element    xpath=//*[@id="root"]/div/div[2]/div[2]/div/div/button[2]
    ${alert_text}=    Handle Alert    ACCEPT    timeout=5s
    Wait Until Element Is Visible   xpath=//*[@id="root"]/div/div[2]/div/div/table/tbody/tr[3]/td[3]/span[normalize-space()='Active']
    
    Close Browser



*** Keywords ***
Login And Go To Dashboard
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Wait Until Element Is Visible    ${EMAIL_INPUT}    10s
    Input Text    ${EMAIL_INPUT}      ${VALID_EMAIL}
    Input Text    ${PASSWORD_INPUT}   ${VALID_PASSWORD}
    Click Element    ${LOGIN_BUTTON}
    ${alert_text}=    Handle Alert    ACCEPT    timeout=5s
    Should Be Equal    ${alert_text}    เข้าสู่ระบบแอดมินสำเร็จ
    Wait Until Location Is    ${OVERVIEW_URL}   10s
    Click Element   xpath=//*[@id="root"]/div/div[1]/a[7]
    Wait Until Location Is    ${ManageUser_URL}    10s