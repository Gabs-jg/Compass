*** Settings ***
Library    Browser
Library    BuiltIn
Resource   ../locators/locators_reservations.robot
Resource   ../variables.robot

*** Keywords ***
Login Usuario
    [Arguments]    ${email}    ${senha}
    [Documentation]    Realiza login do usuário
    Fill Text    ${LOGIN_EMAIL}    ${email}
    Fill Text    ${LOGIN_PASSWORD}    ${senha}
    Click        ${LOGIN_BUTTON}
    Wait For Elements State    ${MY_RESERVATIONS_BUTTON}    visible    10s
    Click        ${MY_RESERVATIONS_BUTTON}

Acessar Lista De Reservas
    [Documentation]    Espera a lista de reservas carregar
    Wait For Elements State    ${RESERVATION_LIST}    visible    10s

Criar Nova Reserva
    [Arguments]    ${nome}    ${filme}    ${sessao}
    Click    ${CREATE_RESERVATION_BUTTON}
    Fill Text    css=input[name="nome"]    ${nome}
    Fill Text    css=input[name="filme"]    ${filme}
    Fill Text    css=input[name="sessao"]    ${sessao}
    Click    css=button.submit-reservation
    Wait For Elements State    ${SUCCESS_MESSAGE}    visible    10s
    ${msg}=    Get Text    ${SUCCESS_MESSAGE}
    Should Contain    ${msg}    Sucesso

Atualizar Status Da Reserva
    [Arguments]    ${index}    ${novo_status}
    Wait For Elements State    ${UPDATE_STATUS_BUTTON}    visible    10s    index=${index}
    Click    ${UPDATE_STATUS_BUTTON}[${index}]
    Fill Text    css=input[name="status"]    ${novo_status}
    Click    css=button.submit-status
    Wait For Elements State    ${SUCCESS_MESSAGE}    visible    10s

Deletar Reserva
    [Arguments]    ${index}
    Wait For Elements State    ${DELETE_RESERVATION_BUTTON}    visible    10s    index=${index}
    Click    ${DELETE_RESERVATION_BUTTON}[${index}]
    Wait For Elements State    ${SUCCESS_MESSAGE}    visible    10s
