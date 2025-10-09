*** Settings ***
Resource  ../base.robot

*** Keywords ***
Registrar Usuario Valido
    [Arguments]    ${nome}    ${email}    ${senha}
    &{body}=    Create Dictionary    name=${nome}    email=${email}    password=${senha}
    ${response}=    Post Request    api    /auth/register    json=${body}
    [Return]    ${response}

Registrar Usuario Email Existente
    [Arguments]    ${nome}    ${email}    ${senha}
    &{body}=    Create Dictionary    name=${nome}    email=${email}    password=${senha}
    ${response}=    Post Request    api    /auth/register    json=${body}
    [Return]    ${response}

Registrar Usuario Dados Invalidos
    [Arguments]    ${dados}
    ${response}=    Post Request    api    /auth/register    json=${dados}
    [Return]    ${response}

Autenticar Usuario Valido
    [Arguments]    ${email}    ${senha}
    &{body}=    Create Dictionary    email=${email}    password=${senha}
    ${response}=    Post Request    api    /auth/login    json=${body}
    [Return]    ${response}

Autenticar Usuario Inexistente
    [Arguments]    ${email}    ${senha}
    &{body}=    Create Dictionary    email=${email}    password=${senha}
    ${response}=    Post Request    api    /auth/login    json=${body}
    [Return]    ${response}

Autenticar Senha Incorreta
    [Arguments]    ${email}    ${senha}
    &{body}=    Create Dictionary    email=${email}    password=${senha}
    ${response}=    Post Request    api    /auth/login    json=${body}
    [Return]    ${response}

Visualizar Perfil Usuario Logado
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    Get Request    api    /auth/me    headers=${headers}
    [Return]    ${response}

Atualizar Token
    [Arguments]    ${token}
    Set Suite Variable    ${AUTH_TOKEN}    ${token}
    Set Suite Variable    ${AUTH_HEADER}   Authorization=Bearer ${token}
