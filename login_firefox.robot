*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Suite Setup    Set Screenshot Directory    ${OUTPUT DIR}${/}screenshots

*** Variables ***
${BROWSER}              firefox
${LOGIN_URL}            http://localhost:3001/
${OVERVIEW_URL}         http://localhost:3001/dashboard
${EMAIL_INPUT}          xpath=//*[@id="root"]/div/div/form/input[1]
${PASSWORD_INPUT}       xpath=//*[@id="root"]/div/div/form/input[2]
${LOGIN_BUTTON}         xpath=//*[@id="root"]/div/div/form/button

# Test data
${VALID_EMAIL}          kittipob.jir@rmutto.ac.th
${VALID_PASSWORD}       1234
${NULL_EMAIL}
${NULL_PASSWORD}

*** Test Cases ***

Login Success ตรวจสอบการเข้าสู่ระบบด้วยอีเมลและรหัสที่ถูกต้อง
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Wait Until Element Is Visible    ${EMAIL_INPUT}    10s
    Input Text    ${EMAIL_INPUT}      ${VALID_EMAIL}
    Input Text    ${PASSWORD_INPUT}   ${VALID_PASSWORD}
    Click Element    ${LOGIN_BUTTON}
    ${alert_text}=    Handle Alert    ACCEPT    timeout=5s
    Should Be Equal    ${alert_text}    เข้าสู่ระบบแอดมินสำเร็จ
    Wait Until Location Is    ${OVERVIEW_URL}    10s
    Close Browser

Login Fails ตรวจสอบการเข้าสู่ระบบด้วยอีเมลที่ไม่ใช่admin
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Wait Until Element Is Visible    ${EMAIL_INPUT}    10s
    Input Text    ${EMAIL_INPUT}      test1234@gmail.com
    Input Text    ${PASSWORD_INPUT}   1111
    Click Element    ${LOGIN_BUTTON}
    ${alert_text}=    Handle Alert    ACCEPT    timeout=5s
    Should Be Equal    ${alert_text}    ไม่พบบัญชีแอดมิน หรืออาจถูกระงับ
    Wait Until Location Is    ${LOGIN_URL}    10s
    Close Browser


Login Fails ตรวจสอบการเข้าสู่ระบบด้วยอีเมลที่ผิดฟอร์แมต
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Wait Until Element Is Visible    ${EMAIL_INPUT}    10s
    Input Text    ${EMAIL_INPUT}      test1234   
    Input Text    ${PASSWORD_INPUT}   1234
    Click Element    ${LOGIN_BUTTON}
    Page Should Contain Element    css=input[type="email"]:invalid
    Close Browser

Login Fails ตรวจสอบการเข้าสู่ระบบด้วยการไม่กรอกข้อมูล
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Input Text    ${EMAIL_INPUT}      ${NULL_EMAIL}
    Input Text    ${PASSWORD_INPUT}   ${NULL_PASSWORD}
    Click Element    ${LOGIN_BUTTON}
    ${alert_text}=    Handle Alert    ACCEPT    timeout=5s
    Should Be Equal    ${alert_text}    กรุณากรอกอีเมลและรหัสผ่าน
    Wait Until Location Is    ${LOGIN_URL}    10
    Close Browser