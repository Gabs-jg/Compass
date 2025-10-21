*** Settings ***
Library    Browser
Library    BuiltIn
Resource   ../locators/locators_sessions.robot
Resource   ../variables.robot

*** Keywords ***
Acessar Detalhes Do Filme
    [Documentation]    Clica no botão "Ver detalhes" do primeiro filme e aguarda o container de sessões aparecer
    Wait For Elements State    ${MOVIE_DETAILS_BUTTON}    visible    10s
    Click    ${MOVIE_DETAILS_BUTTON}
    Wait For Elements State    ${SESSION_CONTAINER}    visible    10s

Validar Sessões Do Filme
    [Documentation]    Verifica se há sessões disponíveis ou a mensagem de ausência é exibida
    ${count}=    Get Element Count    ${SESSION_ITEM}
    Run Keyword If    ${count} > 0    Validar Lista De Sessoes
    ...    ELSE    Validar Mensagem De Nenhuma Sessao

Validar Lista De Sessoes
    [Documentation]    Verifica se os horários de sessão estão visíveis
    Wait For Elements State    ${SESSION_ITEM}    visible    10s

Validar Mensagem De Nenhuma Sessao
    [Documentation]    Verifica se a mensagem de ausência de sessões é exibida
    Wait For Elements State    ${NO_SESSIONS_MESSAGE}    visible    10s
    ${msg}=    Get Text    ${NO_SESSIONS_MESSAGE}
    Should Be Equal    ${msg}    Não há sessões disponíveis para este filme.
