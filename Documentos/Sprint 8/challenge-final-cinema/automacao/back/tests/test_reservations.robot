*** Settings ***
Resource    ../resources/keywords/reservations_keywords.robot
Resource    ../resources/keywords/auth_keywords.robot

*** Variables ***
${RESERVATION_ID}    None
${USER_EMAIL}        user@example.com
${USER_PASSWORD}     user123
${ADMIN_EMAIL}       admin@example.com
${ADMIN_PASSWORD}    admin123

*** Keywords ***
Criar Usuario Se Não Existir
    [Arguments]    ${email}    ${senha}    ${role}=user
    Criar Sessão da API
    ${payload}=    Create Dictionary    email=${email}    password=${senha}    role=${role}
    ${response}=   POST On Session    api    /auth/register    json=${payload}
    Run Keyword If    '${response.status_code}' != '201'    Log To Console    Usuário já existe
    Encerrar Sessão da API

Login Usuario
    [Arguments]    ${email}    ${senha}
    Criar Sessão da API
    ${response}=    Autenticar Usuario Valido    ${email}    ${senha}
    Should Be Equal As Integers    ${response.status_code}    200
    ${token}=    Set Variable    ${response.json()['data']['token']}
    Atualizar Token    ${token}
    Encerrar Sessão da API
    [Return]    ${token}

*** Test Cases ***
Criar Reserva
    [Documentation]    Usuário comum cria uma nova reserva
    Criar Usuario Se Não Existir    ${USER_EMAIL}    ${USER_PASSWORD}
    ${token}=    Login Usuario    ${USER_EMAIL}    ${USER_PASSWORD}

    Criar Sessão da API
    ${payload}=    Create Dictionary    session_id=1    assentos=[1,2]
    ${response}=    Criar Reserva    ${payload}    ${token}
    Should Be Equal As Integers    ${response.status_code}    201
    ${RESERVATION_ID}=    Set Suite Variable    ${response.json()['data']['_id']}
    Encerrar Sessão da API

Visualizar Minhas Reservas
    [Documentation]    Usuário comum lista suas reservas
    ${token}=    Login Usuario    ${USER_EMAIL}    ${USER_PASSWORD}
    Criar Sessão da API
    ${response}=    Visualizar Minhas Reservas    ${token}
    Should Be Equal As Integers    ${response.status_code}    200
    Encerrar Sessão da API

Atualizar Status da Reserva
    [Documentation]    Admin atualiza o status da reserva
    ${token}=    Login Usuario    ${ADMIN_EMAIL}    ${ADMIN_PASSWORD}
    Criar Sessão da API
    ${payload}=    Create Dictionary    status=confirmada
    ${response}=    Atualizar Status Da Reserva    ${RESERVATION_ID}    ${payload}    ${token}
    Should Be Equal As Integers    ${response.status_code}    200
    Encerrar Sessão da API

Deletar Reserva
    [Documentation]    Admin deleta a reserva criada
    ${token}=    Login Usuario    ${ADMIN_EMAIL}    ${ADMIN_PASSWORD}
    Criar Sessão da API
    ${response}=    Deletar Reserva    ${RESERVATION_ID}    ${token}
    Should Be Equal As Integers    ${response.status_code}    200
    Encerrar Sessão da API
