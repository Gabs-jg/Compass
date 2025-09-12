*** Settings ***
Documentation  Keywords e variáveis para ações do endpoint login
Library        RequestsLibrary
Resource       ../support/base.robot

*** Variables ***
${email_para_login}  fulano@qa.com
${senha_para_login}  teste

*** Keywords ***
POST Endpoint /login
    [Arguments]     ${email}=${email_para_login}  ${password}=${senha_para_login}
    &{payload}      Create Dictionary  email=${email}  password=${password}
    ${response}=    POST On Session  serverest  ${LOGIN_ENDPOINT}  json=&{payload}  expected_status=any
    Log To Console  Response login: ${response.content}
    Set Global Variable  ${response}

Validar Ter Logado
    Should Be Equal      ${response.json()["message"]}  Login realizado com sucesso
    Should Not Be Empty  ${response.json()["authorization"]}

Fazer Login E Armazenar Token
    [Arguments]           ${email}=${email_para_login}  ${password}=${senha_para_login}
    POST Endpoint /login  ${email}  ${password}
    Validar Ter Logado
    ${token_auth}=        Set Variable  ${response.json()["authorization"]}
    Set Suite Variable    ${token_auth}
    Log To Console        Token salvo: ${token_auth}