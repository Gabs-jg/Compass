*** Settings ***
Library    Browser
Library    BuiltIn
Resource   ../resources/keywords/keywords_sessions.robot

*** Test Cases ***
US-SESSION-001 Visualizar Horários Disponíveis Para Um Filme
    [Documentation]    Verifica se ao acessar os detalhes de um filme são exibidas as sessões disponíveis ou a mensagem de ausência
    New Browser    chromium
    New Page    ${BASE_URL}/movies
    Acessar Detalhes Do Filme
    Validar Sessões Do Filme
    Close Browser
