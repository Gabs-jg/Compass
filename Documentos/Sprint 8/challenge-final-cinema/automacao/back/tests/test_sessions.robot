*** Settings ***
Resource    ../resources/keywords/sessions_keywords.robot

*** Test Cases ***
Listar Todas as Sessões
    ${response}=    Listar Todas as Sessões
    Should Be Equal As Integers    ${response.status_code}    200

Criar Sessão
    ${payload}=    Create Dictionary    movie_id=1    theater_id=1    horario=2025-10-10T20:00:00
    ${response}=    Criar Sessão    ${payload}    ${AUTH_TOKEN}
    Should Be Equal As Integers    ${response.status_code}    201

Visualizar Detalhes da Sessão
    ${session_id}=    Set Variable    1
    ${response}=    Visualizar Detalhes da Sessão    ${session_id}
    Should Be Equal As Integers    ${response.status_code}    200

Atualizar Sessão
    ${session_id}=    Set Variable    1
    ${payload}=    Create Dictionary    movie_id=1    theater_id=1    horario=2025-10-11T20:00:00
    ${response}=    Atualizar Sessão    ${session_id}    ${payload}    ${AUTH_TOKEN}
    Should Be Equal As Integers    ${response.status_code}    200

Deletar Sessão
    ${session_id}=    Set Variable    1
    ${response}=    Deletar Sessão    ${session_id}    ${AUTH_TOKEN}
    Should Be Equal As Integers    ${response.status_code}    200
