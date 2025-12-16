*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Suite Setup    Set Screenshot Directory    ${OUTPUT DIR}${/}screenshots

*** Variables ***
${BROWSER}                      chrome
${LOGIN_URL}                    http://localhost:3001/
${OVERVIEW_URL}                 http://localhost:3001/dashboard
${MarketTrend_URL}              http://localhost:3001/market-trend
${EMAIL_INPUT}                  xpath=//*[@id="root"]/div/div/form/input[1]
${PASSWORD_INPUT}               xpath=//*[@id="root"]/div/div/form/input[2]
${LOGIN_BUTTON}                 xpath=//*[@id="root"]/div/div/form/button
${COUNTRY_SELECT}               xpath=//*[@id="root"]/div/div[2]/div/div/div[1]/select[1]
${STOCK_SELECT}                 xpath=//*[@id="root"]/div/div[2]/div/div/div[1]/select[2]
${TIMEFRAME}                    xpath=//*[@id="root"]/div/div[2]/div/div/div[1]/select[3]
${INDICATOR}                    xpath=//*[@id="root"]/div/div[2]/div/div/div[2]
${ADVANC_INDICATOR}             xpath=//*[@id="root"]/div/div[2]/div/div/div[3]
${Signals}                      xpath=//*[@id="root"]/div/div[2]/div/div/div[4]
@{INDICATOR_LIST}               Moving Averages (SMA/EMA)    RSI (14)    MACD (12,26,9)    Bollinger Bands (20,2)
@{ADVANC_INDICATOR_LIST}        ATR (14)    Keltner Channel    Chaikin Volatility    Donchian Channel (20)    Parabolic SAR
@{USA_Symbol}                   AAPL    AMD    AMZN    AVGO    GOOGL    META    MSFT    NVDA    TSLA    TSM
@{THA_Symbol}                   ADVANC    DIF    DITTO    HUMAN    INET    INSET    JAS    JMART    TRUE
@{TIME_OPTIONS}                 1M    3M    6M    1Y    ALL


# Test data
${VALID_EMAIL}                  kittipob.jir@rmutto.ac.th
${VALID_PASSWORD}               1234


*** Test Cases ***
Select Country Sucess ตรวจสอบการแสดงผลของindicatorและสัญญาณซื้อขายที่ปกติหลังเลือกประเทศ
    [Setup]    Login And Go To Dashboard
    Wait Until Element Is Visible    ${COUNTRY_SELECT}    10s
    Wait Until Element Is Visible    ${STOCK_SELECT}      10s

    Select From List By Label        ${COUNTRY_SELECT}    Thailand (TH)
    List Selection Should Be         ${COUNTRY_SELECT}    Thailand (TH)

    Scroll To                        ${INDICATOR}
    Check Texts In Box               ${INDICATOR}    @{INDICATOR_LIST}
    Scroll To                        ${ADVANC_INDICATOR}
    Check Texts In Box               ${ADVANC_INDICATOR}    @{ADVANC_INDICATOR_LIST}
    Scroll To                        ${Signals}
    Execute Javascript               window.scrollTo(0,0)

    Select From List By Label        ${COUNTRY_SELECT}    United States (USA)
    List Selection Should Be         ${COUNTRY_SELECT}    United States (USA)

    Scroll To                        ${INDICATOR}
    Check Texts In Box               ${INDICATOR}    @{INDICATOR_LIST}
    Scroll To                        ${ADVANC_INDICATOR}
    Check Texts In Box               ${ADVANC_INDICATOR}    @{ADVANC_INDICATOR_LIST}
    Scroll To                        ${Signals}
    Execute Javascript               window.scrollTo(0,0)
    
    Close Browser


*** Test Cases ***
Select Stocksymbol Sucess ตรวจสอบการแสดงผลของindicatorและสัญญาณซื้อขายที่ปกติหลังเลือกประเทศและหุ้น
    [Setup]    Login And Go To Dashboard
    Wait Until Element Is Visible    ${COUNTRY_SELECT}    10s
    Wait Until Element Is Visible    ${STOCK_SELECT}      10s

    Select From List By Label        ${COUNTRY_SELECT}    Thailand (TH)
    List Selection Should Be         ${COUNTRY_SELECT}    Thailand (TH)
    Check Stocks And Indicators      @{THA_Symbol}

    Select From List By Label        ${COUNTRY_SELECT}    United States (USA)
    List Selection Should Be         ${COUNTRY_SELECT}    United States (USA)
    Check Stocks And Indicators      @{USA_Symbol}  

    Close Browser

