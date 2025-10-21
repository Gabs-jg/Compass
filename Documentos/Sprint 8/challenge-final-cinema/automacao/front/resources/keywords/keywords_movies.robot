*** Settings ***
Library    Browser
Library    BuiltIn
Resource   ../locators/locators_movies.robot
Resource   ../variables.robot

*** Keywords ***
Acessar Lista Filmes
    [Documentation]    Acessa a página de filmes e verifica se a lista ou mensagem de erro é exibida
    Wait For Elements State    ${MOVIE_GRID}    visible    10s
    ${count}=    Get Element Count    ${MOVIE_CARD}
    Run Keyword If    ${count} > 0    Set Variable    PASS
    Run Keyword If    ${count} == 0    Set Variable    FAIL
    RETURN    ${count}

Validar Lista De Filmes
    [Documentation]    Verifica se a lista de filmes está visível
    Wait For Elements State    ${MOVIE_GRID}    visible    10s
    ${count}=    Get Element Count    ${MOVIE_CARD}
    Should Be True    ${count} > 0    msg=Nenhum filme encontrado

Validar Mensagem De Erro Filmes
    [Documentation]    Verifica se mensagem de erro é exibida
    Wait For Elements State    ${ERROR_MESSAGE}    visible    10s

Visualizar Detalhes Filme
    [Documentation]    Clica no primeiro filme e verifica se os detalhes aparecem
    Wait For Elements State    ${MOVIE_CARD}    visible    10s
    Click    ${MOVIE_CARD}
    Wait For Elements State    ${MOVIE_DETAILS}    visible    10s
    ${titulo}=    Get Text    ${MOVIE_DETAILS_TITLE}
    Log    Detalhes do filme exibidos: ${titulo}
