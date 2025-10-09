*** Settings ***
Resource    ../base.robot

*** Keywords ***
Listar Todos Teatros
    [Arguments]    ${token}
    ${response}=    GET On Session    api    /theaters    headers=${{"Authorization": "Bearer ${token}"}}
    [Return]    ${response}

Criar Teatro
    [Arguments]    ${dados}    ${token}
    ${response}=    POST On Session    api    /theaters    json=${dados}    headers=${{"Authorization": "Bearer ${token}"}}
    [Return]    ${response}

Visualizar Detalhes Teatro
    [Arguments]    ${theater_id}    ${token}
    ${response}=    GET On Session    api    /theaters/${theater_id}    headers=${{"Authorization": "Bearer ${token}"}}
    [Return]    ${response}

Atualizar Teatro Existente
    [Arguments]    ${theater_id}    ${dados}    ${token}
    ${response}=    PUT On Session    api    /theaters/${theater_id}    json=${dados}    headers=${{"Authorization": "Bearer ${token}"}}
    [Return]    ${response}

Deletar Teatro Existente
    [Arguments]    ${theater_id}    ${token}
    ${response}=    DELETE On Session    api    /theaters/${theater_id}    headers=${{"Authorization": "Bearer ${token}"}}
    [Return]    ${response}
