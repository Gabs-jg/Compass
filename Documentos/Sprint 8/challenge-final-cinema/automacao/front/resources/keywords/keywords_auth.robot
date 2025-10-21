*** Settings ***
Library     Browser
Resource    ../locators/locators_auth.robot
Resource    ../variables.robot

*** Keywords ***
Preencher Formulario Registro
    [Arguments]    ${nome}    ${email}    ${senha}
    Wait For Elements State    ${REGISTER_NAME_INPUT}          visible    10s
    Fill Text                   ${REGISTER_NAME_INPUT}          ${nome}
    Fill Text                   ${REGISTER_EMAIL_INPUT}         ${email}
    Fill Text                   ${REGISTER_PASS_INPUT}          ${senha}
    Fill Text                   ${REGISTER_CONFIRM_PASS_INPUT}  ${senha}

Submeter Registro
    Click     ${REGISTER_BUTTON}
    Wait For Elements State    ${REGISTER_SUCCESS_MSG}    visible    10s

Submeter Registro Esperando Erro
    Click     ${REGISTER_BUTTON}
    Wait For Elements State    ${REGISTER_DUPLICATE_MSG}    visible    10s

Login Usuario
    [Arguments]    ${email}    ${senha}
    Wait For Elements State    ${LOGIN_EMAIL_INPUT}    visible    10s
    Fill Text    ${LOGIN_EMAIL_INPUT}    ${email}
    Fill Text    ${LOGIN_PASS_INPUT}     ${senha}
    Click        ${LOGIN_BUTTON}
    Wait For Elements State    ${LOGOUT_BUTTON}    visible    10s

Login Usuario Incorreto
    [Arguments]    ${email}    ${senha}
    Wait For Elements State    ${LOGIN_EMAIL_INPUT}    visible    10s
    Fill Text    ${LOGIN_EMAIL_INPUT}    ${email}
    Fill Text    ${LOGIN_PASS_INPUT}     ${senha}
    Click        ${LOGIN_BUTTON}
    Wait For Elements State    ${LOGIN_BUTTON}    visible    10s

Logout Usuario
    Click        ${LOGOUT_BUTTON}
    Wait For Elements State    ${LOGOUT_BUTTON}    hidden    10s
