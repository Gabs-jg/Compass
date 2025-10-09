*** Settings ***
Resource    ../resources/keywords/movies_keywords.robot

*** Test Cases ***
Listar Todos Filmes
    ${token}=    Set Variable    ${AUTH_TOKEN}
    ${response}=    Listar Todos Filmes    ${token}
    Should Be Equal As Integers    ${response.status_code}    200

Criar Filme
    ${token}=    Set Variable    ${AUTH_TOKEN}
    ${dados}=    Create Dictionary    title=Filme Teste    director=Diretor X    year=2025
    ${response}=    Criar Filme    ${dados}    ${token}
    Should Be Equal As Integers    ${response.status_code}    201

Visualizar Detalhes Filme
    ${token}=    Set Variable    ${AUTH_TOKEN}
    ${movie_id}=    Set Variable  1
    ${response}=    Visualizar Detalhes Filme    ${movie_id}    ${token}
    Should Be Equal As Integers    ${response.status_code}    200

Atualizar Filme Existente
    ${token}=    Set Variable    ${AUTH_TOKEN}
    ${movie_id}=    Set Variable  1
    ${dados}=    Create Dictionary    title=Filme Atualizado
    ${response}=    Atualizar Filme Existente    ${movie_id}    ${dados}    ${token}
    Should Be Equal As Integers    ${response.status_code}    200

Deletar Filme Existente
    ${token}=    Set Variable    ${AUTH_TOKEN}
    ${movie_id}=    Set Variable  1
    ${response}=    Deletar Filme Existente    ${movie_id}    ${token}
    Should Be Equal As Integers    ${response.status_code}    200
