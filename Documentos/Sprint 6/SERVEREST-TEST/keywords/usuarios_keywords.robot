*** Settings ***
Documentation  Keywords e variáveis para ações do endpoint usuarios
Library        RequestsLibrary
Resource       ../support/base.robot

*** Keywords ***
GET Endpoint /usuarios
    ${response}=         GET On Session  serverest  ${USUARIOS_ENDPOINT}
    Log To Console       GET /usuarios response: ${response.content}
    Set Global Variable  ${response}

POST Endpoint /usuarios
    [Arguments]          ${payload}
    ${response}=         POST On Session  serverest  ${USUARIOS_ENDPOINT}  json=${payload}
    Log To Console       POST /usuarios response: ${response.content}
    Set Global Variable  ${response}

PUT Endpoint /usuarios
    [Arguments]          ${id}  ${payload}
    ${response}=         PUT On Session  serverest  ${USUARIOS_ENDPOINT}/${id}  json=${payload}
    Log To Console       PUT /usuarios/${id} response: ${response.content}
    Set Global Variable  ${response}

DELETE Endpoint /usuarios
    [Arguments]          ${id}
    ${response}=         DELETE On Session  serverest  ${USUARIOS_ENDPOINT}/${id}
    Log To Console       Delete /usuarios/${id}  response: ${response.content}
    Set Global Variable  ${response}

Validar Usuario Criado
    Should Not Be Empty  ${response.json()["_id"]}
    Should Be Equal      ${response.json()["message"]}  Cadastro realizado com sucesso