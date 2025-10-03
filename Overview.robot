*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Suite Setup    Set Screenshot Directory    ${OUTPUT DIR}${/}screenshots

*** Variables ***
${BROWSER}              chrome
${LOGIN_URL}            http://localhost:3001/
${OVERVIEW_URL}         http://localhost:3001/dashboard
${EMAIL_INPUT}          xpath=//*[@id="root"]/div/div/form/input[1]
${PASSWORD_INPUT}       xpath=//*[@id="root"]/div/div/form/input[2]
${LOGIN_BUTTON}         xpath=//*[@id="root"]/div/div/form/button
${COUNTRY_SELECT}       xpath=//*[@id="root"]/div/div[2]/div/div[1]/div[1]/div[1]/select[1]
${STOCK_SELECT}         xpath=//*[@id="root"]/div/div[2]/div/div[1]/div[1]/div[1]/select[2]
${TIME_SELECT}          xpath=//*[@id="root"]/div/div[2]/div/div[1]/div[1]/div[2]
${CHART_CONTAINER}      xpath=//*[@id="root"]/div/div[2]/div/div[1]/div[2]/div
${TIME_BUTTONS_ROOT}         //*[@id="root"]/div/div[2]/div/div[1]/div[1]/div[2]   
@{TIME_WINDOWS}         5D    1M    3M    6M    1Y    ALL
${GAINER_LOSER}         xpath=//*[@id="root"]/div/div[2]/div/div[2]                     
@{USA_Symbol}           AAPL    AMD    AMZN    AVGO    GOOGL    META    MSFT    NVDA    TSLA    TSM
@{THA_Symbol}           ADVANC    DIF    DITTO    HUMAN    INET    INSET    JAS    JMART    TRUE

# Test data
${VALID_EMAIL}          kittipob.jir@rmutto.ac.th
${VALID_PASSWORD}       1234


*** Test Cases ***
Select Country Sucess สลับประเทศแล้วกราฟยังแสดงปกติ
    [Setup]    Login And Go To Dashboard
    Wait Until Page Contains Element    ${COUNTRY_SELECT}       10s
    Wait Until Page Contains Element    ${CHART_CONTAINER}      10s

    Select From List By Label           ${COUNTRY_SELECT}       Thailand (TH)
    List Selection Should Be            ${COUNTRY_SELECT}       Thailand (TH)
    Element Should Be Visible           ${CHART_CONTAINER}

    Select From List By Label           ${COUNTRY_SELECT}       United States (USA)
    List Selection Should Be            ${COUNTRY_SELECT}       United States (USA)
    Element Should Be Visible           ${CHART_CONTAINER}
    Close Browser


