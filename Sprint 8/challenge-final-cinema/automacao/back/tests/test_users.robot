*** Settings ***
Resource    ../resources/keywords/users_keywords.robot
Resource    ../resources/keywords/auth_keywords.robot

*** Variables ***
${ADMIN_EMAIL}       admin@example.com
${ADMIN_PASSWORD}    admin123

*** Test Cases ***
Preparar Admin
    Criar Sessão da API
    ${response}=    Autenticar Usuario Valido    ${ADMIN_EMAIL}    ${ADMIN_PASSWORD}
    Should Be Equal As Integers    ${response.status_code}    200
    ${token}=    Set Variable    ${response.json()['data']['token']}
    Atualizar Token    ${token}

Criar Usuario Para Teste
    ${payload}=    Create Dictionary    name=Usuario Teste    email=teste_user@example.com    password=123456
    ${response}=    Criar Usuario    ${payload}    ${AUTH_TOKEN}
    Should Be Equal As Integers    ${response.status_code}    201
    ${USER_ID}=    Set Suite Variable    ${response.json()['data']['_id']}

Listar Todos Usuarios
    ${response}=    Listar Todos Usuarios    ${AUTH_TOKEN}
    Should Be Equal As Integers    ${response.status_code}    200

Atualizar Usuario Existente
    ${dados}=    Create Dictionary    name=Nome Atualizado
    ${response}=    Atualizar Usuario Existente    ${USER_ID}    ${dados}    ${AUTH_TOKEN}
    Should Be Equal As Integers    ${response.status_code}    200

Deletar Usuario Existente
    ${response}=    Deletar Usuario Existente    ${USER_ID}    ${AUTH_TOKEN}
    Should Be Equal As Integers    ${response.status_code}    200

Encerrar Sessao
    Encerrar Sessão da API
