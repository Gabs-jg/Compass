*** Settings ***
Resource  ../base.robot

*** Keywords ***
Criar Filme
    [Arguments]    ${dados}    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}    Content-Type=application/json
    ${response}=   POST On Session    api    /movies    json=${dados}    headers=${headers}
    Log To Console    Criando filme: ${dados['title']}
    RETURN    ${response}

Visualizar Detalhes Filme
    [Arguments]    ${movie_id}    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}    Content-Type=application/json
    ${response}=   GET On Session    api    /movies/${movie_id}    headers=${headers}
    Log To Console    Visualizando detalhes do filme: ${movie_id}
    RETURN    ${response}

Listar Todos Filmes
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}    Content-Type=application/json
    ${response}=   GET On Session    api    /movies    headers=${headers}
    Log To Console    Listando todos os filmes
    RETURN    ${response}

Atualizar Filme
    [Arguments]    ${movie_id}    ${dados}    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}    Content-Type=application/json
    ${response}=   PUT On Session    api    /movies/${movie_id}    json=${dados}    headers=${headers}
    Log To Console    Atualizando filme: ${movie_id}
    RETURN    ${response}

Deletar Filme
    [Arguments]    ${movie_id}    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}    Content-Type=application/json
    ${response}=   DELETE On Session    api    /movies/${movie_id}    headers=${headers}
    Log To Console    Deletando filme: ${movie_id}
    RETURN    ${response}
