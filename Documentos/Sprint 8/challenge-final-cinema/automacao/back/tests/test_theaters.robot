*** Settings ***
Resource    ../resources/keywords/theaters_keywords.robot

*** Test Cases ***
Listar Todos Teatros
    ${response}=    Listar Todos Teatros    ${AUTH_TOKEN}
    Should Be Equal As Integers    ${response.status_code}    200

Criar Teatro
    ${dados}=    Create Dictionary    name=Teatro Teste    location=Cidade X
    ${response}=    Criar Teatro    ${dados}    ${AUTH_TOKEN}
    Should Be Equal As Integers    ${response.status_code}    201

Visualizar Detalhes Teatro
    ${theater_id}=    Set Variable    1
    ${response}=    Visualizar Detalhes Teatro    ${theater_id}    ${AUTH_TOKEN}
    Should Be Equal As Integers    ${response.status_code}    200

Atualizar Teatro Existente
    ${theater_id}=    Set Variable    1
    ${dados}=    Create Dictionary    name=Teatro Atualizado
    ${response}=    Atualizar Teatro Existente    ${theater_id}    ${dados}    ${AUTH_TOKEN}
    Should Be Equal As Integers    ${response.status_code}    200

Deletar Teatro Existente
    ${theater_id}=    Set Variable    1
    ${response}=    Deletar Teatro Existente    ${theater_id}    ${AUTH_TOKEN}
    Should Be Equal As Integers    ${response.status_code}    200