*** Test Cases ***
Select Stock Symbol Success สลับประเทศ + สัญลักษณ์หุ้นแล้วกราฟยังแสดงปกติ
    [Setup]    Login And Go To Dashboard
    Wait Until Page Contains Element    ${COUNTRY_SELECT}       10s
    Wait Until Page Contains Element    ${STOCK_SELECT}         10s
    Wait Until Page Contains Element    ${CHART_CONTAINER}      10s

    Select From List By Label           ${COUNTRY_SELECT}       Thailand (TH)
    List Selection Should Be            ${COUNTRY_SELECT}       Thailand (TH)
    Element Should Be Visible           ${CHART_CONTAINER}

    Select From List By Label           ${STOCK_SELECT}         ALL
    List Selection Should Be            ${STOCK_SELECT}         ALL
    Element Should Be Visible           ${CHART_CONTAINER}

    Select From List By Label           ${STOCK_SELECT}         ADVANC
    List Selection Should Be            ${STOCK_SELECT}         ADVANC
    Element Should Be Visible           ${CHART_CONTAINER}

    Select From List By Label           ${STOCK_SELECT}         DIF
    List Selection Should Be            ${STOCK_SELECT}         DIF
    Element Should Be Visible           ${CHART_CONTAINER}

    Select From List By Label           ${STOCK_SELECT}         DITTO
    List Selection Should Be            ${STOCK_SELECT}         DITTO
    Element Should Be Visible           ${CHART_CONTAINER}

    Select From List By Label           ${STOCK_SELECT}         HUMAN
    List Selection Should Be            ${STOCK_SELECT}         HUMAN
    Element Should Be Visible           ${CHART_CONTAINER}

    Select From List By Label           ${STOCK_SELECT}         INET
    List Selection Should Be            ${STOCK_SELECT}         INET
    Element Should Be Visible           ${CHART_CONTAINER}

    Select From List By Label           ${STOCK_SELECT}         INSET
    List Selection Should Be            ${STOCK_SELECT}         INSET
    Element Should Be Visible           ${CHART_CONTAINER}

    Select From List By Label           ${STOCK_SELECT}         JAS
    List Selection Should Be            ${STOCK_SELECT}         JAS
    Element Should Be Visible           ${CHART_CONTAINER}

    Select From List By Label           ${STOCK_SELECT}         JMART
    List Selection Should Be            ${STOCK_SELECT}         JMART
    Element Should Be Visible           ${CHART_CONTAINER}

    Select From List By Label           ${STOCK_SELECT}         TRUE
    List Selection Should Be            ${STOCK_SELECT}         TRUE
    Element Should Be Visible           ${CHART_CONTAINER}

    Select From List By Label          ${COUNTRY_SELECT}        United States (USA)
    List Selection Should Be           ${COUNTRY_SELECT}        United States (USA)
    Element Should Be Visible          ${CHART_CONTAINER}

    Select From List By Label           ${STOCK_SELECT}         ALL
    List Selection Should Be            ${STOCK_SELECT}         ALL
    Element Should Be Visible           ${CHART_CONTAINER}

    Select From List By Label           ${STOCK_SELECT}         AAPL
    List Selection Should Be            ${STOCK_SELECT}         AAPL
    Element Should Be Visible           ${CHART_CONTAINER}

    Select From List By Label           ${STOCK_SELECT}         AMD
    List Selection Should Be            ${STOCK_SELECT}         AMD
    Element Should Be Visible           ${CHART_CONTAINER}

    Select From List By Label           ${STOCK_SELECT}         AMZN
    List Selection Should Be            ${STOCK_SELECT}         AMZN
    Element Should Be Visible           ${CHART_CONTAINER}

    Select From List By Label           ${STOCK_SELECT}         AVGO
    List Selection Should Be            ${STOCK_SELECT}         AVGO
    Element Should Be Visible           ${CHART_CONTAINER}

    Select From List By Label           ${STOCK_SELECT}         GOOGL
    List Selection Should Be            ${STOCK_SELECT}         GOOGL
    Element Should Be Visible           ${CHART_CONTAINER}

    Select From List By Label           ${STOCK_SELECT}         META
    List Selection Should Be            ${STOCK_SELECT}         META
    Element Should Be Visible           ${CHART_CONTAINER}

    Select From List By Label           ${STOCK_SELECT}         MSFT
    List Selection Should Be            ${STOCK_SELECT}         MSFT
    Element Should Be Visible           ${CHART_CONTAINER}

    Select From List By Label           ${STOCK_SELECT}         NVDA
    List Selection Should Be            ${STOCK_SELECT}         NVDA
    Element Should Be Visible           ${CHART_CONTAINER}

    Select From List By Label           ${STOCK_SELECT}         TSLA
    List Selection Should Be            ${STOCK_SELECT}         TSLA
    Element Should Be Visible           ${CHART_CONTAINER}

    Select From List By Label           ${STOCK_SELECT}         TSM
    List Selection Should Be            ${STOCK_SELECT}         TSM
    Element Should Be Visible           ${CHART_CONTAINER}

    Close Browser

