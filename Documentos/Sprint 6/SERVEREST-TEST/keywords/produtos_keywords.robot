*** Settings ***
Documentation  Keywords e variáveis para ações do endpoint produtos
Library        RequestsLibrary
Resource       ../support/base.robot
Resource       login_keywords.robot

*** Keywords ***
POST Endpoint /produtos
    [Arguments]          ${payload}  ${token}=${token_auth}
    &{header}            Create Dictionary  Authorization=${token}
    ${response}=         POST On Session  serverest  ${PRODUTOS_ENDPOINT}  json=${payload}  headers=&{header}
    Log To Console       POST /produtos response: ${response.content}
    Set Global Variable  ${response}

DELETE Endpoint /produtos
    [Arguments]          ${id}  ${token}=${token_auth}
    &{header}            Create Dictionary  Authorization=${token}
    ${response}=         DELETE On Session  serverest  ${PRODUTOS_ENDPOINT}/${id}  headers=&{header}
    Log To Console       DELETE /produtos/${id} response: ${response.content}
    Set Global Variable  ${response}

Validar Ter Criado Produto
    Should Be Equal      ${response.json()["message"]}  Cadastro realizado com sucesso
    Should Not Be Empty  ${response.json()["_id"]}

Criar Um Produto E Armazenar id
    [Arguments]  ${payload}  ${token}=${token_auth}
    POST Endpoint /produtos  ${payload}  ${token}
    Validar Ter Criado Produto
    ${id_produto}=     Set Variable  ${response.json()["_id"]}
    Set Test Variable  ${id_produto}
    Log To Console     ID Produto: ${id_produto}

POST Produto Sem Token
    [Arguments]  ${payload}
    ${response}=  RequestsLibrary.Post On Session  serverest  /produtos  json=${payload}
    [Return]  ${response}