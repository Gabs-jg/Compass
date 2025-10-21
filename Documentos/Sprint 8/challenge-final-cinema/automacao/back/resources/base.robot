*** Settings ***
Documentation     Configurações base da automação de testes da API.
Library           RequestsLibrary
Library           JSONLibrary
Library           Collections
Library           OperatingSystem
Library           BuiltIn
Resource          variables.robot

*** Keywords ***
Criar Sessão da API
    [Documentation]    Cria a sessão inicial com a API, configurando cabeçalhos padrão.
    Create Session     api    ${BASE_URL}    headers=${DEFAULT_HEADERS}
    Log To Console     Sessão criada com a API: ${BASE_URL}

Encerrar Sessão da API
    [Documentation]    Encerra todas as sessões criadas durante a execução dos testes.
    Delete All Sessions
    Log To Console      Sessões encerradas com sucesso.
