*** Settings ***
Resource    ../resources/keywords/users_keywords.robot

*** Test Cases ***
Listar Todos Usuarios
    ${token}=    Set Variable    ${AUTH_TOKEN}    # token deve vir do login
    ${response}=    Listar Todos Usuarios    ${token}
    Should Be Equal As Integers    ${response.status_code}    200

Atualizar Usuario Existente
    ${token}=    Set Variable    ${AUTH_TOKEN}
    ${dados}=    Create Dictionary    name=Nome Atualizado
    ${user_id}=    Set Variable  1
    ${response}=    Atualizar Usuario Existente    ${user_id}    ${dados}    ${token}
    Should Be Equal As Integers    ${response.status_code}    200

Deletar Usuario Existente
    ${token}=    Set Variable    ${AUTH_TOKEN}
    ${user_id}=    Set Variable  1
    ${response}=    Deletar Usuario Existente    ${user_id}    ${token}
    Should Be Equal As Integers    ${response.status_code}    200
