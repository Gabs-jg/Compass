*** Settings ***
Documentation  Ações e elementos do componente de notificações
Library        Browser

*** Keywords ***
Notice should be
    [Arguments]  ${expected_text}
    ${element}   Set Variable  css=.notice p
    Wait For Elements State    css=.notice p  visible  5
    Get Text                   css=.notice p  equal    ${expected_text}