Select Timeframe  Sucess ตรวจสอบการแสดงผลของindicatorและสัญญาณซื้อขายที่ปกติหลังเลือกประเทศ, หุ้น และ ช่วงเวลา
    [Setup]    Login And Go To Dashboard
    Wait Until Element Is Visible    ${COUNTRY_SELECT}    10s
    Wait Until Element Is Visible    ${STOCK_SELECT}      10s
    Wait Until Element Is Visible    ${TIMEFRAME}         10s

    Select From List By Label        ${COUNTRY_SELECT}    Thailand (TH)
    List Selection Should Be         ${COUNTRY_SELECT}    Thailand (TH)
    Loop Stocks Times And Check Indicators      @{THA_Symbol}        

    Select From List By Label        ${COUNTRY_SELECT}    United States (USA)
    List Selection Should Be         ${COUNTRY_SELECT}    United States (USA)
    Loop Stocks Times And Check Indicators      @{USA_Symbol}        

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
    Click Element   xpath=//*[@id="root"]/div/div[1]/a[3]
    Wait Until Location Is    ${MarketTrend_URL}    10s

Scroll To
    [Arguments]    ${target_locator}    ${max_scrolls}=12
    FOR    ${attempt}    IN RANGE    ${max_scrolls}
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${target_locator}
        Exit For Loop If    ${is_visible}
        Execute Javascript    window.scrollBy(0, Math.floor(window.innerHeight*0.85))
        Sleep    0.3s
    END
    Element Should Be Visible    ${target_locator}

Check Texts In Box
    [Arguments]    ${box}    @{check_list}
    Scroll To                  ${box}
    ${box_text}=               Get Text    ${box}
    FOR    ${text}    IN    @{check_list}
        Should Contain        ${box_text}    ${text}    msg=Missing: ${text}
    END

Select Stock
    [Arguments]    ${symbol_label}=ALL
    Scroll Element Into View          ${STOCK_SELECT}
    Wait Until Element Is Visible     ${STOCK_SELECT}     3s
    Select From List By Label         ${STOCK_SELECT}     ${symbol_label}
    List Selection Should Be          ${STOCK_SELECT}     ${symbol_label}
    Sleep    2s

Check Stocks And Indicators
    [Arguments]    @{symbols}
    FOR    ${symbol}    IN    @{symbols}
        Select Stock                  ${symbol}
        Scroll To                     ${INDICATOR}
        Check Texts In Box            ${INDICATOR}           @{INDICATOR_LIST}
        Scroll To                     ${Signals}
        Scroll To                     ${ADVANC_INDICATOR}
        Check Texts In Box            ${ADVANC_INDICATOR}    @{ADVANC_INDICATOR_LIST}
        Scroll To                     ${Signals}
        Execute Javascript            window.scrollTo(0,0)
    END

Select Time
    [Arguments]    ${time_label}
    Scroll Element Into View          ${TIMEFRAME}
    Wait Until Element Is Visible     ${TIMEFRAME}     10s
    Select From List By Label         ${TIMEFRAME}     ${time_label}
    List Selection Should Be          ${TIMEFRAME}     ${time_label}
    Sleep    2s

Loop Times And Check Indicators
    [Arguments]    @{time_labels}
    ${count}=    Get Length    ${time_labels}
    Run Keyword If    ${count} == 0    Set Test Variable    @{time_labels}    @{TIME_OPTIONS}

    FOR    ${time_label}    IN    @{time_labels}
        Select Time                   ${time_label}
        Scroll To                     ${INDICATOR}
        Check Texts In Box            ${INDICATOR}           @{INDICATOR_LIST}
        Scroll To                     ${Signals}
        Scroll To                     ${ADVANC_INDICATOR}
        Check Texts In Box            ${ADVANC_INDICATOR}    @{ADVANC_INDICATOR_LIST}
        Scroll To                     ${Signals}
        Execute Javascript            window.scrollTo(0,0)
    END

Loop Stocks Times And Check Indicators
    [Arguments]    @{symbols}
    FOR    ${symbol}    IN    @{symbols}
        Select Stock                  ${symbol}
        Loop Times And Check Indicators    @{TIME_OPTIONS}
    END


