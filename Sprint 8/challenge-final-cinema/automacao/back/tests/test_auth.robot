*** Settings ***
Resource    ../resources/keywords/auth_keywords.robot

*** Variables ***
${TOKEN}  None

*** Test Cases ***
Registrar Usuario Com Dados Validos
    ${response}=    Registrar Usuario Valido    Nome Teste    teste@teste.com    Senha123
    Should Be Equal As Integers    ${response.status_code}    201

Registrar Usuario Com Email Ja Cadastrado
    ${response}=    Registrar Usuario Email Existente    Nome Teste    teste@teste.com    Senha123
    Should Be Equal As Integers    ${response.status_code}    400

Registrar Usuario Com Dados Invalidos
    ${dados}=    Create Dictionary    name=    email=invalid    password=123
    ${response}=    Registrar Usuario Dados Invalidos    ${dados}
    Should Be Equal As Integers    ${response.status_code}    400

Autenticar Usuario Valido
    ${response}=    Autenticar Usuario Valido    teste@teste.com    Senha123
    Should Be Equal As Integers    ${response.status_code}    200
    ${TOKEN}=    Set Suite Variable    ${response.json()['token']}

Autenticar Usuario Inexistente
    ${response}=    Autenticar Usuario Inexistente    inexistente@teste.com    Senha123
    Should Be Equal As Integers    ${response.status_code}    401

Autenticar Com Senha Incorreta
    ${response}=    Autenticar SenhaIncorreta    teste@teste.com    SenhaErrada
    Should Be Equal As Integers    ${response.status_code}    401

Visualizar Perfil Usuario Logado
    ${response}=    Visualizar Perfil UsuarioLogado    ${TOKEN}
    Should Be Equal As Integers    ${response.status_code}    200
