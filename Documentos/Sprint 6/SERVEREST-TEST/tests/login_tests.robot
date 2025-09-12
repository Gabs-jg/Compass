*** Settings ***
Documentation  Testes do endpoint /login (US002)
Resource       ../keywords/login_keywords.robot
Resource    ../keywords/usuarios_keywords.robot
Suite Setup    Criar Sessao

*** Test Cases ***
Cenário - POST Realizar Login Com Usuário Válido 200
    [TAGS]  POSTLOGIN  smoke
    ${email}=  Gerar Email Unico

    # Criar usuário válido
    Criar Dados Usuario Com Email    ${email}
    ${response}=   POST On Session   serverest   ${USUARIOS_ENDPOINT}   json=${payload}   expected_status=201
    Log To Console    Usuário criado: ${response.json()}

    # Realizar login
    &{login_payload}=    Create Dictionary    email=${email}    password=${DEFAULT_PASSWORD}
    ${login_response}=   POST On Session   serverest   ${LOGIN_ENDPOINT}   json=&{login_payload}   expected_status=200
    Log To Console    Response login: ${login_response.json()}

    # Validar status code
    Should Be Equal As Integers    ${login_response.status_code}    200

    # Validar se conseguiu logar (opcional, caso tenha token)
    ${token}=    Set Variable    ${login_response.json()["authorization"]}
    Run Keyword If    '${token}' != ''    Log To Console    Login realizado com sucesso, token: ${token}

Cenario - POST Login Usuário Inexistente 401
    [TAGS]  POSTLOGIN  regressao
    POST Endpoint /login  naoexiste@qa.com  senhaqualquer
    Validar Status Code "401"

Cenário - POST Login Senha Inválida 401
    [Tags]    POSTLOGIN    regressao
    ${payload}=    Criar Dados Usuario Valido
    POST Endpoint /usuarios    ${payload}
    Validar Status Code "201"
    ${email}=    Set Variable    ${payload["email"]}
    ${senha_incorreta}=    Set Variable    senhaerrada123
    POST Endpoint /login    ${email}    ${senha_incorreta}
    Validar Status Code "401"

