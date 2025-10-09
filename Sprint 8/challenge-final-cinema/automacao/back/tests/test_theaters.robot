*** Settings ***
Resource    ../resources/keywords/theaters_keywords.robot

*** Test Cases ***
Listar Todos Teatros
    ${token}=    Set Variable    ${AUTH_TOKEN}
    ${response}=    Listar Todos Teatros    ${token}
    Should Be Equal As Integers    ${response.status_code}    200

Criar Teatro
    ${token}=    Set Variable    ${AUTH_TOKEN}
    ${dados}=    Create Dictionary    name=Teatro Teste    location=Cidade X
    ${response}=    Criar Teatro    ${dados}    ${token}
    Should Be Equal As Integers    ${response.status_code}    201

Visualizar Detalhes Teatro
    ${token}=    Set Variable    ${AUTH_TOKEN}
    ${theater_id}=    Set Variable  1
    ${response}=    Visualizar Detalhes Teatro    ${theater_id}    ${token}
    Should Be Equal As Integers    ${response.status_code}    200

Atualizar Teatro Existente
    ${token}=    Set Variable    ${AUTH_TOKEN}
    ${theater_id}=    Set Variable  1
    ${dados}=    Create Dictionary    name=Teatro Atualizado
    ${response}=    Atualizar Teatro Existente    ${theater_id}    ${dados}    ${token}
    Should Be Equal As Integers    ${response.status_code}    200

Deletar Teatro Existente
    ${token}=    Set Variable    ${AUTH_TOKEN}
    ${theater_id}=    Set Variable  1
    ${response}=    Deletar Teatro Existente    ${theater_id}    ${token}
    Should Be Equal As Integers    ${response.status_code}    200