*** Test Cases ***
Select Timeframre Sucess สลับประเทศ + สัญลักษณ์หุ้น + ช่วงเวลา แล้วกราฟต้องยังแสดงปกติ
    [Setup]    Login And Go To Dashboard
    Wait Until Page Contains Element    ${COUNTRY_SELECT}       10s
    Wait Until Page Contains Element    ${STOCK_SELECT}         10s
    Wait Until Page Contains Element    ${CHART_CONTAINER}      10s

    Select From List By Label           ${COUNTRY_SELECT}       Thailand (TH)
    List Selection Should Be            ${COUNTRY_SELECT}       Thailand (TH)
    Element Should Be Visible           ${CHART_CONTAINER}

    Select From List By Label           ${STOCK_SELECT}         ALL
    List Selection Should Be            ${STOCK_SELECT}         ALL
    Element Should Be Visible           ${CHART_CONTAINER}
    Loop Time Windows  

    Select From List By Label           ${STOCK_SELECT}         ADVANC
    List Selection Should Be            ${STOCK_SELECT}         ADVANC
    Element Should Be Visible           ${CHART_CONTAINER}
    Loop Time Windows  

    Select From List By Label           ${STOCK_SELECT}         DIF
    List Selection Should Be            ${STOCK_SELECT}         DIF
    Element Should Be Visible           ${CHART_CONTAINER}
    Loop Time Windows  

    Select From List By Label           ${STOCK_SELECT}         DITTO
    List Selection Should Be            ${STOCK_SELECT}         DITTO
    Element Should Be Visible           ${CHART_CONTAINER}
    Loop Time Windows  

    Select From List By Label           ${STOCK_SELECT}         HUMAN
    List Selection Should Be            ${STOCK_SELECT}         HUMAN
    Element Should Be Visible           ${CHART_CONTAINER}
    Loop Time Windows  

    Select From List By Label           ${STOCK_SELECT}         INET
    List Selection Should Be            ${STOCK_SELECT}         INET
    Element Should Be Visible           ${CHART_CONTAINER}
    Loop Time Windows  

    Select From List By Label           ${STOCK_SELECT}         INSET
    List Selection Should Be            ${STOCK_SELECT}         INSET
    Element Should Be Visible           ${CHART_CONTAINER}
    Loop Time Windows  

    Select From List By Label           ${STOCK_SELECT}         JAS
    List Selection Should Be            ${STOCK_SELECT}         JAS
    Element Should Be Visible           ${CHART_CONTAINER}
    Loop Time Windows  

    Select From List By Label           ${STOCK_SELECT}         JMART
    List Selection Should Be            ${STOCK_SELECT}         JMART
    Element Should Be Visible           ${CHART_CONTAINER}
    Loop Time Windows  

    Select From List By Label           ${STOCK_SELECT}         TRUE
    List Selection Should Be            ${STOCK_SELECT}         TRUE
    Element Should Be Visible           ${CHART_CONTAINER}
    Loop Time Windows  

    Select From List By Label           ${COUNTRY_SELECT}       United States (USA)
    List Selection Should Be            ${COUNTRY_SELECT}       United States (USA)
    Element Should Be Visible           ${CHART_CONTAINER}

    Select From List By Label           ${STOCK_SELECT}         ALL
    List Selection Should Be            ${STOCK_SELECT}         ALL
    Element Should Be Visible           ${CHART_CONTAINER}
    Loop Time Windows  

    Select From List By Label           ${STOCK_SELECT}         AAPL
    List Selection Should Be            ${STOCK_SELECT}         AAPL
    Element Should Be Visible           ${CHART_CONTAINER}
    Loop Time Windows  

    Select From List By Label           ${STOCK_SELECT}         AMD
    List Selection Should Be            ${STOCK_SELECT}         AMD
    Element Should Be Visible           ${CHART_CONTAINER}
    Loop Time Windows  

    Select From List By Label           ${STOCK_SELECT}         AMZN
    List Selection Should Be            ${STOCK_SELECT}         AMZN
    Element Should Be Visible           ${CHART_CONTAINER}
    Loop Time Windows  

    Select From List By Label           ${STOCK_SELECT}         AVGO
    List Selection Should Be            ${STOCK_SELECT}         AVGO
    Element Should Be Visible           ${CHART_CONTAINER}
    Loop Time Windows  

    Select From List By Label           ${STOCK_SELECT}         GOOGL
    List Selection Should Be            ${STOCK_SELECT}         GOOGL
    Element Should Be Visible           ${CHART_CONTAINER}
    Loop Time Windows  

    Select From List By Label           ${STOCK_SELECT}         META
    List Selection Should Be            ${STOCK_SELECT}         META
    Element Should Be Visible           ${CHART_CONTAINER}
    Loop Time Windows  

    Select From List By Label           ${STOCK_SELECT}         MSFT
    List Selection Should Be            ${STOCK_SELECT}         MSFT
    Element Should Be Visible           ${CHART_CONTAINER}
    Loop Time Windows  

    Select From List By Label           ${STOCK_SELECT}         NVDA
    List Selection Should Be            ${STOCK_SELECT}         NVDA
    Element Should Be Visible           ${CHART_CONTAINER}
    Loop Time Windows  

    Select From List By Label           ${STOCK_SELECT}         TSLA
    List Selection Should Be            ${STOCK_SELECT}         TSLA
    Element Should Be Visible           ${CHART_CONTAINER}
    Loop Time Windows  

    Select From List By Label           ${STOCK_SELECT}         TSM
    List Selection Should Be            ${STOCK_SELECT}         TSM
    Element Should Be Visible           ${CHART_CONTAINER}
    Loop Time Windows  

    Close Browser

