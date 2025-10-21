*** Settings ***
Library    Browser
Library    BuiltIn
Resource   ../resources/keywords/keywords_movies.robot

*** Test Cases ***
US-MOVIE-001 Exibir Lista de Filmes Disponíveis
    [Documentation]    Verifica se a lista de filmes é exibida corretamente na página
    [Tags]    critical    movie
    New Browser    chromium
    New Page    ${BASE_URL}/movies
    ${status}=    Acessar Lista Filmes
    Run Keyword If    '${status}' == 'PASS'    Validar Lista De Filmes
    Run Keyword If    '${status}' == 'FAIL'    Validar Mensagem De Erro Filmes
    Close Browser

US-MOVIE-002 Visualizar Detalhes de um Filme
    [Documentation]    Valida a visualização dos detalhes de um filme
    [Tags]    movie
    New Browser    chromium
    New Page    ${BASE_URL}/movies
    ${status}=    Acessar Lista Filmes
    Run Keyword If    '${status}' == 'PASS'    Visualizar Detalhes Filme
    Run Keyword If    '${status}' == 'FAIL'    Validar Mensagem De Erro Filmes
    Close Browser
