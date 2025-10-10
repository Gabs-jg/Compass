*** Settings ***
Resource    ../resources/keywords/movies_keywords.robot
Resource    ../resources/keywords/auth_keywords.robot

*** Variables ***
${MOVIE_TITLE}      Filme Teste
${MOVIE_DIRECTOR}   Diretor X
${MOVIE_YEAR}       2025
${MOVIE_ID}         None

*** Test Cases ***
Login Admin
    [Documentation]    Autentica o usuário admin e atualiza o token global
    Criar Sessão da API
    ${response}=    Autenticar Usuario Valido    admin@example.com    admin123
    Should Be Equal As Integers    ${response.status_code}    200
    ${token}=    Set Variable    ${response.json()['data']['token']}
    Atualizar Token    ${token}

Criar Filme
    [Documentation]    Cria um novo filme usando o token do admin
    ${dados}=    Create Dictionary    title=${MOVIE_TITLE}    director=${MOVIE_DIRECTOR}    year=${MOVIE_YEAR}
    ${response}=    Criar Filme    ${dados}    ${AUTH_TOKEN}
    Should Be Equal As Integers    ${response.status_code}    201
    ${movie_id}=    Set Suite Variable    ${response.json()['data']['_id']}

Visualizar Detalhes Filme
    [Documentation]    Visualiza os detalhes do filme criado
    ${response}=    Visualizar Detalhes Filme    ${movie_id}    ${AUTH_TOKEN}
    Should Be Equal As Integers    ${response.status_code}    200

Listar Todos Filmes
    [Documentation]    Lista todos os filmes usando o token do admin
    ${response}=    Listar Todos Filmes    ${AUTH_TOKEN}
    Should Be Equal As Integers    ${response.status_code}    200

Atualizar Filme
    [Documentation]    Atualiza os dados de um filme existente
    ${dados}=    Create Dictionary    title=Filme Atualizado    director=Diretor Y    year=2026
    ${response}=    Atualizar Filme    ${movie_id}    ${dados}    ${AUTH_TOKEN}
    Should Be Equal As Integers    ${response.status_code}    200

Deletar Filme
    [Documentation]    Deleta o filme criado
    ${response}=    Deletar Filme    ${movie_id}    ${AUTH_TOKEN}
    Should Be Equal As Integers    ${response.status_code}    204