*** Test Cases ***
Select Top gainer/loser Sucess สลับประเทศ + ช่วงเวลา เพื่อดู Top gainer, Loser
    [Setup]    Login And Go To Dashboard
    Wait Until Element Is Visible       ${COUNTRY_SELECT}       10s
    Wait Until Element Is Visible       xpath=${TIME_BUTTONS_ROOT}//button[normalize-space()='5D']      10s
    Wait Until Element Is Visible       ${CHART_CONTAINER}      10s

    Select From List By Label           ${COUNTRY_SELECT}       Thailand (TH)
    List Selection Should Be            ${COUNTRY_SELECT}       Thailand (TH)
    Element Should Be Visible           ${CHART_CONTAINER}
    Scroll To                           ${GAINER_LOSER}
    Execute Javascript                  window.scrollTo(0,0)
    Loop Time Windows

    Select From List By Label           ${COUNTRY_SELECT}       United States (USA)
    List Selection Should Be            ${COUNTRY_SELECT}       United States (USA)
    Element Should Be Visible           ${CHART_CONTAINER}
    Scroll To                           ${GAINER_LOSER}
    Execute Javascript                  window.scrollTo(0,0)
    Loop Time Windows

    Close Browser

*** Keywords ***
Login And Go To Dashboard
    Open Browser    ${LOGIN_URL}        ${BROWSER}
    Wait Until Element Is Visible       ${EMAIL_INPUT}    10s
    Input Text      ${EMAIL_INPUT}      ${VALID_EMAIL}
    Input Text      ${PASSWORD_INPUT}   ${VALID_PASSWORD}
    Click Element   ${LOGIN_BUTTON}
    ${alert_text}=    Handle Alert    ACCEPT    timeout=5s
    Should Be Equal       ${alert_text}    เข้าสู่ระบบแอดมินสำเร็จ
    Wait Until Location Is    ${OVERVIEW_URL}    10s


Scroll To
    [Arguments]     ${target_locator}    ${max_scrolls}=12
    FOR    ${attempt}    IN RANGE        ${max_scrolls}
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${target_locator}
        Exit For Loop If    ${is_visible}
        Execute Javascript    window.scrollBy(0, Math.floor(window.innerHeight*0.85));
        Sleep    2s
    END
    Element Should Be Visible    ${target_locator}

Get Time Button
    [Arguments]    ${time_label}
    [Return]       xpath=${TIME_BUTTONS_ROOT}//button[normalize-space()='${time_label}']

Click Time Button
    [Arguments]    ${time_label}
    ${time_button}=    Get Time Button    ${time_label}
    Scroll Element Into View          ${time_button}
    Wait Until Element Is Visible     ${time_button}       10s
    Click Element                     ${time_button}
    Wait Until Element Is Visible     ${CHART_CONTAINER}   10s
    ${time_button_class}=                  Get Element Attribute    ${time_button}    class
    Should Contain                    ${time_button_class}      active

Loop Time Windows
    [Arguments]    @{time_labels}
    ${count}=    Get Length    ${time_labels}
    Run Keyword If    ${count} == 0    Set Test Variable    @{time_labels}    @{TIME_WINDOWS}

    FOR    ${time_label}    IN    @{time_labels}
        Click Time Button   ${time_label}
        Scroll To           ${GAINER_LOSER}
        Execute Javascript  window.scrollTo(0,0)
    END
