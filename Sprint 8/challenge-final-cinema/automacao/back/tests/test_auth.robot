*** Settings ***
Resource    ../resources/keywords/auth_keywords.robot

*** Variables ***
${EMAIL_TEST}    teste@teste.com
${NOME_TEST}     Nome Teste
${SENHA_TEST}    Senha123

*** Test Cases ***

Registrar Usuario Com Dados Validos
    Criar Sessão da API
    ${response}=    Registrar Usuario Valido    ${NOME_TEST}    ${EMAIL_TEST}    ${SENHA_TEST}
    Should Be Equal As Integers    ${response.status_code}    201

Registrar Usuario Com Email Ja Cadastrado
    ${response}=    Registrar Usuario Email Existente    ${NOME_TEST}    ${EMAIL_TEST}    ${SENHA_TEST}
    Should Be Equal As Integers    ${response.status_code}    400

Registrar Usuario Com Dados Invalidos
    ${dados}=    Create Dictionary    name=    email=invalid    password=123
    ${response}=    Registrar Usuario Dados Invalidos    ${dados}
    Should Be Equal As Integers    ${response.status_code}    400

Autenticar Usuario Valido
    ${response}=    Autenticar Usuario Valido    ${EMAIL_TEST}    ${SENHA_TEST}
    Should Be Equal As Integers    ${response.status_code}    200
    ${token}=    Set Variable    ${response.json()['data']['token']}
    Atualizar Token    ${token}

Autenticar Usuario Inexistente
    ${response}=    Autenticar Usuario Inexistente    inexistente@teste.com    ${SENHA_TEST}
    Should Be Equal As Integers    ${response.status_code}    401

Autenticar Com Senha Incorreta
    ${response}=    Autenticar Senha Incorreta    ${EMAIL_TEST}    SenhaErrada
    Should Be Equal As Integers    ${response.status_code}    401

Visualizar Perfil Usuario Logado
    ${response}=    Visualizar Perfil Usuario Logado    ${AUTH_TOKEN}
    Should Be Equal As Integers    ${response.status_code}    200
