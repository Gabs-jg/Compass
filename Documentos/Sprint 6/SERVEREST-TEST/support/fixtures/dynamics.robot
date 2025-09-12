*** Settings ***
Documentation  Fixtures que geram massa dinamicamente
Library   FakerLibrary
Resource  ../variables/serverest_variables.robot

*** Keywords ***
Criar Dados Usuario Valido
    ${nome}         FakerLibrary.Name
    ${email}        FakerLibrary.Email
    ${password}     Set Variable  ${DEFAULT_PASSWORD}
    ${payload}      Create Dictionary  nome=${nome}  email=${email}  password=${password}  administrador=${DEFAULT_ADMIN}
    Log To Console  Dados de usuário gerados: ${payload}
    [Return]  ${payload}

Criar Dados Usuario Com Email
    [Arguments]        ${email}
    ${nome}            FakerLibrary.Name
    ${payload}         Create Dictionary  nome=${nome}  email=${email}  password=${DEFAULT_PASSWORD}  administrador=${DEFAULT_ADMIN}
    Set Test Variable  ${payload}

Criar Dados Produto Valido
    ${nome}            FakerLibrary.Word
    ${preco}           Set Variable  100
    ${descricao}       Set Variable  Produto automatizado
    ${quantidade}      Set Variable  10
    ${payload}         Create Dictionary  nome=${nome}  preco=${preco}  descricao=${descricao}  quantidade=${quantidade}
    Log To Console     Dados do produto: ${payload}
    [Return]  ${payload}