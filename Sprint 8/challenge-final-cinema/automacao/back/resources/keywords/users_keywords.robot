*** Settings ***
Resource    ../base.robot

*** Keywords ***
Listar Todos Usuarios
    [Arguments]    ${token}
    ${response}=    GET On Session    api    /users    headers=${{"Authorization": "Bearer ${token}"}}
    [Return]    ${response}

Atualizar Usuario Existente
    [Arguments]    ${user_id}    ${dados}    ${token}
    ${response}=    PUT On Session    api    /users/${user_id}    json=${dados}    headers=${{"Authorization": "Bearer ${token}"}}
    [Return]    ${response}

Deletar Usuario Existente
    [Arguments]    ${user_id}    ${token}
    ${response}=    DELETE On Session    api    /users/${user_id}    headers=${{"Authorization": "Bearer ${token}"}}
    [Return]    ${response}
