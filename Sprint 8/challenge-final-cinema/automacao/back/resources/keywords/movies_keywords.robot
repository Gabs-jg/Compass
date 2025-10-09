*** Settings ***
Resource    ../base.robot

*** Keywords ***
Listar Todos Filmes
    [Arguments]    ${token}
    ${response}=    GET On Session    api    /movies    headers=${{"Authorization": "Bearer ${token}"}}
    [Return]    ${response}

Criar Filme
    [Arguments]    ${dados}    ${token}
    ${response}=    POST On Session    api    /movies    json=${dados}    headers=${{"Authorization": "Bearer ${token}"}}
    [Return]    ${response}

Visualizar Detalhes Filme
    [Arguments]    ${movie_id}    ${token}
    ${response}=    GET On Session    api    /movies/${movie_id}    headers=${{"Authorization": "Bearer ${token}"}}
    [Return]    ${response}

Atualizar Filme Existente
    [Arguments]    ${movie_id}    ${dados}    ${token}
    ${response}=    PUT On Session    api    /movies/${movie_id}    json=${dados}    headers=${{"Authorization": "Bearer ${token}"}}
    [Return]    ${response}

Deletar Filme Existente
    [Arguments]    ${movie_id}    ${token}
    ${response}=    DELETE On Session    api    /movies/${movie_id}    headers=${{"Authorization": "Bearer ${token}"}}
    [Return]    ${response}
