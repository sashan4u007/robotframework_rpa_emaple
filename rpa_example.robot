*** Settings ***
Library    RPA.Browser
Library    RPA.Excel.Files

*** Variables ***
${amazon}=    https://www.amazon.com/
${search_box}=    id:twotabsearchtextbox
${search_btn}=    xpath://*[@type="submit"]
${item_link}=    xpath://div[@class='sg-col-inner']//a[@class='a-link-normal a-text-normal']
${search_for}=    ${EMPTY}
${headless}=    ${False}

*** Tasks ***
Create Excel File With Search Items On Amazon
    [Documentation]    This Task is used to search for any item on amazon and create excel file of searched items.
    [Setup]    Open Browser And Maximize
    Input Text When Element Is Visible    ${search_box}    ${search_for}
    Click Button    ${search_btn}
    ${EXCEL_FILE}=    Set Variable    ${CURDIR}/${search_for}.xlsx
    Create Workbook    ${EXCEL_FILE}
    @{search_items_link}=    Get WebElements    ${item_link}
    ${count}=    Set Variable    ${1}
    FOR    ${search_item_link}    IN    @{search_items_link}
        Set Focus To Element    ${search_item_link}
        Sleep    1s
        ${camera_name}=    Get Text    ${search_item_link}
        Log To Console    ${camera_name}
        ${camera_link}=    Get Element Attribute    ${search_item_link}    href
        Log To Console    ${camera_link}
        Log To Console    ${count}
        &{row}=       Create Dictionary    Row No   ${count}    camera_name    ${camera_name}    camera_link    ${camera_link}
        Append Rows to Worksheet  ${row}  header=${TRUE}
        ${count}=    Evaluate    int(${count}+1)
    END
    Save Workbook
    [Teardown]    Close All Browsers

*** Keywords ***
Open Browser And Maximize
    Run Keyword If    ${headless}    Open Headless Chrome Browser    ${amazon}
    ...    ELSE    Open Chrome Browser    ${amazon}
    Maximize Browser Window
    Sleep    10s