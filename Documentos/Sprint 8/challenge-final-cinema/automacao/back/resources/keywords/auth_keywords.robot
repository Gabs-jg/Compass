*** Settings ***
Resource    ../base.robot

*** Keywords ***
Registrar Usuario Valido
    [Arguments]    ${nome}    ${email}    ${senha}
    &{body}=    Create Dictionary    name=${nome}    email=${email}    password=${senha}
    ${response}=    POST On Session    api    /auth/register    json=${body}    expected_status=201
    Log To Console    Registrando usuário válido: ${email}
    RETURN    ${response}   # substitui [Return]

Registrar Usuario Email Existente
    [Arguments]    ${nome}    ${email}    ${senha}
    &{body}=    Create Dictionary    name=${nome}    email=${email}    password=${senha}
    ${response}=    POST On Session    api    /auth/register    json=${body}    expected_status=400   # <--- ADICIONADO
    Log To Console    Tentando registrar e-mail existente: ${email}
    RETURN    ${response}

Registrar Usuario Dados Invalidos
    [Arguments]    ${dados}
    ${response}=    POST On Session    api    /auth/register    json=${dados}    expected_status=400   # <--- ADICIONADO
    Log To Console    Registrando usuário com dados inválidos
    RETURN    ${response}

Autenticar Usuario Valido
    [Arguments]    ${email}    ${senha}
    &{body}=    Create Dictionary    email=${email}    password=${senha}
    ${response}=    POST On Session    api    /auth/login    json=${body}    expected_status=200
    Log To Console    Autenticando usuário válido: ${email}
    RETURN    ${response}

Autenticar Usuario Inexistente
    [Arguments]    ${email}    ${senha}
    &{body}=    Create Dictionary    email=${email}    password=${senha}
    ${response}=    POST On Session    api    /auth/login    json=${body}    expected_status=401   # <--- ADICIONADO
    Log To Console    Tentando autenticar usuário inexistente: ${email}
    RETURN    ${response}

Autenticar Senha Incorreta
    [Arguments]    ${email}    ${senha}
    &{body}=    Create Dictionary    email=${email}    password=${senha}
    ${response}=    POST On Session    api    /auth/login    json=${body}    expected_status=401   # <--- ADICIONADO
    Log To Console    Tentando autenticar com senha incorreta: ${email}
    RETURN    ${response}

Visualizar Perfil Usuario Logado
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET On Session    api    /auth/me    headers=${headers}    expected_status=200
    Log To Console    Visualizando perfil do usuário logado
    RETURN    ${response}

Atualizar Token
    [Arguments]    ${token}
    Set Suite Variable    ${AUTH_TOKEN}    ${token}
    Set Suite Variable    ${AUTH_HEADER}    Authorization=Bearer ${token}
